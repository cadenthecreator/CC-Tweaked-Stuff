peripheral.find("modem",rednet.open)
if not fs.exist("hostname") then
    local file = fs.open("hostname","w")
    term.write("\nhostname: ")
    file.write(read())
    file.close()
end
local file = fs.open("hostname","r")
rednet.host("getpkg",file.readAll())
file.close()
if not fs.exists("/pakages") then
    fs.makeDir("/pakages")
end
while true do
    local id,msg = rednet.receive("getpkg")
    if fs.exists("/pakages/"..msg..".pkg") then
        local file = fs.open("/pakages/"..msg..".pkg","r")
        local pak = file.readAll()
        print(id,msg)
        rednet.send(id,pak,"sendpkg")
        file.close()
    else
        rednet.send(id,nil,"refusal")
    end
end
