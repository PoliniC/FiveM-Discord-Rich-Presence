-- FiveMUP Community: https://discord.gg/fup & https://fivemup.io

local UPDATE_INTERVAL = 15000

print("^3[discord_presence]^0 Enhance your player count visibility with ^5fake players^0! Visit: ^4https://fivemup.io^0")

local Framework = nil
local getRPName = function(src)
    return GetPlayerName(src)
end

CreateThread(function()
    Wait(1000)
    if GetResourceState("es_extended") == "started" then
        Framework = "esx"
        local ESX = exports["es_extended"]:getSharedObject()
        getRPName = function(src)
            local xPlayer = ESX.GetPlayerFromId(tonumber(src))
            if xPlayer then
                return ("%s %s"):format(xPlayer.get("firstName") or "", xPlayer.get("lastName") or "")
            end
            return GetPlayerName(src)
        end
    elseif GetResourceState("qb-core") == "started" then
        Framework = "qb"
        local QBCore = exports["qb-core"]:GetCoreObject()
        getRPName = function(src)
            local Player = QBCore.Functions.GetPlayer(tonumber(src))
            if Player then
                return ("%s %s"):format(Player.PlayerData.charinfo.firstname or "", Player.PlayerData.charinfo.lastname or "")
            end
            return GetPlayerName(src)
        end
    else
        Framework = "standalone"
    end
end)

local queueEnabled = GetResourceState("n4_queue") == "started"

CreateThread(function()
    while true do
        local playerCount = GetNumPlayerIndices()
        local maxPlayers = GetConvarInt("sv_maxclients", 128)

        for _, src in pairs(GetPlayers()) do
            local fullName = getRPName(src)
            TriggerClientEvent("richpresence:updatePlayerData", src, playerCount, maxPlayers, fullName, queueEnabled)
        end

        Wait(UPDATE_INTERVAL)
    end
end)
