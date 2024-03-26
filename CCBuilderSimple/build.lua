local r = require("robot")
local component = require("component")
local sides = require("sides")
local computer = require("computer")
local serial = require("serialization")
local oEvent = require("event")

local build = {}

--[[
    this function will aquire the resources needed to build a 3x3x3 cube
--]]
local function gather(requirements)
    print("Collecting resources")
    local success = true
    r.turnLeft()
    r.select(1)
    r.suck(requirements[1])
    if (r.count(1) < requirements[1]) then
        success = false
    end
    r.turnLeft()
    r.forward()
    r.turnRight()
    r.select(2)
    r.suck(requirements[2])
    if (r.count(2) < requirements[2]) then
        success = false
    end
    r.turnLeft()
    r.forward()
    r.turnRight()
    r.select(3)
    if(#requirements > 2) then
        r.suck(requirements[3])
        if (r.count(3) < requirements[3]) then
            success = false
        end
    end
    r.turnLeft()
    r.forward()
    r.turnRight()
    r.select(5)
    r.suck(1)
    if (r.count(5) < 1) then
        success = false
    end
    if(success) then
        print("Resources collected")
        r.turnRight()
        r.forward()
        r.forward()
        r.forward()
    else
        print("Resources not collected")
        r.drop(1)
        r.turnRight()
        r.forward()
        r.turnLeft()
        r.select(2)
        r.drop(1)
        r.turnRight()
        r.forward()
        r.turnLeft()
        r.select(1)
        r.drop(26)
        r.turnRight()
    end
    print("Finished collecting resources task")
    return success
end

function build.buildWall()
    print("Building machine wall")
    local threedCube =
    {
        {
            {0,0,0},
            {0,1,0},
            {0,0,0}
        },
        {
            {0,0,0},
            {0,2,0},
            {0,0,0}
        },
        {
            {0,0,0},
            {0,0,0},
            {0,0,0}
        }
    }
    local itemRequirements = {}
    for layer=1,3 do
        for row=1,3 do
            for column=1,3 do
                local slot = threedCube[layer][row][column]
                if (itemRequirements[slot] == nil) then
                    itemRequirements[slot] = 1
                else
                    itemRequirements[slot] = itemRequirements[slot] + 1
                end
            end
        end
    end
    for k,v in pairs(itemRequirements) do
        print(k,v)
    end
    --wait 10 sec
    os.sleep(2)
    gather(itemRequirements)
    print("Wall")
    r.turnRight()
    r.forward()
    r.forward()
    r.forward()
    r.turnRight()
    r.forward()
    r.forward()
    r.select(1)
    r.place()
    r.up()
    r.select(2)
    r.place()
    r.down()
    r.back()
    r.back()
    r.select(5)
    r.drop(1)
    r.forward()
    r.forward()
    r.select(16)
    local result = false
    while (not result) do
        result = r.suck(1)
        os.sleep(4)
        print("waiting")
    end
    r.back()
    r.back()
    r.turnRight()
    for i=1,2 do
        r.forward()
    end
    r.turnRight()
    r.drop(64)
    r.turnLeft()
    r.forward()
    r.turnRight()
    return result
end
--[[
    this function will build a 3x3x3 cube
--]]
local function buildThreexCube(threedCube)
    local itemRequirements = {}
    for layer=1,3 do
        for row=1,3 do
            for column=1,3 do
                local slot = threedCube[layer][row][column]
                if (itemRequirements[slot] == nil) then
                    itemRequirements[slot] = 1
                else
                    itemRequirements[slot] = itemRequirements[slot] + 1
                end
            end
        end
    end
    for k,v in pairs(itemRequirements) do
        print(k,v)
    end
    --wait 10 sec
    os.sleep(2)
    gather(itemRequirements)
    print("Building 3x3x3 cube")

    r.turnLeft()
    r.turnLeft()
    for i=1,3 do
        r.forward()
    end
    r.turnLeft()
    for i=1,4 do
        r.forward()
    end
    r.turnRight()
    --the robot is now in the correct position to start building the cube
    local function buildColumn(column, layer)
        for row=1,3 do
            local slot = threedCube[layer][row][column]
            if (slot ~= 0) then
                r.select(slot)
                r.place()
            end
            r.turnRight()
            r.forward()
            r.turnLeft()
        end
    end
    local function buildFullColumn(column)
        for layer=1,3 do
            buildColumn(column, layer)
            r.up()
            r.turnLeft()
            for i=1,3 do
                r.forward()
            end
            r.turnRight()
        end
    end
    local function buildCube()
        for column=1,3 do
            buildFullColumn(4-column)
            r.back()
            for i=1,3 do
                r.down()
            end
        end
    end
    buildCube()
    --return to the starting position
    r.select(5)
    r.drop(1)
    r.forward()
    r.forward()
    r.turnRight()
    r.forward()
    r.turnLeft()
    r.select(16)
    local result = false
    while (not result) do
        result = r.suck(1)
        os.sleep(4)
        print("waiting")
    end
    r.back()
    r.back()
    r.turnRight()
    for i=1,2 do
        r.forward()
    end
    r.turnRight()
    r.drop(64)
    r.turnLeft()
    r.forward()
    r.turnRight()
    return result
end

function build.tunnel()
    print("Building machine wall")
    local machinewall =
    {
        {
            {3,3,3},
            {3,1,3},
            {3,3,3}
        },
        {
            {0,0,0},
            {0,2,0},
            {0,0,0}
        },
        {
            {0,0,0},
            {0,0,0},
            {0,0,0}
        }
    }
    buildThreexCube(machinewall)
    return true 
end

function build.buildMachineWall()
    print("Building machine wall")
    local machinewall =
    {
        {
            {0,0,0},
            {0,1,0},
            {0,0,0}
        },
        {
            {0,0,0},
            {0,2,0},
            {0,0,0}
        },
        {
            {0,0,0},
            {0,0,0},
            {0,0,0}
        }
    }
    buildThreexCube(machinewall)
    return true 
end

function build.buildStandard()
    print("Building standard")
    local threedCube =
    {
        {
            {1,1,1},
            {1,1,1},
            {1,1,1}
        },
        {
            {1,1,1},
            {1,2,1},
            {1,1,1}
        },
        {
            {1,1,1},
            {1,1,1},
            {1,1,1}
        }
    }
    buildThreexCube(threedCube)
    return true
end


return build
