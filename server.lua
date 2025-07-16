local RSGCore = exports['rsg-core']:GetCoreObject()


-- Server-side script for rsg_skinning
local logFile = "missing_animals.log"

-- Handle hunting reward from client
RegisterNetEvent("rsg_hunting:giveHuntingReward")
AddEventHandler("rsg_hunting:giveHuntingReward", function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local itemData = RSGCore.Shared.Items[item:lower()]
    local itemLabel = itemData and itemData.label or item
    -- Add the item to the player's inventory and check result
    local success = Player.Functions.AddItem(item, amount)
    -- Notify with rNotify
    if success then
        TriggerClientEvent('rNotify:NotifyLeft', src, 'Hunting', 'You received '..amount..'x '..itemLabel, 'generic_textures', 'tick', 4000)
    else
        TriggerClientEvent('rNotify:NotifyLeft', src, 'Hunting', 'Failed to add '..amount..'x '..itemLabel..' (inventory full)', 'menu_textures', 'cross', 4000)
    end
    -- Notify the client with only true/false for entity deletion
    TriggerClientEvent('rsg_hunting:rewardResult', src, success)
end)

RegisterNetEvent("rsg_skinning:logMissingAnimal")
AddEventHandler("rsg_skinning:logMissingAnimal", function(pedName, ped)
    local _source = source
    local playerName = GetPlayerName(_source)
    local logMsg = ("[%s] Player: %s | Ped: %s | PedID: %s\n"):format(os.date("%Y-%m-%d %H:%M:%S"), playerName, tostring(pedName), tostring(ped))
    -- Log to file (if supported) or print to console
    print("[RSG_SKINNING][MISSING] " .. logMsg)
    -- Optionally, write to a file if your server supports it
    -- local file = io.open(logFile, "a")
    -- if file then file:write(logMsg) file:close() end
end)
