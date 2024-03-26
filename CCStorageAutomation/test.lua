local event = require("event")
local io = require("io")
local sides = require("sides")
local component = require("component")
local rs = component.block_refinedstorage_interface


-- local allItems = rs.getItems()
-- --find item with the "Fuel" in the name
-- for i = 1, #allItems do
--   if string.find(allItems[i].name, "nuclearcraft:fuel_uranium") then
--     print("Item "..i)
--     --list all properties of the item
--     for k,v in pairs(allItems[i]) do
--         print(k,v)
--     end
--     local item = rs.getItem(allItems[i])
--     print("Item count: "..item.size)
--     if(item.size < 128) then
--         rs.scheduleTask(allItems[i], 128 - item.size)
--     end 
--   end
-- end
local testiitem = {
    name = "nuclearcraft:fuel_uranium",
    label = "LEU%-235 Fuel",
    hasTag = false,
    damage = 4.0, 
    size = 1.0,
    maxSize = 64.0,
    maxDamage = 0.0,
}
local findtestitem = rs.getItem(testiitem)
print("Item count: "..findtestitem.size)

local allPatterns = rs.getPatterns()
--find pattern with the "Fuel" in the name
local fuelPatterns = {}
for i = 1, #allPatterns do
    if string.find(allPatterns[i].label, "LEU%-235") then
    print("Pattern "..i)
    end
    if string.find(allPatterns[i].label, "LEU%-235") then
        local item = rs.getItem(allPatterns[i])
        --print all properties of the item
        for k,v in pairs(allPatterns[i]) do
            print(k,v)
        end
        print("Item count: "..item.size)
        if(item.size < 128) then
            rs.scheduleTask(allPatterns[i], 128 - item.size)
        end 
    end
end

