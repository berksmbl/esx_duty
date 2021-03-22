ESX                           = nil
local PlayerData              = {}
local dutyjobsinfo            = {}
local offdutyjobsinfo         = {}
local OnDutyJobsList          = {}
local OffDutyJobsList         = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

ShowHelpNotification = function(msg)
    SetTextComponentFormat("DUTYSTRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('DUTYSTRING', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('DUTYSTRING')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

DrawText3D = function(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('DUTYSTRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if not dutyjobsinfo[v.job] then OnDutyJobsList[#OnDutyJobsList+1] = v.job end
		if not offdutyjobsinfo[v.offjob] then OffDutyJobsList[#OffDutyJobsList+1] = v.offjob end
		dutyjobsinfo[v.job] = v.offjob
		offdutyjobsinfo[v.offjob] = v.job
	end
    while true do
        local Sleep = 1000
        if ESX and PlayerData.job then
			local playerjob = PlayerData.job.name
			if dutyjobsinfo[playerjob] or offdutyjobsinfo[playerjob] then
				for k,v in pairs(Config.Zones) do
					if playerjob == v.job or playerjob == v.offjob then
						local coords = GetEntityCoords(GetPlayerPed(-1))
						local dist = 999.0
						if Config.DistanceMethod == 'Vdist' then
							dist = Vdist(coords, v.Pos.x, v.Pos.y, v.Pos.z)
						else
							dist = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
						end
						if(dist <= Config.DrawDistance)then
							Sleep = 5
							local r,g,b = 0,255,0
							local duty = _U('duty1')
							if playerjob == v.offjob then duty = _U('duty2') r,g,b = 255,0,0 end
							DrawMarker(6, v.Pos.x, v.Pos.y, v.Pos.z - 0.975, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, r,g,b, 100, false, true, 2, false, false, false, false)
							if(dist <= v.Size.x)then
								if Config.HelpText == '3DText' then
									DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z),duty,0.75)
								elseif Config.HelpText == 'Floating' then
									ShowFloatingHelpNotification(duty,vector3(v.Pos.x, v.Pos.y, v.Pos.z))
								else
									ShowHelpNotification(duty)
								end
								if IsControlJustPressed(0, 38) then
									TriggerServerEvent('esx_duty:changeDutyStatus')
								end
							end
							if Config.JustCanSeeOne then
								break
							end
						end
					end
				end
			else
				Sleep = 2000
			end
        else
            Sleep = 3000
        end
        Wait(Sleep)
    end
end)