local interactions = {}
local radio = peripheral.find("radio_tower")
local modem = peripheral.find("modem",function (s) return peripheral.wrap(s).isWireless() end)
local distancemap = {}
local clients = {}
local message_queue = {}

local heartbeat_entrypoint = false
local heartbeat_entrypoint_filter = -1

local function queue_message(msg, target)
    table.insert(message_queue,#message_queue+1, {msg,target})
end
local function dequeue_message()
    return table.unpack(table.remove(message_queue,1) or {})
end

local function entrypoint_recieving(channel, msg)
        if channel == 15125 then
            if msg.protocol == "entrypoint_connect" then
                if not clients[msg.sender] and msg.target == os.getComputerID() then
                    clients[msg.sender] = true
                    distancemap[msg.sender] = {dist = 1, sender = msg.sender}
                    print("New client  connected:",msg.sender)
                    queue_message({protocol="route",destination=msg.sender,distance=1})
                    modem.transmit(15125,15125,{protocol="entrypoint_acknowledge",sender=os.getComputerID()})
                end
            elseif msg.protocol == "entrypoint_disconnect" then
                if clients[msg.sender] then
                    clients[msg.sender] = nil
                    print("Client disconnected:",msg.sender)
                    queue_message({protocol="route_erase",destination=msg.sender})
                end
            elseif msg.protocol == "heartbeat_response" then
                if msg.sender == heartbeat_entrypoint_filter then
                    heartbeat_entrypoint = true
                end
            elseif msg.protocol == "packet" then
                if clients[msg.sender] and (msg.hops or 0 ) == 0 then
                    print("Packet received from client",tostring(msg.sender),"to",msg.destination)
                    if clients[msg.destination] then
                        msg.hops = (msg.hops or 0) + 1
                        modem.transmit(15125,15125,msg)    
                    elseif distancemap[msg.destination] ~= nil then
                        msg.hops = (msg.hops or 0) + 1
                        queue_message(msg, distancemap[msg.destination].sender)
                    else
                        print("No route to",msg.destination)
                    end
                end
            end
        end
end

local function isInDMap(id)
    for _,v in pairs(distancemap) do
        if v.sender == id then
            return true
        end
    end
    return false    
end

local function is_in_table(table,value)
    if table == nil then return false end
    for _,v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false    
end

if radio and modem then
    print("in router and bridge entrypoint mode")
    radio.setFrequency(15124)
    modem.open(15124)
    modem.open(15125)
    function interactions.receive()
        local data = {[3]={_target=-1},[5]={_target=-1}}
        while true do
            local data = {os.pullEvent()}
            if data[1] == "radio_message" then
               data[3] = textutils.unserialise(data[3])
                if data[3]._target == os.getComputerID() or data[3]._target == nil then return data[2], data[3], data[4] end 
            elseif data[1] == "modem_message" then
                if data[5]._target == os.getComputerID() or data[5]._target == nil and data[3] == 15124 then return data[2], data[5], data[6] end
                if data[3] == 15125 then
                    entrypoint_recieving(data[3], data[5])
                end
            end
        end
    end
    function interactions.send(message,target)
        message._sender = os.getComputerID()
        message._target = target
        radio.broadcast(textutils.serialise(message))
        modem.transmit(15124,15124,message)
    end
elseif radio then
    error("needs modem to be an entry point")
elseif modem then
    print("in modem router entrypoint mode")
    modem.open(15124)
    modem.open(15125)
    function interactions.receive()
        local data = {[5]={_target=-1}}
        while true do
            data = {os.pullEvent("modem_message")}
            if data[5]._target == os.getComputerID() or data[5]._target == nil  and data[3] == 15124 then return data[2], data[5], data[6] end
            if data[3] == 15125 then
                entrypoint_recieving(data[3], data[5])
            end
        end
    end
    function interactions.send(message,target)
        message._sender = os.getComputerID()
        message._target = target
        modem.transmit(15124,15124,message)
    end
else
    error("No radio or modem peripheral found")
end
distancemap[os.computerID()] = {dist = 0, sender = os.computerID()}
queue_message({protocol="getroutes"})
interactions.send({protocol="route_erase",destination=os.getComputerID()})
queue_message({protocol="route",destination=os.getComputerID(),distance=0})
local heartbeat = false
local function generate_default_routes()
    local map = {}
    map[os.computerID()] = {dist = 0, sender = os.computerID()}
    for client,_ in pairs(clients) do
        map[client] = {dist = 1, sender = client}
    end
    return map
end
local function recieve()
while true do
    local _, msg = interactions.receive()
    if msg.protocol == "route" then
        if msg.distance < (distancemap[msg.destination] or {dist = math.huge}).dist and msg.destination ~= os.getComputerID() and not clients[msg.destination] then
            msg.distance = msg.distance + 1
            distancemap[msg.destination] = {dist = msg.distance, sender = msg._sender}
            print("route registered to",msg.destination,"via",msg._sender,"just",msg.distance,"hop(s) away!")
            queue_message(msg)
        end
    elseif msg.protocol == "route_erase" then
        if distancemap[msg.destination] ~= nil and msg.destination ~= os.getComputerID() and not is_in_table(msg.visited,os.getComputerID()) then
            if clients[msg.destination] then
                queue_message({protocol="route",destination=msg.destination,distance=1})
            else
                distancemap[msg.destination] = nil
                if (not msg.visited) then msg.visited = {} end
                msg.visited[#msg.visited+1] = os.getComputerID()
                print("route to",msg.destination,"erased!")
                queue_message(msg)
            end
        end
    elseif msg.protocol == "packet" then
        if msg.destination == os.getComputerID() then
            print("Packet received from",tostring(msg.sender)..":",msg.content)
        else
            if msg._target then
                if clients[msg.destination] then
                    print("Forwarding packet to client",msg.destination)
                    msg.hops = msg.hops + 1
                    modem.transmit(15125,15125,msg)
                elseif distancemap[msg.destination] ~= nil then
                    print("Forwarding packet to node",msg.destination)
                    msg.hops = msg.hops + 1
                    queue_message(msg, distancemap[msg.destination].sender)
                else
                    print("No route to",msg.destination)
                end
            end
        end
    elseif msg.protocol == "heartbeat" then
        queue_message({protocol="heartbeat_response"}, msg._sender)
    elseif msg.protocol == "heartbeat_response" then
        heartbeat = true
    elseif msg.protocol == "getroutes" then
        local response = {protocol="getroutes_response",routes=distancemap}
        queue_message(response, msg._sender)
    elseif msg.protocol == "getroutes_response" then
        for k,v in pairs(msg.routes) do
            if v.dist+1 < (distancemap[k] or {dist = math.huge}).dist and k ~= os.getComputerID() and v.sender ~= os.getComputerID() then
                v.sender = msg._sender
                v.dist = v.dist + 1
                distancemap[k] = v
                print("route registered to",k,"via",v.sender,"just",v.dist,"hop(s) away!")
            end
        end
    elseif msg.protocol == "reroute" then
        if isInDMap(msg._sender) and not is_in_table(msg.visited,os.getComputerID()) then
            if (not msg.visited) then msg.visited = {} end
            msg.visited[#msg.visited+1] = os.getComputerID()
            print("rerouting")
            distancemap = generate_default_routes()
            queue_message({protocol="getroutes"})
            queue_message(msg)
        end
    end
end
end
local function send()
    while true do
        local msg,target = dequeue_message()
        if msg then
            interactions.send(msg, target)
        end
        sleep()
    end
end
local function heartbeat_f()
    while true do
        for k,v in pairs(distancemap) do
            if k ~= os.getComputerID() and not clients[v.sender] then
                heartbeat = false
                interactions.send({protocol="heartbeat"}, v.sender)
                parallel.waitForAny(function()
                    sleep(5)
                end, function()
                    while not heartbeat do
                        sleep()
                    end
                end)
                if not heartbeat then
                    print(k, "timed out")
                    distancemap[k] = nil
                    queue_message({protocol="reroute"})
                end
            end
        end
        sleep(10)
    end
end
local function entrypoint_advertising()
    while true do
        modem.transmit(15125,15125,{protocol="entrypoint_advertise",sender=os.getComputerID()})
        sleep(0.1)
    end
end
local function healthcheck()
    while true do
        for client,_ in pairs(clients) do
            heartbeat_entrypoint = false
            heartbeat_entrypoint_filter = client
            parallel.waitForAny(function()
                sleep(0.1)
            end, function()
                while not heartbeat_entrypoint do
                    modem.transmit(15125,15125,{protocol="heartbeat",sender=os.getComputerID(),target=client})
                    sleep()
                end
            end)
            if not heartbeat_entrypoint then
                clients[client] = nil
                print("Client timed out:",client)
                queue_message({protocol="route_erase",destination=client})
            end
        end
        sleep()
    end
end
parallel.waitForAny(recieve,send,heartbeat_f,entrypoint_advertising,healthcheck)
