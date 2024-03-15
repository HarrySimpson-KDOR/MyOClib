local r = require("robot")
local component = require("component")
local sides = require("sides")
local computer = require("computer")
local serial = require("serialization")

--the build cube will be defined with a numerical matrix where each value in the matrix indicates the inventory slow for the item that need to be placed
--(z,x,y) = (layer, row, column)
local threedCube =
{
    {
        {1,1,1},
        {1,1,1},
        {1,1,1}
    },
    {
        {1,1,1},
        {1,1,1},
        {1,1,1}
    },
    {
        {1,1,1},
        {1,1,1},
        {1,1,1}
    }
}
print(threedCube)
--wait 10 sec
os.sleep(10)

r.turnLeft()
r.turnLeft()
for i=1,4 do
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
        print(slot)
        r.select(slot)
        r.placeDown()
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
r.turnRight()
for i=1,3 do
    r.forward()
end
r.turnRight()
for i=1,4 do
    r.forward()
end