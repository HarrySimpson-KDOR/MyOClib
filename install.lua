local shell = require("shell")
local filesystem = require("filesystem")
local args = {...}
local scripts = {
}

local function exists(filename)
    return filesystem.exists(shell.getWorkingDirectory().."/"..filename)
end

local branch
local option
if #args == 0 then
    branch = "main"
else
    branch = args[1]
end

if branch == "help" then
    print("Usage:\n./install or ./install [branch] [updateconfig]")
    return
end

if #args == 2 then
    option = args[2]
end

-- for i=1, #scripts do
--     shell.execute("wget -f https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..scripts[i])
-- end

-- if not exists("config.lua") then
--     shell.execute("wget https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/config.lua")
-- end

-- if option == "updateconfig" then
--     if exists("config.lua") then
--         if exists("config.bak") then
--             shell.execute("rm config.bak")
--         end
--         shell.execute("mv config.lua config.bak")
--         print("Moved config.lua to config.bak")
--     end
--     shell.execute("wget https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/config.lua")
-- end


-- wget https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/main/install.lua