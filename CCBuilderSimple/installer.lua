local fs = require("filesystem")
local system = "CCBuilderSimple"
local shell = require("shell")
local args = {...} 
local branch = args[1]
local files = {
    "build.lua",
    "autorun.lua",
    "run.lua"
}
--get all files in the current directory and remove them
for node in fs.list("/flp") do
    print(node)
end


for i=1, #files do
    shell.execute("wget -f --r --np https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..system.."/"..files[i])
end
