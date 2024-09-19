local lastShotCoords = nil
local canTeleport = false
local notificationActive = false

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) and notificationActive then
            local playerCoords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('fire:weaponFired', playerCoords)
            Citizen.Wait(5000)
        end
    end
end)

RegisterNetEvent('fire_alert:notifyAdmin')
AddEventHandler('fire_alert:notifyAdmin', function(coords)
    if notificationActive then
        lastShotCoords = coords
        canTeleport = true
        ESX.ShowAdvancedNotification('Skyline Serveur', '', 'Un tir d\'arme détecté. Appuyez sur Y pour vous téléporter à la position du tir.', 'CHAR_MP_FM_CONTACT', 1)
        Citizen.SetTimeout(10000, function()
            canTeleport = false
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if lastShotCoords and canTeleport and notificationActive and IsControlJustReleased(0, 246) then
            SetEntityCoords(PlayerPedId(), lastShotCoords.x, lastShotCoords.y, lastShotCoords.z)
            lastShotCoords = nil
            canTeleport = false
        end
    end
end)