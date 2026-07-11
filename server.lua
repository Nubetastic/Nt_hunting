local RSGCore = exports['rsg-core']:GetCoreObject()


-- Server-side script for rsg_skinning
local logFile = (GetResourcePath(GetCurrentResourceName()) .. "/MissingAnimals.log")

-- Handle hunting reward from client
RegisterNetEvent("rsg_hunting:giveHuntingReward")
AddEventHandler("rsg_hunting:giveHuntingReward", function(item, amount, entity, quality)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    if not Player then 
        print("[HUNTING] Error: Player not found for source: " .. src)
        return 
    end
    
    -- Set default quality if not provided
    quality = quality or 1
    
    -- Validate the item exists in the shared items
    local itemData = RSGCore.Shared.Items[item:lower()]
    if not itemData then
        print("[HUNTING] Error: Item not found in shared items: " .. item)
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Hunting Error',
            description = 'Unknown item: ' .. item,
            type = 'error',
            position = 'top-right',
            duration = 4000
        })
        return
    end
    
    local itemLabel = itemData.label or item
    
    -- Determine quality text for notification
    local qualityText = ""
    if quality == 0 then
        qualityText = "poor quality "
    elseif quality == 1 then
        qualityText = "good quality "
    elseif quality == 2 then
        qualityText = "perfect quality "
    elseif quality == 3 then
        qualityText = "legendary quality "
    end
    
    -- Try to add the item to the player's inventory
    local success = Player.Functions.AddItem(item, amount)
    
    if success then
        if Config.InvNotify then
            local playerId = Player.PlayerData.source
            exports['Nt_Utilities']:ItemNotify(playerId, item, amount, 'add')
        else
            -- Item was added successfully
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Hunting',
                description = 'You received ' .. amount .. 'x ' .. itemLabel,
                type = 'success',
                position = 'top-right',
                duration = 4000
            })
        end
    else
        -- Notify the player
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Hunting',
            description = 'Inventory full! ',
            type = 'error',
            position = 'top-right',
            duration = 4000
        })
        
        -- Set success to true so the animal gets deleted
        success = true
    end
    
    -- Notify the client with success status and entity ID for deletion
    -- Add a small delay to ensure the client has time to process previous notifications
    Citizen.Wait(100)
    TriggerClientEvent('rsg_hunting:rewardResult', src, success, entity)
end)

RegisterNetEvent("rsg_skinning:logMissingAnimal")
AddEventHandler("rsg_skinning:logMissingAnimal", function(pedName, ped)
    local _source = source
    local playerName = GetPlayerName(_source)
    local logMsg = ("[%s] Player: %s | Ped: %s | PedID: %s\n"):format(os.date("%Y-%m-%d %H:%M:%S"), playerName, tostring(pedName), tostring(ped))
    -- Log to file (if supported) or print to console
    print("[RSG_SKINNING][MISSING] " .. logMsg)
    -- Optionally, write to a file if your server supports it
    local file = io.open(logFile, "a")
    if file then file:write(logMsg) file:close() end
end)

-- Event to handle player inventory changes that might indicate skinning completion
RegisterNetEvent('inventory:server:UpdateInventory')
AddEventHandler('inventory:server:UpdateInventory', function(playerId)
    -- This event would need to be implemented by your inventory system
    -- It should fire whenever a player's inventory changes
    -- We can use it to detect when a player receives a pelt or animal parts
    
    -- Get the player's inventory
    local Player = RSGCore.Functions.GetPlayer(playerId)
    if not Player then return end
    
    -- Check if the player has recently received hunting-related items
    local inventory = Player.PlayerData.items
    local huntingItems = {
        "h_medium_pelt",
        "h_large_pelt",
        "h_small_pelt",
        "h_small_animal",
        "h_feather",
        "h_reptile_skin",
        "h_turtle_shell",
        "h_legendary_pelt",
        "h_wool",
        "h_meat_game",
        "h_meat_big_game",
        "h_meat_small_game",
        "h_meat_bird",
        "h_meat_reptile",
        "h_meat_legendary",
        "h_meat_mutton",
        "h_animal_fat",
        "h_animal_heart",
        "h_antler_buck",
        "h_antler_elk",
        "h_antler_moose",
        "h_bullgator_eye",
        "h_claw_animal",
        "h_claw_bird",
        "h_foot_lizard",
        "h_foot_rabbit",
        "h_head_goat",
        "h_head_sheep",
        "h_hide_cow",
        "h_horn_animal",
        "h_pigs_feet",
        "h_tusk_boar",
        "h_tusk_javolina",
        "h_leather",
        "h_leather_pelt",
        "h_leather_small",
        "h_pelt_badger",
        "h_pelt_beaver",
        "h_pelt_beaver_legendary",
        "h_pelt_coyote",
        "h_pelt_coyote_legendary",
        "h_pelt_fox",
        "h_pelt_fox_legendary",
        "h_pelt_muskrat",
        "h_pelt_opossum",
        "h_pelt_peccary",
        "h_pelt_rabbit",
        "h_pelt_raccoon",
        "h_pelt_skunk",
        "h_pelt_wolf",
        "h_pelt_wolf_legendary",
        "h_skin_alligator",
        "h_skin_alligator_legendary",
        "h_skin_armadillo",
        "h_skin_bear",
        "h_skin_bear_grizzly_legendary",
        "h_skin_buck",
        "h_skin_buck_legendary",
        "h_skin_buffalo",
        "h_skin_buffalo_legendary",
        "h_skin_cougar",
        "h_skin_cougar_legendary",
        "h_skin_deer",
        "h_skin_iguana",
        "h_skin_elk",
        "h_skin_elk_legendary",
        "h_skin_goat",
        "h_skin_javelina_boar",
        "h_skin_javelina_boar_legendary",
        "h_skin_lizard",
        "h_skin_moose",
        "h_skin_moose_legendary",
        "h_skin_panther",
        "h_skin_panther_legendary",
        "h_skin_pig",
        "h_skin_pronghorn",
        "h_skin_pronghorn_legendary",
        "h_skin_ram",
        "h_skin_ram_legendary",
        "h_snake_skin",
        -- Add more hunting items as needed
    }
    
    for _, item in pairs(inventory) do
        for _, huntingItem in ipairs(huntingItems) do
            if item.name == huntingItem and item.created and (os.time() - item.created) < 5 then
                -- Player has recently received a hunting item (within the last 5 seconds)
                -- This likely indicates skinning completion
                TriggerClientEvent('rsg_hunting:serverDetectedSkinningComplete', playerId)
                return
            end
        end
    end
end)

-- Command to simulate skinning completion (for testing)
RegisterCommand('complete_skinning', function(source, args, rawCommand)
    local _source = source
    -- Trigger the client event for the player who completed skinning
    TriggerClientEvent('rsg_hunting:nativeSkinningComplete', _source)
end, false)
