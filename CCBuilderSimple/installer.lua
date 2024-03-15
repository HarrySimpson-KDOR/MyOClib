local system = "CCBuilderSimple"
local branch = args[1]
local files = {
    "client.lua",
    "autorun.lua",
    "setup.lua"
}
for i=1, #files do
    shell.execute("wget -f --r --np https://raw.githubusercontent.com/HarrySimpson-KDOR/MyOClib/"..branch.."/"..system.."/"..files[i])
end
