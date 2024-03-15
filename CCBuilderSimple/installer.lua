local system = "CCBuilderSimple"
local shell = require("shell")
local args = {...} 
local branch = args[1]
local files = {
    "demo.lua",
    "autorun.lua",
    "setup.lua"
}
for i=1, #files do
    shell.execute("wget -f --r --np https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..system.."/"..files[i])
end
