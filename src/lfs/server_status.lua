local module = ...

local function process()
  local ip, nm, gw = wifi.sta.getip()
  local device = require("device")
  local settings = require("settings")
  settings.token = nil
  settings.aws = nil

  local body = {
    hwVersion = device.hwVersion,
    swVersion = device.swVersion,
    heap = node.heap(),
    uptime = tmr.time(),
    ip = ip,
    port = math.floor(node.chipid()/1000) + 8000,
    nm = nm,
    gw = gw,
    mac = wifi.sta.getmac(),
    rssi = wifi.sta.getrssi(),
    sensors = require("sensors"),
    actuators = require("actuators"),
    dht_sensors = require("dht_sensors"),
    ds18b20_sensors = require("ds18b20_sensors"),
    settings = settings
  }
  return sjson.encode(body)
end

return function()
  package.loaded[module] = nil
  module = nil
  return process()
end