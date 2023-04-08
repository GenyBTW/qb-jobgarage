local QBCore = exports['qb-core']:GetCoreObject()
local Peds = {}

RegisterNetEvent('qb-jobgarage:garage', function(bs)
    local vehicle = bs.vehicle
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == Config.Job then
            if vehicle == Config.car then
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, 'change me') -- Put the you want on license plate here
                    SetFuel(veh, 100.0)
                    SetEntityHeading(vehicle, 34.65)
                    TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
                    SetVehicleEngineOn(veh, true, true)
				end, Config.carspawn["change me"].coords, true)
            end
        else 
            QBCore.Functions.Notify('You are not an employee', 'error')
        end
    end)    
end)

RegisterNetEvent('qb-jobgarage:storecar', function()
    local Player = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Notify('Vehicle Stored!', 'primary')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
	NetworkFadeOutEntity(car, true,false)
    Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)

RegisterNetEvent('qb-jobgarage:menu:garage', function()
    exports['qb-menu']:openMenu({
        {
            header = 'News Van Spawner', -- Change this
            isMenuHeader = true,
        },
        {
            header = 'Spawn Van', -- Change this
            txt = 'Click me please', -- Change this
            params = {
                event = 'qb-jobgarage:garage', 
                args = {
                    vehicle = Config.car,
                }
            }
        },
        {
            header = 'Store Vehicle', -- Change this
            txt = 'Store Vehicle Inside Garage', -- Change this
            params = {
                event = 'qb-jobgarage:storecar', 
                args = {
                    
                }
            }
        },
    })
end)

CreateThread(function()
	while true do
		Wait(500)
		for k,v in pairs(Config.Pedlocation) do
			local playerCoords = GetEntityCoords(PlayerPedId())
			local distance = #(playerCoords - v.coords.xyz)
			if distance < Config.DistanceSpawn and not Peds[k] then
				local spawnedPed = NearPed(v.model, v.coords, v.gender, v.animDict, v.animName, v.scenario)
				Peds[k] = { spawnedPed = spawnedPed }
			end
			if distance >= Config.DistanceSpawn and Peds[k] then
				if Config.FadeIn then
					for i = 255, 0, -51 do
						Wait(50)
						SetEntityAlpha(Peds[k].spawnedPed, i, false)
					end
				end
				DeletePed(Peds[k].spawnedPed)
				Peds[k] = nil
			end
		end
	end
end)

function NearPed(model, coords, gender, animDict, animName, scenario)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(50)
	end
	if Config.MinusOne then
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
	else
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z, coords.w, false, true)
	end
	SetEntityAlpha(spawnedPed, 0, false)
	if Config.Frozen then
		FreezeEntityPosition(spawnedPed, true)
	end
	if Config.Invincible then
		SetEntityInvincible(spawnedPed, true)
	end
	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	end
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(50)
		end
		TaskPlayAnim(spawnedPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
    if scenario then
        TaskStartScenarioInPlace(spawnedPed, scenario, 0, true)
    end
	if Config.FadeIn then
		for i = 0, 255, 51 do
			Wait(50)
			SetEntityAlpha(spawnedPed, i, false)
		end
	end
	return spawnedPed
end

function SetFuel(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end
