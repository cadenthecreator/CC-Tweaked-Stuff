local function saveFile(url,file)
    fs.makeDir(fs.getDir(file))
    local file = fs.open(file,"w")
    file.write(http.get(url).readAll())
    file.close()
end

local function isYes(str)
    if str:lower():find("n") then
        return false
    end
    return true
end
local mbs = false
local netmount = false

term.write("install MBS? (Y/n)")

if isYes(read()) then
    mbs = true
end

term.write("setup netmountcc? (Y/n)")

if isYes(read()) then
    netmount = true     
end

if netmount then
    term.write("url: ")
    local url = read()
    term.write("user: ")
    local user = read()
    term.write("pass: ")
    local pass = read()
    term.clear()
    term.setCursorPos(1,1)
    if http.checkURL(url) then
        settings.set("netmount.url",url)
        settings.set("netmount.username",user)
        settings.set("netmount.password",pass)
        settings.set("netmount.path","cloud")
        settings.save()
        fs.makeDir("/startup")
        local file = fs.open("/startup/-01_mount.lua","w")
        local filedata = http.get(url.."/mount.lua").readAll()
        if mbs then
            filedata:gsub('shell%.run%("shell"%)','shell.run("/startup/00_mbs.lua")')
        end
        file.write(filedata)
        file.close()
    end 
   print("done setting up netmountcc!")
end

if mbs then
    if not fs.exists("/rom/programs/mbs.lua") then
        saveFile("https://raw.githubusercontent.com/SquidDev-CC/mbs/master/mbs.lua", "/mbs.lua")
    end
    shell.run("mbs install")
end

os.reboot()
