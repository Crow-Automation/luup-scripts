-- scene to turn on the fan if we have movement and difference in humidity between 2 humidity sensors.
local bathroom_movement = 68 -- Bathroom security sensor
local bathroom_humidity = 71 -- Bathroom humidity device number
local other_humidity = 99 -- Other humidity sensor (outside)
local fan = 20 -- extraction fan

-- High humidity diff value
local humidity_diff_trip = 10
humidity_diff_trip = tonumber(humidity_diff_trip)

local humidity_min_level = 70
humidity_min_level = tonumber(humidity_min_level)

-- Sensor name
local HS_SID = "urn:micasaverde-com:serviceId:HumiditySensor1"
local FAN_SID = "urn:upnp-org:serviceId:SwitchPower1"
local SS_SID = "urn:micasaverde-com:serviceId:SecuritySensor1"

local bathroom_humidity_level = luup.variable_get (HS_SID,"CurrentLevel",bathroom_humidity)
local other_humidity_level = luup.variable_get (HS_SID,"CurrentLevel",other_humidity)
local switchState = luup.variable_get(FAN_SID, "Status", fan) or "1"
local tripped = luup.variable_get(SS_SID, "Tripped", bathroom_movement) or "0"

-- Change from a string to a number 
bathroom_humidity_level = tonumber(bathroom_humidity_level)
other_humidity_level = tonumber(other_humidity_level)

--calculate diff
humidity_diff = bathroom_humidity_level - other_humidity_level

-- switch off if humidity diff low
if (humidity_diff < humidity_diff_trip and switchState == "1" and tripped == "0" or bathroom_humidity_level < humidity_min_level and switchState == "1" and tripped == "0") then
        luup.call_action(FAN_SID, "SetTarget", {newTargetValue = "0"}, fan)
end

-- switch on if humidity diff high
if (humidity_diff >= humidity_diff_trip and switchState == "0" and bathroom_humidity_level >= humidity_min_level) then
    luup.call_action(FAN_SID, "SetTarget", {newTargetValue = "1"}, fan)
end
