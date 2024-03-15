local shell = require("shell")
local filesystem = require("filesystem")
local args = {...} 
local systems = {
    "CCBuilderSimple",
}

local function exists(filename)
    return filesystem.exists(shell.getWorkingDirectory().."/"..filename)
end

local branch
local system

if #args == 0 then
    print("Usage: ./installer [system] [location] [branch==main]")
    print("Usage: ./installer list -> list of systems")
    print("Usage: ./installer update -> update the installer")
    return
elseif #args == 1 then
    if args[1] == "list" then
        print("List of systems")
        for i=1, #systems do
            print(systems[i])
        end
        return
    elseif args[1] == "update" then
        print("Updating installer")
        shell.execute("wget -f https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/main/installer.lua")
        return
    else
        print("Invalid argument. Use 'list' or 'update'.")
        return
    end
elseif #args == 2 then
    system = args[1]
    branch = "main"
elseif #args == 3 then
    system = args[1]
    branch = args[2]
else
    print("Incorrect number of arguments.")
    return
end


--change to the location directory
shell.setWorkingDirectory(args[2])

--download the files
shell.execute("wget -f https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..system)


-- wget -f https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/main/installer.lua