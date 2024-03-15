local r = require("robot")
local component = require("component")
local sides = require("sides")
local computer = require("computer")
local serial = require("serialization")
 
local ic = component.inventory_controller
 
local movescript = {}
 
local destructive = true
 
local function doUntilSuccess(f)
    local success = f()
    while (not success) do
        success = f()
    end
end
 
local function up()
    while (destructive and r.detectUp()) do
        r.swingUp()
    end
    doUntilSuccess(r.up)
end
 
local function down()
    while (destructive and r.detectDown()) do
        r.swingDown()
    end
    doUntilSuccess(r.down)
end
 
local function forward()
    while (destructive and r.detect()) do
        r.swing()
    end
    doUntilSuccess(r.forward)
end
 
local function back()
    if (destructive) then
        r.turnAround()
        while (r.detect()) do
            r.swing()
        end
        r.turnAround()
    end
    doUntilSuccess(r.back)
end
 
local functionMap = {
    ["U"] = up,
    ["D"] = down,
    ["L"] = r.turnLeft,
    ["R"] = r.turnRight,
    ["F"] = forward,
    ["B"] = back,
    ["P"] = r.place,
    ["Pd"] = r.placeDown,
    ["Pu"] = r.placeUp,
    ["S"] = r.swing,
    ["Sd"] = r.swingDown,
    ["Su"] = r.swingUp
}
 
--[[
Determines if a string starts with a certain string.
str - string: The string to check the prefix of.
start - string: The prefix to look for.
--]]
local function starts_with(str, start)
    return str:sub(1, #start) == start
end
 
--[[
Executes a single instruction once.
c - character: One uppercase character to translate into movement.
--]]
local function executeChar(c)
    local f = functionMap[c]
    if (f == nil) then
        return
    end
    f()
end
 
--[[
Executes a single instruction, such as '15D' or '4Sd'
instruction - string: An integer followed by an uppercase character.
--]]
local function executeInstruction(instruction)
    local count = string.match(instruction, "%d+")
    local char = string.match(instruction, "%u%l?")
    if (count == nil) then
        count = 1
    end
    if (char == nil) then
        return
    end
    for i=1,count do
        executeChar(char)
    end
end
 
function movescript.execute(script)
  movescript.exec(script)
end
 
--[[
Executes a given script.
script - string: The script to execute.
--]]
function movescript.exec(script)
    if (starts_with(script, "d_")) then
        destructive = true
        script = string.sub(script, 3)
    else
        destructive = false
    end
    while (script ~= nil and script ~= "") do
        -- Matches the next instruction, possibly prefixed by an integer value.
        local next_instruction = string.match(script, "%d*%u%l?")
        executeInstruction(next_instruction)
        script = string.sub(script, string.len(next_instruction) + 1)
    end
end
 
--[[
Inventory Management
--]]
 
 
local function stackMatches(stack, name, damage, fuzzy)
  return stack ~= nil
    and ((fuzzy and string.find(stack.name, name)) or (stack.name == name))
    and (fuzzy or stack.damage == damage)
end
 
--[[
Selects the given item in the inventory.
name - string: The name of the item to select, like "minecraft:dirt"
damage - number: The damage value of the item. Defaults to 0.
fuzzy - boolean: Whether to accept partial name matches.
--]]
function movescript.selectItem(name, damage, fuzzy)
  damage = damage or 0
  fuzzy = fuzzy or true
  for i=1, r.inventorySize() do
    local stack = ic.getStackInInternalSlot(i)
    if stackMatches(stack, name, damage, fuzzy) then
      r.select(i)
      return true
    end
  end
  return false
end
 
--[[
Counts the number of items of a certain type in the robot's inventory.
name - string: The name of the item to select, like "minecraft:dirt"
damage - number: The damage value of the item. Defaults to 0.
fuzzy - boolean: Whether to accept partial name matches.
--]]
function movescript.getItemCount(name, damage, fuzzy)
  damage = damage or 0
  fuzzy = fuzzy or true
  local count = 0
  for i=1, r.inventorySize() do
    local stack = ic.getStackInInternalSlot(i)
    if stackMatches(stack, name, damage, fuzzy) then
      count = count + stack.size
    end
  end
  return count
end
 
--[[
Sucks some items from an inventory on a certain side.
--]]
function movescript.suckItems(side, name, damage, fuzzy, count)
  damage = damage or 0
  fuzzy = fuzzy or true
  count = count or 1000000
  local invSize = ic.getInventorySize(side)
  local amountMoved = 0
  if invSize == nil then return 0 end
  for i=1, invSize do
    local stack = ic.getStackInSlot(side, i)
    if stackMatches(stack, name, damage, fuzzy) then
      local amountToMove = math.min(count - amountMoved, stack.size)
      local success = ic.suckFromSlot(side, i, amountToMove)
      if success then
        amountMoved = amountMoved + amountToMove
      else
        return amountMoved
      end
    end
  end
  return amountMoved
end
 
--[[
Drops all items except for a certain type.
name - string: The name of the item to select, like "minecraft:dirt"
damage - number: The damage value of the item. Defaults to 0.
fuzzy - boolean: Whether to accept partial name matches.
--]]
function movescript.dropAllExcept(name, damage, fuzzy)
  damage = damage or 0
  fuzzy = fuzzy or true
  local count = 0
  for i=1, r.inventorySize() do
    local stack = ic.getStackInInternalSlot(i)
    if stack ~= nil and not stackMatches(stack, name, damage, fuzzy) then
      r.select(i)
      r.drop()
      count = count + stack.size
    end
  end
  return count
end
 
--[[
Gets the ratio of how charged the batteries are, from 0 to 1.
--]]
function movescript.getEnergyRatio()
  return computer.energy() / computer.maxEnergy()
end
 
--[[
Continuously sleeps until the robot has at least the given energy ratio.
--]]
function movescript.waitUntilEnergyRatio(minRatio)
  repeat
    local energy = movescript.getEnergyRatio()
    os.sleep(1)
  until energy > minRatio
end
 
return movescript