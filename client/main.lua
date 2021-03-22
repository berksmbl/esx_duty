--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
ESX                           = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

  ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

----markers
AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
  CurrentActionData, CurrentActionMsg = {}, ''
	CurrentAction     = nil
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
  CurrentActionData, CurrentActionMsg = {}, ''
  CurrentAction     = nil
end)

-- enter exit marker job events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil
    local sleep = true

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
        local jobName = ESX.PlayerData.job.name

        if string.match(jobName, "off") then jobName = jobName:gsub("%off", "") end

        if v.JobRequired == jobName then
          sleep = false
          isInMarker  = true
          currentZone = k

          CurrentAction     = 'esx_duty_changejob'
          CurrentActionMsg  = _U('duty')
          CurrentActionData = {}
        end
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker', LastZone)
    end

    if sleep then
      Citizen.Wait(1000)
    end
  end
end)

--keycontrols
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(5)
    
    if CurrentAction ~= nil then
      ESX.ShowHelpNotification(CurrentActionMsg, true)

      if IsControlJustReleased(0, 38) then
        TriggerServerEvent('esx_duty:changeDutyStatus')
      end

      CurrentActionData, CurrentActionMsg = {}, ''
      CurrentAction     = nil
    end
  end
end)

-- display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))
    local sleep = true

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then

        local jobName = ESX.PlayerData.job.name
        if string.match(jobName, "off") then jobName = jobName:gsub("%off", "") end

        if v.JobRequired == jobName then
          sleep = false
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end

    if sleep then
      Citizen.Wait(1000)
    end
  end
end)
