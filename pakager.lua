shell.setAlias("pakager","/pakager.lua")

if not fs.exists("lualzw.lua") then
    shell.run("wget https://github.com/Rochet2/lualzw/raw/master/lualzw.lua /lualzw.lua")
end

local lualzw = require("lualzw")

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

if not fs.exists("/.pakages") then
    fs.makeDir("/.pakages")
end

if not fs.exists("/.aliases") then
    local file = fs.open("/.aliases","w")
    file.write("{}")
    file.close()
end
if not fs.exists("/.repos") then
    local file = fs.open("/.repos","w")
    file.write("url https://raw.githubusercontent.com/cadenthecreator/pakrepo/main/{PAKAGE}.pkg")
    file.close()
end

if not fs.exists("/startup") then
    fs.makeDir("/startup")
end

local function getrepos()
    local out = {}
    local file = fs.open("/.repos","r")
    while true do
        local line = file.readLine()
        if not line then break end
        local repo = split(line," ")
        if #repo == 2 then
            out[#out+1] = {type=repo[1],location=repo[2]}
        end 
    end
    file.close()
    return out
end
if not fs.exists("/startup/pakagers.lua") then
    local file = fs.open("/startup/pakagers.lua","w")
    file.write([[local file = fs.open("/.aliases","r")
local aliases = textutils.unserialise(file.readAll())
for pakname,pakaliases in pairs(aliases) do
    for _,alias in ipairs(pakaliases) do
        shell.setAlias(alias[1],"/"..fs.combine("/.pakages/"..pakname,alias[2]))
    end
end
]])
file.close()
end

local function addAliases(pkaliases,name)
    for _,i in ipairs(pkaliases) do
        print(i[1],"->","/"..fs.combine("/.pakager/"..name,i[2]))
        shell.setAlias(i[1],"\"/"..fs.combine("/.pakages/"..name,i[2])..'"')
    end
    local filer = fs.open("/.aliases","r")
    local aliases = textutils.unserialise(filer.readAll())
    aliases[name] = pkaliases
    filer.close()
    local file = fs.open("/.aliases","w")
    file.write(textutils.serialise(aliases))
    file.close()
end

local function install(paks)
    local pak = textutils.unserialise(paks)
    if not pak then
        pak = textutils.unserialise(lualzw.decompress(paks))
    end
    local files = pak.files
    local name = pak.name
    print("installing "..name)
    local function inst(dir,data)
        for k,i in pairs(data) do
            if type(i) == "table" then
                fs.makeDir(fs.combine(dir,k))
                inst(fs.combine(dir,k),i)
            else
                print("installed",fs.combine(dir,k))
                local file = fs.open(fs.combine(dir,k),"w")
                file.write(i)
                file.close()
            end
        end
    end
    inst("/.pakages/"..name,files)
    print("finished installation")
    print("adding aliases")
    addAliases(pak.aliases,name)
    print("installation complete")    
end

local args = {...}
local operation = table.remove(args,1)

if operation == "strap" then
    local dir = ""
    if not args[1]:sub(1) == "/" then
        dir = args[1]
    else
        dir = fs.combine(shell.dir(),args[1])
    end
    if fs.exists(dir) then
        local pak = fs.open(dir,"r")
        install(pak.readAll())
        pak.close()
    else
        print("file not found")
    end
elseif operation == "makepkg" then
    local dir = ""
    if not (args[2] or ""):sub(1) == "/" then
        dir = args[2]
    else
        dir = fs.combine(shell.dir(),args[2] or "")
    end
    print("making "..args[1])
    local function scan(dir)
        local ls = fs.list(dir)
        local out = {}
        for _,i in ipairs(ls) do
            if fs.isDir(fs.combine(dir,i)) then
                out[i] = scan(fs.combine(dir,i))
            else
                print("scanned /"..fs.combine(dir,i))
                local file = fs.open(fs.combine(dir,i),"r")
                out[i] = file.readAll()
                file.close()
            end
        end
        return out
    end
    local out = {}
    print("scanning")
    out.files = scan(dir)
    print("done scanning")
    out.name = args[1]
    out.aliases = {}
    local file = fs.open("/"..out.name..".pkg","w")
    file.write(lualzw.compress(textutils.serialise(out)))
    file.close()
    print("wrote to /"..out.name..".pkg")
elseif operation == "remove" then
    if fs.exists("/.pakages/"..args[1]) then
        print("removing "..args[1])
        fs.delete("/.pakages/"..args[1])
        local filer = fs.open("/.aliases","r")
        local aliases = textutils.unserialise(filer.readAll())
        filer.close()
        print("removing aliases")
        local file = fs.open("/.aliases","w")
        for _,i in ipairs(aliases[args[1]]) do
            shell.clearAlias(i[1])
        end
        aliases[args[1]] = nil
        file.write(textutils.serialise(aliases))
        file.close()
        print("done removing")
    else
        print("pakage not installed")
    end
elseif operation == "install" then
    local repos = getrepos()
    local pak = ""
    for _,i in ipairs(repos) do
        if i.type == "id" then
            peripheral.find("modem",rednet.open)
            rednet.send(tonumber(i.location),args[1],"getpkg")
            local id,proto = -1
            repeat 
                id,pak,proto = rednet.receive(nil,4)
            until id == tonumber(i.location) or id == nil and (proto == "sendpkg" or proto == "refusal") 
            rednet.close()
        elseif i.type == "url" then
            local url = i.location:gsub("{PAKAGE}",args[1])
            req = http.get(url)
            if req then pak = req.readAll() end
        end
        if pak ~= nil and pak ~= "" then
            install(pak)
            break
        end
    end
    if pak == "" or pak == nil then
        print("pakage not found")
    end
elseif operation == "repos" then
    local repos = getrepos()
    if #repos == 0 then
        print("no repos found you might want to add some")
    else
        for _,i in ipairs(repos) do
            print("type: "..i.type,"location: "..i.location)
        end
    end
elseif operation == "installed" then
    print(table.unpack(fs.list("/.pakages")))
end
