local shell = require("shell")
local args = {...} 
local times = args[1]

for i=1, #times do
    shell.execute("build.lua ")
end
