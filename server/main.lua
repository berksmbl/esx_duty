ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('esx_duty:changeDutyStatus') 
AddEventHandler('esx_duty:changeDutyStatus', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name then
        local jobName = xPlayer.job.name 
        if string.match(jobName, "off") then 
            jobName = jobName:gsub("%off", "") xPlayer.setJob(jobName, xPlayer.job.grade)
            TriggerClientEvent('notification', _source, _U('onduty'), 1)
            return
        else
            xPlayer.setJob('off' .. jobName, xPlayer.job.grade)
            TriggerClientEvent('notification', _source, _U('offduty'), 2)
        end
    else
        print("[Hata] Oyuncunun bu eylemi gerçekleştirecek işi yok.")
    end
end)