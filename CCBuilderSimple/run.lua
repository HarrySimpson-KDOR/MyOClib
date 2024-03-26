local shell = require("shell")
local build = require("build")

local args = {...} 
local times = args[2]
local program = args[1]
local ready = false


for i=1, times do
    print("starting program "..program .. " for the "..i.." time")
    if (program == "1") then
        print("building standard")
        build.buildStandard()
    elseif (program == "2") then
        print("building machine wall")
        build.buildMachineWall()
    elseif (program == "3") then
        print("building tunnel")
        build.tunnel()
    elseif (program == "4") then
        print("building tunnel")
        build.buildWall()
    end
end
