local allMyOutfits = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	Citizen.Wait(0)
end)

--Boss Menu Fazioni
Citizen.CreateThread(function()
	for k,v in pairs(Config.Fazioni) do
		TriggerEvent('gridsystem:registerMarker', {
			name = 'BossActions' ..k,
			pos = v.bossmenu, -- Insert Cordinate x,y,z
			scale = vector3(0.5, 0.5, 0.5),
			size = vector3(0.7, 0.7, 0.7),
			msg = '~f~[E]~w~ Boss Menu', -- Msg With Interaction
			--float3d = 0.1, -- Text Float
			show3D = 0.2, -- Text 3D
			permission = k,
			jobGrade = 0, -- Grade Of Job To Open
			control = 'E', -- Input Control
			type = 29, -- Type Marker
			shouldRotate = true,
			color = { r = 255, g = 0, b = 0 }, -- Color Marker
			action = function()
				local PlayerData = ESX.GetPlayerData()
				if PlayerData.job.grade_name ~= 'boss' then
					ESX.ShowNotification('Non Sei Direttore')
				else
					OpenBossMenu(k)
				end
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
		})
	end
end)


--Fazioni Inventario
Citizen.CreateThread(function()
	for k,v in pairs(Config.Fazioni) do
		TriggerEvent('gridsystem:registerMarker', {
			name = 'Inventario' ..k,
			pos = v.inventario, -- Insert Cordinate x,y,z
			scale = vector3(0.5, 0.5, 0.5),
			size = vector3(0.3, 0.3, 0.3),
			msg = '~f~[E]~w~ Apri Deposito', -- Msg With Interaction
			--float3d = 0.1, -- Text Float
			show3D = 0.2, -- Text 3D
			permission = k,
			jobGrade = 0, -- Grade Of Job To Open
			control = 'E', -- Input Control
			type = 20, -- Type Marker
			shouldRotate = true,
			color = { r = 255, g = 0, b = 0 }, -- Color Marker
			action = function()
				print('Cioa')
				exports.ox_inventory:openInventory('stash', 'society_' ..k)
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
		})
	end
end)


--MoneyWash Fazioni
Citizen.CreateThread(function()
	for k,v in pairs(Config.Fazioni) do
		if v.moneywash then
			TriggerEvent('gridsystem:registerMarker', {
				name = 'MoneyWash' ..k,
				pos = v.moneywashpos, -- Insert Cordinate x,y,z
				scale = vector3(0.9, 0.9, 0.9),
				size = vector3(0.9, 0.9, 0.9),
				msg = '~f~[E]~w~ Pulizia Soldi', -- Msg With Interaction
				--float3d = 0.1, -- Text Float
				show3D = 0.2, -- Text 3D
				permission = k,
				jobGrade = 0, -- Grade Of Job To Open
				control = 'E', -- Input Control
				type = 20, -- Type Marker
				shouldRotate = true,
				color = { r = 255, g = 0, b = 0 }, -- Color Marker
				action = function()
					MoneyWash(k)
				end,
				onExit = function()
					ESX.UI.Menu.CloseAll()
				end
			})
		end
	end
end)

--Veicoli Fazioni
Citizen.CreateThread(function()
	for k,v in pairs(Config.VeicoliFazioni) do
		TriggerEvent('gridsystem:registerMarker', {
			name = 'Veicoli' ..k,
			pos = v.marker, -- Insert Cordinate x,y,z
			scale = vector3(0.5, 0.5, 0.5),
			size = vector3(0.7, 0.7, 0.7),
			msg = '~f~[E]~w~ Apri Garage', -- Msg With Interaction
			--float3d = 0.1, -- Text Float
			show3D = 0.2, -- Text 3D
			permission = k,
			jobGrade = 0, -- Grade Of Job To Open
			control = 'E', -- Input Control
			type = 36, -- Type Marker
			shouldRotate = true,
			color = { r = 255, g = 0, b = 0 }, -- Color Marker
			action = function()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'prendi-veicolo', {
					title = 'Veicolo',
					align = 'right',
					elements = v.veicolo
				},  function(data, menu)           
						ESX.Game.SpawnVehicle(data.current.value, v.markerspawn, v.heading, function(vehicle)
							SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
						end)
						menu.close()
					end, 
					function(data, menu)
						menu.close()
					end
				)
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
		})
	end
end)


--Veicoli Fazioni Elimina
Citizen.CreateThread(function()
	for k,v in pairs(Config.VeicoliFazioni) do
		TriggerEvent('gridsystem:registerMarker', {
			name = 'VeicoliDelete' ..k,
			pos = v.markerdelete, -- Insert Cordinate x,y,z
			scale = vector3(0.9, 0.9, 0.9),
			size = vector3(0.7, 0.7, 0.7),
			msg = '~f~[E]~w~ Deposita Veicolo', -- Msg With Interaction
			--float3d = 0.1, -- Text Float
			show3D = 0.2, -- Text 3D
			permission = k,
			jobGrade = 0, -- Grade Of Job To Open
			control = 'E', -- Input Control
			type = 36, -- Type Marker
			shouldRotate = true,
			color = { r = 255, g = 0, b = 0 }, -- Color Marker
			action = function()
				local vehicle = GetVehiclePedIsUsing(PlayerPedId())
				ESX.Game.DeleteVehicle(vehicle)
			end,
			onExit = function()
				ESX.UI.Menu.CloseAll()
			end
		})
	end
end)

--Funzione MoneyWash
function MoneyWash(perc)
	local input = lib.inputDialog('Pulisci soldi', {'Inserisci la somma da pulire'})
	local amount = tonumber(input[1])
	
	if amount == nil then
		ESX.ShowNotification('Quantità non valida')
		return
	else
		TriggerServerEvent('hxz_moneywash:washMoney', amount, zone)
	end
end


CreateThread(function()
	for k,v in pairs(Config.Fazioni) do
		if v.enableBlip then
			local blip = AddBlipForCoord(v.coordsBlip)

			SetBlipSprite (blip, v.spriteBlip)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.scaleBlip)
			SetBlipColour (blip, v.colourBlip)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.textBlip)
			EndTextCommandSetBlipName(blip)
		end
	end
end)