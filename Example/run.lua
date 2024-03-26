local r = require("robot")
local component = require("component")
local sides = require("sides")
local computer = require("computer")
local serial = require("serialization")
local oEvent = require("event")

while (not result) do
    r.useDown()
    for i=1,15 do
        r.use()
        os.sleep(.2)
    end
    print("waiting")
end