Config = {}

Config.EnableTimer = false -- If true, the timer is enabled
Config.Timer = 20 * 1000 --20 seconds
Config.Tassa = 0.5 -- Tax of 50%

Config.Cash = 'money'
Config.BlackCash = 'black_money'

Config.TriggerOutfits = 'fivem-appearance:pickNewOutfit'  -- This is a trigger to open the saved clothes menu



Config.Fazioni = {
    ballas = {
        inventario = vector3(85.617446899414,-1958.1333007813,21.124397277832),
        bossmenu = vector3(85.871192932129,-1953.0867919922,20.850170135498),
        moneywashpos = vector3(96.495780944824,-1959.7010498047,20.747640609741),
        moneywash = true,
        --Blip Map
        enableBlip = false,
        coordsBlip = vector3(84.617446899414,-1958.1333007813,21.124397277832),
        spriteBlip = 110,
        scaleBlip = 0.8,
        colourBlip = 1,
        textBlip = 'Ballas',
        --Stash
        weigthStash = 10000,
        slotStash = 50
    }
}

Config.VeicoliFazioni = {
    ballas = {
        marker = vector3(90.467529296875,-1965.9584960938,20.74747467041),
        markerspawn = vector3(90.567529296875,-1965.8584960938,20.84747467041),
        markerdelete = vector3(86.729080200195,-1970.6411132813,20.747463226318),
        heading = 317.93,
        veicolo = {
            {label = 'Vasom', value = 'vamos'},
            {label = 'Vasom', value = 'vamos'},
            {label = 'Vasom', value = 'vamos'},
            {label = 'Vasom', value = 'vamos'}
        }
    }
}

Lang = {
    ['spawnpoint_blocked']   = 'Punto di spawn occupato',
    ['stash']                = 'Inventario',
    ['clothes']              = 'Vestiti',
    --              leaning money         --
    ['time']                 = 'Tempo Rimasto: ',
    ['invalid']              = 'Quantità invalida',
    ['you_received']         = ' Hai ricevuto ',
    ['you_washed']           = 'Hai lavato ',
    ['black_money']          = ' Soldi Sporchi',
    ['money']                = ' Puliti',
}

--FUNCTION
function OpenBossMenu(k)
    TriggerEvent('esx_society:openBossMenu', k, function(data, menu)
        menu.close()
    end, {wash = false})
end