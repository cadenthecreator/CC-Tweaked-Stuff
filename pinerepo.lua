peripheral.find("modem",rednet.open)
if not fs.exists("hostname") then
    local file = fs.open("hostname","w")
    term.write("\nhostname: ")
    file.write(read())
    file.close()
end
local file = fs.open("hostname","r")
rednet.host("getpkg",file.readAll())
file.close()
while true do
    local id,msg = rednet.receive("getpkg")
    local data = textutils.unserialiseJSON(http.get("https://pinestore.cc/api/projects").readAll())
    for c,i in ipairs(data.projects) do
        if i.name == msg then
            local blacklist = fs.list("/")
            shell.run(i.install_command)
            local function scan(dir)
                local ls = fs.list(dir)
                local out = {}
                for _,i in ipairs(ls) do
                    if fs.isDir(fs.combine(dir,i)) then
                        out[i] = scan(fs.combine(dir,i))
                    else
                        local file = fs.open(fs.combine(dir,i),"r")
                        out[i] = file.readAll()
                        file.close()
                    end
                end
                return out
            end
            for _,i in ipairs(fs.list("/")) do
                local can = true
                for _,v in ipairs(blacklist) do
                    if i == v then
                        can = false
                        break
                    end
                end
                if can then
                    fs.move("/"..i,"/pakage/"..i)
                end
            end
            local out = {}
            out.files = scan("/pakage")
            out.name = i.name
            out.aliases = {{i.name,i.target_file}}
            local send = textutils.serialise(out)
            fs.delete("/pakage")
            rednet.send(id,send,"sendpkg")
            break
        end
        if c == #data.projects then
            print("package not found")
            rednet.send(id,nil,"refusal")
        end
    end
end
