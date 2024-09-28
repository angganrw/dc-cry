ESX = nil
TriggerEvent('esx:getSharedObject', function(object)
    ESX = object
end)

ESX.RegisterServerCallback('urban_prime:isPrime', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local found = false
    for k,v in pairs(Config.primes) do
        if v == xPlayer.identifier then
            found = true
            cb(true)
            break
        end
    end
    if not found then
        cb(false)
    end
end)

AddEventHandler('urban_prime:isPrime', function(identifier, cb)
    print(identifier, 'ada yang manggil')
    local found = false
    for k,v in pairs(Config.primes) do
        if v == identifier then
            found = true
            cb(true)
            break
        end
    end
    if not found then
        cb(false)
    end
end)