local Fs = require("filesystem")
local shell = require("shell")
local proxy = ...
Fs.mount(proxy, "/fp")
--shell setWorkingDirectory /flp
-- shell.setWorkingDirectory("/flp")
-- shell.execute("demo.lua")