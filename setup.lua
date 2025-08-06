local function isYes(str)
    if str:lower():find("n") then
        return false
    end
    return true
end

term.write("setup netmountcc? (Y/n)")

if isYes(read()) then
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
        file.write(http.get(url.."/mount.lua").readAll())
        file.close()
    end 
   print("done setting up netmountcc!")     
end

os.reboot()
