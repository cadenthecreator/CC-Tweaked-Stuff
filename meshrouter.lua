local interactions = {}
local radio = peripheral.find("radio_tower")
local modem = peripheral.find("modem")
local distancemap = {}
local message_queue = {}

local function queue_message(msg, target)
    table.insert(message_queue,#message_queue+1, {msg,target})
end
local function dequeue_message()
    return table.unpack(table.remove(message_queue,1) or {})
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
    print("in router and bridge mode")
    radio.setFrequency(15124)
    modem.open(15124)
    function interactions.receive()
        local data = {[3]={_target=-1},[5]={_target=-1}}
        while true do
            local data = {os.pullEvent()}
            if data[1] == "radio_message" then
               data[3] = textutils.unserialise(data[3])
                if data[3]._target == os.getComputerID() or data[3]._target == nil then return data[2], data[3], data[4] end 
            elseif data[1] == "modem_message" then
                if data[5]._target == os.getComputerID() or data[5]._target == nil then return data[2], data[5], data[6] end
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
    print("in radio router mode")
    radio.setFrequency(15124)
    function interactions.receive()
        local data = {[3]={_target=-1}}
        while true do
            local data = {os.pullEvent("radio_message")}
            data[3] = textutils.unserialise(data[3])
            if data[3]._target == os.getComputerID() or data[3]._target == nil then return data[2], data[3], data[4] end
        end
    end
    function interactions.send(message,target)
        message._sender = os.getComputerID()
        message._target = target
        radio.broadcast(textutils.serialise(message))
    end
elseif modem then
    print("in modem router mode")
    modem.open(15124)
    function interactions.receive()
        local data = {[5]={_target=-1}}
        while true do
            data = {os.pullEvent("modem_message")}
            if data[5]._target == os.getComputerID() or data[5]._target == nil then return data[2], data[5], data[6] end
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

local function recieve()
while true do
    local _, msg = interactions.receive()
    if msg.protocol == "route" then
        if msg.distance < (distancemap[msg.destination] or {dist = math.huge}).dist and msg.destination ~= os.getComputerID() then
            msg.distance = msg.distance + 1
            distancemap[msg.destination] = {dist = msg.distance, sender = msg._sender}
            print("route registered to",msg.destination,"via",msg._sender,"just",msg.distance,"hop(s) away!")
            queue_message(msg)
        end
    elseif msg.protocol == "route_erase" then
        if distancemap[msg.destination] ~= nil and msg.destination ~= os.getComputerID() and not is_in_table(msg.visited,os.getComputerID()) then
            distancemap[msg.destination] = nil
            if (not msg.visited) then msg.visited = {} end
            msg.visited[#msg.visited+1] = os.getComputerID()
            print("route to",msg.destination,"erased!")
            queue_message(msg)
        end
    elseif msg.protocol == "packet" then
        if msg.destination == os.getComputerID() then
            print("Packet received from",tostring(msg.sender)..":",msg.content)
        else
            if msg._target then
                if distancemap[msg.destination] ~= nil then
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
            distancemap = {}
            distancemap[os.computerID()] = {dist = 0, sender = os.computerID()}
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
            if k ~= os.getComputerID() then
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
                    distancemap[k] = nil
                    queue_message({protocol="reroute"})
                end
            end
        end
        sleep(10)
    end
end
parallel.waitForAny(recieve,send,heartbeat_f)
