-- This is a LUA script for the Vera Home Automation Z-Wave controller. 
-- It will check the status of your outside light each hour and turn the light on or off based on the time of day.

--Instructions:
--Create a new scene with no devices or triggers, only a schedule that runs this script every hour.
--Copy and paste this code (remember to change the LSdeviceNo bellow to that of your outside light) into the LUUP tab

-- Change this value to the number of your outside light. (This is the only part that needs to be changed)
local LSdeviceNo = 139 -- outside light by BBQ


local LS_SID = "urn:upnp-org:serviceId:SwitchPower1" -- Light Service ID
local switchState = luup.variable_get(LS_SID, "Status", LSdeviceNo) or "1"


if (luup.is_night() == true and switchState == "0") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "1"}, LSdeviceNo)
end

if (luup.is_night() == false and switchState == "1") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "0"}, LSdeviceNo)
end
