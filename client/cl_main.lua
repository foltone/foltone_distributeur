ESX = nil

local accounts = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	  ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 500

        local object, distance = ESX.Game.GetClosestObject()
        local model = GetEntityModel(object)
        local pos = GetEntityCoords(object)

		for k, v in pairs(Config.listProps) do
            if model == v.hash then
                if distance <= 1.3 then
                    wait = 0
                    DrawMarker(1, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 3.0, v.color.r, v.color.g, v.color.b, 250, false, false, 2, false, false, false, false)
                    ESX.ShowHelpNotification(_U(v.type), 1) 
                    if IsControlJustPressed(1, 51) then
                        for i = 1, #ESX.PlayerData.accounts, 1 do
                            if ESX.PlayerData.accounts[i].name == 'money'  then
                                if ESX.PlayerData.accounts[i].money >= v.price then
                                    Citizen.CreateThread(function()
                                        local pid = PlayerPedId()
                                        FreezeEntityPosition(pid, true)
                                        RequestAnimDict("amb")
                                        RequestAnimDict("amb@prop_human_parking_meter@male@idle_a")
                                        RequestAnimDict("amb@prop_human_parking_meter@male@idle_a")
                                        while (not HasAnimDictLoaded("amb@prop_human_parking_meter@male@idle_a")) do Citizen.Wait(0) end
                                        TaskPlayAnim(pid,"amb@prop_human_parking_meter@male@idle_a","idle_a",1.0,-1.0, 5000, 0, 1, true, true, true)
                                        Citizen.Wait(3000)
                                        ClearPedTasksImmediately(pid)
                                        TaskStartScenarioInPlace(pid, "prop_human_bum_bin", 0, false)
                                        Citizen.Wait(1500)
                                        ClearPedTasksImmediately(pid)
                                        FreezeEntityPosition(pid, false)
                                        TriggerServerEvent("foltone:buy_distrib", v.price, v.item)
                                    end)
                                else
                                    ESX.ShowAdvancedNotification('Information!', "~r~Pas assez de liquide!", '', 'CHAR_BLOCKED', 9)
                                end
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(wait)
	end
end)
