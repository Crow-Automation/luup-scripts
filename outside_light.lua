local LSdeviceNo = 139 -- outside light by BBQ
local LSdeviceNo2 = 131 -- outside laundry light
--local LSdeviceNo3 = 122 -- front door light

local LS_SID = "urn:upnp-org:serviceId:SwitchPower1" -- Light Service ID
local switchState = luup.variable_get(LS_SID, "Status", LSdeviceNo) or "1"
local switchState2 = luup.variable_get(LS_SID, "Status", LSdeviceNo2) or "1"
-- local switchState3 = luup.variable_get(LS_SID, "Status", LSdeviceNo3) or "1"


if (luup.is_night() == true and switchState == "0") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "1"}, LSdeviceNo)
end

if (luup.is_night() == true and switchState2 == "0") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "1"}, LSdeviceNo2)
end

--if (luup.is_night() == true and switchState3 == "0") then
--  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "1"}, LSdeviceNo3)
--end


if (luup.is_night() == false and switchState == "1") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "0"}, LSdeviceNo)
end


if (luup.is_night() == false and switchState2 == "1") then
  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "0"}, LSdeviceNo2)
end

--if (luup.is_night() == false and switchState3 == "1") then
--  luup.call_action(LS_SID, "SetTarget", {newTargetValue = "0"}, LSdeviceNo3)
--end
