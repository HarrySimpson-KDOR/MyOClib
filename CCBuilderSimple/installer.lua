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
local currentFiles = shell.execute("ls")
for i=1, #currentFiles do
    shell.execute("rm "..currentFiles[i])
end

for i=1, #files do
    shell.execute("wget -f --r --np https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..system.."/"..files[i])
end
