ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback("foltone_distributeur:checkMoney", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("foltone_distributeur:giveItem")
AddEventHandler("foltone_distributeur:giveItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
end)
