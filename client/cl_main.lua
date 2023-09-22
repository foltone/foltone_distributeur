ESX = exports["es_extended"]:getSharedObject()

local function helpNotification(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local advencedNotification = function(title, subject, msg, icon, iconType)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, true)
end



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
                    helpNotification(v.type, 1)
                    if IsControlJustPressed(1, 51) then
                        ESX.TriggerServerCallback("foltone_distributeur:checkMoney", function(hasEnoughMoney)
                            if hasEnoughMoney then
                                local playerPed = PlayerPedId()
                                FreezeEntityPosition(playerPed, true)
                                local lib, anim = "amb@prop_human_parking_meter@male@idle_a", "idle_a"
                                RequestAnimDict(lib)
                                repeat Wait(0) until HasAnimDictLoaded(lib)
                                TaskPlayAnim(playerPed, lib, anim, 8.0, -8, -1, 1, 0, false, false, false)
                                Wait(3000)
                                ClearPedTasks(playerPed)
                                Wait(3000)
                                ClearPedTasksImmediately(playerPed)
                                TaskStartScenarioInPlace(playerPed, "prop_human_bum_bin", 0, false)
                                Wait(1500)
                                ClearPedTasksImmediately(playerPed)
                                FreezeEntityPosition(playerPed, false)
                                TriggerServerEvent("foltone_distributeur:giveItem", v.item)
                                advencedNotification("Information!", string.format("~g~Vous avez acheté un(e) %s pour %s$", v.item, v.price), "", "CHAR_BANK_FLEECA", 9)
                            else
                                advencedNotification("Information!", "~r~Vous n'avez pas assez d'argent!", "", "CHAR_BLOCKED", 9)
                            end
                        end, v.price)
                    end
                end
            end
        end
        Citizen.Wait(wait)
	end
end)
