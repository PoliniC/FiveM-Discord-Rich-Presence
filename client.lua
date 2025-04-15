local totalPlayers = 0
local maxPlayers = 0
local playerName = "Unknown"
local queueSize = 0
local n4QueueAvailable = false

RegisterNetEvent("richpresence:updatePlayerData", function(count, max, rpName, queueEnabled)
    totalPlayers = count
    maxPlayers = max
    playerName = rpName
    n4QueueAvailable = queueEnabled
end)

CreateThread(function()
    while true do
        if n4QueueAvailable then
            local ok, result = pcall(function()
                return exports["n4_queue"]:GetQueueSize()
            end)
            if ok then queueSize = result end
        end
        Wait(15000)
    end
end)

CreateThread(function()
    SetDiscordAppId(Config.AppId)
    SetDiscordRichPresenceAsset(Config.LargeAsset.image)
    SetDiscordRichPresenceAssetText(Config.LargeAsset.text)
    SetDiscordRichPresenceAssetSmall(Config.SmallAsset.image)
    SetDiscordRichPresenceAssetSmallText(Config.SmallAsset.text)

    for i, btn in ipairs(Config.Buttons or {}) do
        if i == 1 then SetDiscordRichPresenceAction(0, btn.label, btn.url)
        elseif i == 2 then SetDiscordRichPresenceAction(1, btn.label, btn.url) end
    end

    while true do
        local line1 = string.format("Players: %d/%d | Queue Size: %d", totalPlayers, maxPlayers, queueSize)

        local name = Config.Options.showPlayerName and playerName or ""
        local location = ""

        if Config.Options.showStreetName then
            local coords = GetEntityCoords(PlayerPedId())
            local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local street = GetStreetNameFromHashKey(streetHash)

            if not street or street == "" then
                local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
                street = zone ~= nil and zone ~= "" and zone or "Secret Location"
            end

            location = street
        end

        local line2 = string.format("✔ %s is located in %s", name, location)

        SetRichPresence(line1 .. "\n" .. line2)

        Wait(Config.Options.updateInterval)
    end
end)
