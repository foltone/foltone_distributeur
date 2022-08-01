
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('foltone:buy_distrib')
AddEventHandler('foltone:buy_distrib', function(price, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
    xPlayer.removeMoney(price)
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Information!', '~g~Achat effectué!', '', 'CHAR_BANK_FLEECA', 9)
end)
