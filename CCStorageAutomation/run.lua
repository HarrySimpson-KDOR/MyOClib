local waittime = 300
 
local event = require("event")
local io = require("io")
local sides = require("sides")
local component = require("component")
local rs = component.block_refinedstorage_interface

--define the minimum inventory levels for each item based on label
local inventoryMinimums = {
    { label = "LEU%-235 Fuel", count = 128, pattern = {}}
}
local allPatterns = rs.getPatterns()
for i = 1, #allPatterns do
    for j = 1, #inventoryMinimums do
        if string.find(allPatterns[i].label, inventoryMinimums[j].label) then
            print("Found pattern for " .. inventoryMinimums[j].label)
            inventoryMinimums[j].pattern = allPatterns[i]
        end
    end
end
while true do
    --iterate through all the minimums
    for i = 1, #inventoryMinimums do
        local item = rs.getItem(inventoryMinimums[i].pattern)
        print(item.label .. " count: " .. item.size)
        local count = inventoryMinimums[i].count
        if item.size < count then
            rs.scheduleTask(item, count - item.size)
        end
    end
    os.sleep(waittime)
end
