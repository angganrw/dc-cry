ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('tes', function(source, args, rawCommand)
    TriggerClientEvent("ws-admintools:tes", source)
end)
