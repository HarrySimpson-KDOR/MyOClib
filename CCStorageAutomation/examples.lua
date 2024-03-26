local waittime = 300
 
local event = require("event")
local io = require("io")
local sides = require("sides")
local component = require("component")
local rs = component.block_refinedstorage_interface
local term = require("term")
 
local args = { ... }
local paths = {}
 
 
-- Check if the file exist 
local function file_exist(path)
  local file = io.open(path)
 
  if (not file) then
    print("[ERROR]: No such file: " .. path .. ".")
    return false
  end
  io.close(file)
  return true
end
 
-- Load and parse the file, return a table with all the item to craft.
local function load_file(path)
  local crafts = {}
 
  for line in io.lines(path) do
    local n, c, l, f = line:match "(%S+)%s+(%d+)"
    l = n:match "(%u%S+)"
    f = n:match("(%l+:%l+)")
    if (l) then
      table.insert(crafts, { name = f, label = l, count = c, fullName = n })
    else
      table.insert(crafts, { name = f, count = c, fullName = n })
    end
  end
  return crafts
end
 
-- Check the args
if (#args > 0) then
  paths[1] = os.getenv("PWD") .. "/" .. args[1]
  if not file_exist(paths[1]) then
    return
  end
else
  print("[ERROR]: Filename is needed.")
  return
end
 
 
local crafts = load_file(paths[1])
 
 
while(true) do
    for i,craft in ipairs(crafts) do
        a = {}
        k = "name"
        j = "label"
        -- a[k] = craft["fullName"]
        a[k] = "nuclearcraft:fuel_uranium"
        a[j] = "LEU-235 Fuel"


        if(rs.hasPattern(a)) then
            local pattern = rs.getPattern(a)
            --print pattern details
            for k,v in pairs(pattern) do
                print(k,v)
            end
            
            local rsStack = rs.getItem(a)
            print("current count: " .. rsStack.size)
--            local rsStack = rs.getItem(craft["fullName"])
 
            local toCraft = craft["count"];
            if(rsStack ~= nil) then
                toCraft = toCraft - rsStack.size
            end
 
            if(toCraft ~= 0) then
                if(toCraft > 0) then
                    term.clearLine()
                    io.write("Crafting: " .. toCraft, craft["fullName"] .. "\n")
                    rs.scheduleTask(a, toCraft)
                end
            end
        else
            print("Missing pattern for: " .. a[k])
        end
    end
 
 
    for waittime1 = waittime, 0, -1 do
        term.clearLine()
            io.write("Sleeping " .. waittime1 .. " secs.")
            os.sleep(1)
            local waittime1 = waittime1 - 1
    end
 
 
 
end
