Citizen.CreateThread( function()
    updatePath = "/Haze-ts/HXZ-FACTIONS"
    resourceName = "HXZ-FACTIONS ("..GetCurrentResourceName()..")"
    
    function checkVersion(err,responseText, headers)
        curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
    
        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("^1——————————————————————| Attenzione |—————————————————————")
            print("            ^0Nuova versione disponibile [^1"..responseText.."^0]")
            print("         ^5https://github.com/Haze-ts/HXZ-FACTIONS")
            print("^1——————————————————————| Attenzione |—————————————————————^0")
        elseif tonumber(curVersion) > tonumber(responseText) then
            print("In qualche modo hai saltato alcune versioni di "..resourceName.." o il git è andato offline, se è ancora online ti consiglio di aggiornare (o eseguire il downgrade?)")
        end
    end
    
    PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
    end)