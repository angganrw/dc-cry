local ped = PlayerPedId()
local godMode = false
local invisibility = false

-- RELOAD

RegisterNetEvent('ws-admintools:ReloadWeapon')
AddEventHandler('ws-admintools:ReloadWeapon', function()
    hash = GetSelectedPedWeapon(ped)

    if IsPedArmed(ped, 6) then
		TaskReloadWeapon(ped)
        SetPedAmmo(ped, hash, 250)
        exports["mythic_notify"]:DoHudText("inform", "Amunisi telah terisi!")
    elseif hash ~= nil then
        exports["mythic_notify"]:DoHudText("error", "Anda tidak memegang senjata yang benar!")
    end
end)

-- ARMOUR & DARAH

RegisterNetEvent('ws-admintools:Life')
AddEventHandler('ws-admintools:Life', function()
	SetPedArmour(ped, 100)
	SetEntityHealth(ped, 200)
	exports["mythic_notify"]:DoHudText("success", "Succes Command Life")
end)

-- GOD MODE

RegisterNetEvent('ws-admintools:GodMode')
AddEventHandler('ws-admintools:GodMode', function()
	godMode = not godMode
	if godMode then
		SetEntityInvincible(ped, true)
		SetPlayerInvincible(ped, true)
		SetEntityOnlyDamagedByPlayer(ped, false)
		SetEntityCanBeDamaged(ped, false)
		SetEntityProofs(ped, true, true, true, true, true, true, true, true)
		exports["mythic_notify"]:DoHudText("success", "GOODMODE is Aktif")
	  else
		SetEntityInvincible(ped, false)
		SetPlayerInvincible(ped, false)
		SetEntityOnlyDamagedByPlayer(ped, true)
		SetEntityCanBeDamaged(ped, true)
		SetEntityProofs(ped, false, false, false, false, false, false, false, false)
		exports["mythic_notify"]:DoHudText("error", "GOODMODE is Non-Aktif")
	  end
end)

-- HILANG [invisible]

RegisterNetEvent("ws-admintools:hilang")
AddEventHandler("ws-admintools:hilang", function()
  invisibility = not invisibility
  SetEntityVisible(ped, not invisibility, 0)
  SetForcePedFootstepsTracks(invisibility)
  if invisibility then
    exports["mythic_notify"]:DoHudText("success", "INVISIBLE Is Aktif")
  else
    exports["mythic_notify"]:DoHudText("error", "INVISIBLE Is Non-Aktif")
  end
end)

-- PERBAIKI KENDARAAN

RegisterNetEvent('ws-admintools:RepairVehicle')
AddEventHandler('ws-admintools:RepairVehicle', function()
	if IsPedInAnyVehicle(ped, false) then
		local vehicle = GetVehiclePedIsIn(ped, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
        exports["mythic_notify"]:DoHudText("success", "Kendaraan mu telah terperbaiki")
	else
        exports["mythic_notify"]:DoHudText("error", "Kamu tidak sedang dikendaraan")
	end
end)

-- CUCI KENDARAAN

RegisterNetEvent('ws-admintools:CleanVehicle')
AddEventHandler('ws-admintools:CleanVehicle', function()
	if IsPedInAnyVehicle(ped, false) then
		local vehicle = GetVehiclePedIsIn(ped, false)
		SetVehicleDirtLevel(vehicle, 0)
		exports["mythic_notify"]:DoHudText("success", "Kendaraan mu telah dibersihkan")
	else
		exports["mythic_notify"]:DoHudText("error", "Kamu tidak sedang dikendaraan")
	end
end)

-- Noclip

local noclip = false
RegisterNetEvent("ws-admintools:noclip")
AddEventHandler("ws-admintools:noclip", function(input)
    local player = PlayerId()
	local ped = PlayerPedId

	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
        exports["mythic_notify"]:DoHudText('success', "NOCLIP Is Aktif")
	else
        exports["mythic_notify"]:DoHudText('inform', "NOCLIP Is Non-Aktif")
    end

	noclip = not noclip

	end)
	
	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25)

		if(noclip)then
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 2.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 2.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- COPY COORDINATE

RegisterNetEvent('ws-admintools:coords')
AddEventHandler('ws-admintools:coords', function(cb)

	heading = GetEntityHeading(PlayerPedId())
	x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))

	roundx = tonumber(string.format("%.2f", x))
	roundy = tonumber(string.format("%.2f", y))
	roundz = tonumber(string.format("%.2f", z))
	roundh = tonumber(string.format("%.2f", heading))
	
	cb(roundx, roundy, roundz, roundh)
	
	print("Kordinat Berhasil Disalin!")

	exports["mythic_notify"]:DoHudText('inform', '✅ | SUCCES", "- Kordinat Berhasil Disalin!')

end)

RegisterNetEvent('ws-admintools:head')
AddEventHandler('ws-admintools:head', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = "".. roundh .."" })
	end)
	
end)

RegisterNetEvent('ws-admintools:cc')
AddEventHandler('ws-admintools:cc', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = "".. roundx ..", ".. roundy ..", ".. roundz .."" })
	end)
	
end)

RegisterNetEvent('ws-admintools:cc2')
AddEventHandler('ws-admintools:cc2', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = "x = ".. roundx ..", y = ".. roundy ..", z = ".. roundz .."" })
	end)

end)

RegisterNetEvent('ws-admintools:cc3')
AddEventHandler('ws-admintools:cc3', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = "".. roundx .." ".. roundy .." ".. roundz .."" })
	end)

end)

RegisterNetEvent('ws-admintools:cc4')
AddEventHandler('ws-admintools:cc4', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = '["x"] = '.. roundx ..', ["y"] = '.. roundy ..', ["z"] = '.. roundz ..'' })
	end)

end)

RegisterNetEvent('ws-admintools:cc5')
AddEventHandler('ws-admintools:cc5', function()

	TriggerEvent('ws-admintools:coords', function() 
		SendNUIMessage({ coords = '["x"] = '.. roundx ..', ["y"] = '.. roundy ..', ["z"] = '.. roundz ..'' })
	end)

end)

-- COPY OBJECT COORDINATE

local coordsText = ""
local headingText = ""
local modelText = ""

function getEntity(player)
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

RegisterCommand('objecthash', function(source, args, rawCommand)
    if IsPlayerFreeAiming(PlayerId()) then
        local entity = getEntity(PlayerId())
        local model = GetEntityModel(entity)
        modelText = model

		if modelText ~= 0 then
			SendNUIMessage({
				coords = "" .. modelText .. ""
			})
			exports["mythic_notify"]:DoHudText('success', "Berhasil mendapatkan informasi object!")
			exports["mythic_notify"]:DoHudText('inform', "" .. modelText .. "")
		else
			exports["mythic_notify"]:DoHudText('error', "Kamu belum mengarahkan senjata pada object!")
		end
    end
end, false)

RegisterCommand('objectcoordinate', function(source, args, rawCommand)
    if IsPlayerFreeAiming(PlayerId()) then
        local entity = getEntity(PlayerId())
        local coords = GetEntityCoords(entity)
        coordsText = coords

		if coordsText ~= vector3(0,0,0) then
			SendNUIMessage({
				coords = "" .. coordsText .. ""
			})
			exports["mythic_notify"]:DoHudText('success', "Berhasil mendapatkan informasi object!")
			exports["mythic_notify"]:DoHudText('inform', "" .. coordsText .. "")
		else
			exports["mythic_notify"]:DoHudText('error', "Kamu belum mengarahkan senjata pada object!")
		end
    end
end, false)

RegisterCommand('objectcoordshead', function(source, args, rawCommand)
    if IsPlayerFreeAiming(PlayerId()) then
        local entity = getEntity(PlayerId())
        local coords = GetEntityCoords(entity)
        local heading = GetEntityHeading(entity)
        coordsText = coords
        headingText = heading

		if coordsText ~= vector3(0,0,0) and headingText ~= 0.0 then
			SendNUIMessage({
				coords = "" .. headingText .. ""
			})
			exports["mythic_notify"]:DoHudText('success', "Berhasil mendapatkan informasi object!")
			exports["mythic_notify"]:DoHudText('inform', "" .. coordsText .. " | " ..  headingText .. "")
		else
			exports["mythic_notify"]:DoHudText('error', "Kamu belum mengarahkan senjata pada object!")
		end
    end
end, false)

RegisterCommand('full', function(source, args, rawCommand)
    if IsPlayerFreeAiming(PlayerId()) then
        local entity = getEntity(PlayerId())
        local model = GetEntityModel(entity)
        local coords = GetEntityCoords(entity)
        local heading = GetEntityHeading(entity)
        modelText = model
        coordsText = coords
        headingText = heading

		if coordsText ~= vector3(0,0,0) and headingText ~= 0.0 and modelText ~= 0 then
			SendNUIMessage({
				coords = "Coordinates : " .. coordsText .. " | Heading : " .. headingText .. " | Object : " .. modelText
			})
			exports["mythic_notify"]:DoHudText('success', "Berhasil mendapatkan informasi object!")
			exports["mythic_notify"]:DoHudText('inform', coordsText .. " | " .. headingText .. " | " .. modelText)
		else
			exports["mythic_notify"]:DoHudText('error', "Kamu belum mengarahkan senjata pada object!")
		end
    end
end, false)

-- KeyMapping
RegisterKeyMapping("objecthash", "Object Hash", "keyboard", "E")
RegisterKeyMapping("objectcoordinate", "Object Coordinate", "keyboard", "F9")
RegisterKeyMapping("objectcoordshead", "Object Heading", "keyboard", "F10")
RegisterKeyMapping("full", "Object Info", "keyboard", "F11")