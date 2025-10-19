local interactions = {}
local radio = peripheral.find("radio_tower")
local modem = peripheral.find("modem")
local disatncemap = {}
local message_queue = {}
local function isInDMap(id)
    for _,v in pairs(disatncemap) do
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

local function queue_message(msg, target)
    table.insert(message_queue,#message_queue+1, {msg,target})
end
local function dequeue_message()
    return table.unpack(table.remove(message_queue,1) or {})
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
disatncemap[os.computerID()] = {dist = 0, sender = os.computerID()}
queue_message({protocol="getroutes"})
interactions.send({protocol="route_erase",destination=os.getComputerID()})
queue_message({protocol="route",destination=os.getComputerID(),distance=0,visited={os.getComputerID()}})

local function recieve()
while true do
    local _, msg = interactions.receive()
    if msg.protocol == "route" then
        if msg.distance < (disatncemap[msg.destination] or {dist = math.huge}).dist and msg.destination ~= os.getComputerID() then
            disatncemap[msg.destination] = {dist = msg.distance, sender = msg._sender}
            print("route registered to",msg.destination,"via",msg._sender,"just",msg.distance,"hop(s) away!")
            msg.distance = msg.distance + 1
            queue_message(msg)
        end
    elseif msg.protocol == "route_erase" then
        if disatncemap[msg.destination] ~= nil and msg.destination ~= os.getComputerID() and not is_in_table(msg.visited,os.getComputerID()) then
            disatncemap[msg.destination] = nil
            if (not msg.visited) then msg.visited = {} end
            msg.visited[#msg.visited+1] = os.getComputerID()
            print("route to",msg.destination,"erased!")
            queue_message(msg)
        end
    elseif msg.protocol == "packet" then
        if msg.destination == os.getComputerID() then
            print("Packet received from",tostring(msg.sender)..":",msg.content)
        else
            if disatncemap[msg.destination] ~= nil then
                msg.hops = msg.hops + 1
                queue_message(msg, disatncemap[msg.destination].sender)
            else
                print("No route to",msg.destination)
            end
        end
    elseif msg.protocol == "getroutes" then
        local response = {protocol="getroutes_response",routes=disatncemap}
        queue_message(response, msg._sender)
    elseif msg.protocol == "getroutes_response" then
        for k,v in pairs(msg.routes) do
            if v.dist+1 < (disatncemap[k] or {dist = math.huge}).dist and k ~= os.getComputerID() then
                v.sender = msg._sender
                v.dist = v.dist + 1
                disatncemap[k] = v
                print("route registered to",k,"via",v.sender,"just",v.dist,"hop(s) away!")
            end
        end
    elseif msg.protocol == "heartbeat" then
        queue_message({protocol="heartbeat_response"}, msg._sender)
    elseif msg.protocol == "reroute" then
        if isInDMap(msg._sender) then
            disatncemap = {}
            disatncemap[os.computerID()] = {dist = 0, sender = os.computerID()}
            queue_message({protocol="getroutes"})
            queue_message({protocol="reroute"})
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
parallel.waitForAny(recieve,send)
