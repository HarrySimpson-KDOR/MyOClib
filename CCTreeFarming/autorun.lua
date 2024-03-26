local Fs = require("filesystem")
local shell = require("shell")
local proxy = ...
Fs.mount(proxy, "/fp")
shell setWorkingDirectory /fp
shell.setWorkingDirectory("/fp")
shell.execute("run.lua")