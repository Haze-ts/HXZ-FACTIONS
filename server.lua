Citizen.CreateThread(function()
    print("^8[Haze Factions] ^0Script by Haze#2883")
end)
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for k,v in pairs(Config.Fazioni) do
            exports.ox_inventory:RegisterStash(k, 'Depostio: '..k, v.slotStash, v.weigthStash)
        end
    end
end)

function secondsToClock(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        return hours..":"..mins..":"..secs
    end
end
  
RegisterServerEvent('hxz_moneywash:washMoney')
AddEventHandler('hxz_moneywash:washMoney', function(amount, zone)
    local xPlayer = ESX.GetPlayerFromId(source)
    amount = ESX.Math.Round(tonumber(amount))
    washedCash = amount * Config.Tassa
    washedTotal = ESX.Math.Round(tonumber(washedCash))
    
    if Config.EnableTimer == true then
        local timeClock = ESX.Math.Round(Config.Timer / 1000)
    
        if amount > 0 and xPlayer.getAccount(Config.BlackCash).money >= amount then
            xPlayer.removeAccountMoney(Config.BlackCash, amount)
            TriggerClientEvent('esx:showNotification', xPlayer.source, Lang['time'] ..  secondsToClock(timeClock))
            Citizen.Wait(Config.Timer)
            
            TriggerClientEvent('esx:showNotification', xPlayer.source, Lang['you_recived'] .. ESX.Math.GroupDigits(washedTotal) .. Lang['money'])
            xPlayer.addMoney(washedTotal)
        else
        TriggerClientEvent('esx:showNotification', xPlayer.source, Lang['invalid'])
        end
    else 
    
        if amount > 0 and xPlayer.getAccount(Config.BlackCash).money >= amount then
            xPlayer.removeAccountMoney(Config.BlackCash, amount)
            TriggerClientEvent('esx:showNotification', xPlayer.source, Lang['you_recived'] .. ESX.Math.GroupDigits(washedTotal) .. '$' .. Lang['money'])
            xPlayer.addMoney(washedTotal)
        else
        TriggerClientEvent('esx:showNotification', xPlayer.source, Lang['invalid'])
        end
    end
end)

