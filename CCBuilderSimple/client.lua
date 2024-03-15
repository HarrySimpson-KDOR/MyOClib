--This program is simplistic and will require a specific setup to function
--My first inclination is to make it basic and work with item manually added in

--to start with wee will need to inject the main systems into the program
local r = require("robot")
local component = require("component")
local sides = require("sides")
local computer = require("computer")
local serial = require("serialization")

--the build cube will be defined with a numerical matrix where each value in the matrix indicates the inventory slow for the item that need to be placed
--(z,x,y) = (layer, row, column)
local 3dCube = {
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

--each matrix represents a layer of the cube with the first matrix being the bottom layer and the last matrix being the top layer
--the robot will start 2 south and 2 west from the southwest corner of the first layer of the cube and it will be facin west
--the robot will start by building the easter column on the first layer from north to south and then move up a lyer and repeat the process for all layers
--the robot will continue to build each column from north to south and then move to the next column to the east and repeat the process until the cube is complete

--to start the robot will need to move to the coordinate 0,0,2 and be facing east
--it will then place the block in the first position of the inventory, it will then turn right to face south move forward one and then turn left to fast east to place the next block

local currentPos = {0,5,-2}
local currentDir = "E"

--turn around
r.turnLeft()
r.turnLeft()
--move forward 4
for i=1,4 do
    r.forward()
end
--turn left
r.turnLeft()
--move forward 2
for i=1,4 do
    r.forward()
end