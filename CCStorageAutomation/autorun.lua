local Fs = require("filesystem")
local shell = require("shell")
local proxy = ...
Fs.mount(proxy, "/fp")
