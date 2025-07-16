
-- Universal skinning animation function
local function playSkinningAnim(playerPed, targetCoords)
    -- Move player towards the animal before animating
        Citizen.InvokeNative(0x94A3C1B804D291EC, playerPed, 0.0, 0.0, 0.0, 0) -- Holster Weapon
    if targetCoords then
        -- Face the animal
        TaskTurnPedToFaceCoord(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, 1000)
        Citizen.Wait(500)
        -- Walk to the animal
        TaskGoStraightToCoord(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, 20000, 0.0, 0.0)
        local start = GetGameTimer()
        while #(GetEntityCoords(playerPed) - targetCoords) > 1.2 and GetGameTimer() - start < 4000 do
            Citizen.Wait(50)
        end
        ClearPedTasks(playerPed)
    end
    -- Use a scenario as a universal animation (e.g., "WORLD_HUMAN_CROUCH_INSPECT")
    local scenario = "WORLD_HUMAN_CROUCH_INSPECT"
    TaskStartScenarioInPlace(playerPed, scenario, 0, true)
    Citizen.Wait(5000) -- Wait for animation (adjust as needed)
    ClearPedTasks(playerPed)
end

-- Debug function to print detailed information about the ped entity
local function printPedInfo(entity)
    local model = GetEntityModel(entity)
    local modelName = Citizen.InvokeNative(0xD4A969A4F0F7B229, model, Citizen.ResultAsString())
    local animalTypeHash = Citizen.InvokeNative(0xF445DE8DA80A1792, entity)
    local animalTypeName = Citizen.InvokeNative(0xD4A969A4F0F7B229, animalTypeHash, Citizen.ResultAsString())
    local labelHash = Citizen.InvokeNative(0xB94B0AB8240E42D9, model)
    local displayName = GetLabelText(labelHash)
    local pedType = GetPedType(entity)
    local relGroup = GetPedRelationshipGroupHash(entity)
    print('--- PED DEBUG INFO ---')
    print('Ped entity:', entity)
    print('Model hash:', model)
    print('Model name (GetStringFromHashKey):', modelName)
    print('Animal type hash:', animalTypeHash)
    print('Animal type name (GetStringFromHashKey):', animalTypeName)
    print('Label hash:', labelHash)
    print('Display name (GetLabelText):', displayName)
    print('Ped type:', pedType)
    print('Relationship group hash:', relGroup)
    print('----------------------')
end


-- Store the last skinned entity for deletion after reward
local lastSkinnedEntity = nil

local function giveSkinReward(entity)
    local model = GetEntityModel(entity)
    local pedType = GetPedType(entity)
    local reward = Config.AnimalList[model]
    if reward then
        lastSkinnedEntity = entity
        for i, item in ipairs(reward.givenItem) do
            local amount = reward.givenAmount[i] or 1
            TriggerServerEvent('rsg_hunting:giveHuntingReward', item, amount)
        end
    else
        TriggerEvent('rNotify:NotifyLeft', 'Hunting', 'This animal is not registered for rewards! (Model: '..model..')', 'red')
    end
end

-- Listen for reward result and delete the last skinned entity if successful
RegisterNetEvent('rsg_hunting:rewardResult')
AddEventHandler('rsg_hunting:rewardResult', function(success)
    if lastSkinnedEntity and DoesEntityExist(lastSkinnedEntity) then
        if success then
            if not NetworkHasControlOfEntity(lastSkinnedEntity) then
                NetworkRequestControlOfEntity(lastSkinnedEntity)
                local timeout = 0
                while not NetworkHasControlOfEntity(lastSkinnedEntity) and timeout < 50 do
                    Citizen.Wait(10)
                    NetworkRequestControlOfEntity(lastSkinnedEntity)
                    timeout = timeout + 1
                end
            end
            if NetworkHasControlOfEntity(lastSkinnedEntity) then
                DeleteEntity(lastSkinnedEntity)
            end
        end
        lastSkinnedEntity = nil
    end
end)


-- ox_target: ALT + look at dead animal to skin (DISABLED)
--[[
if exports and exports.ox_target then
    exports.ox_target:addGlobalPed({
        label = 'Skin Animal',
        icon = 'fa-solid fa-drumstick-bite',
        distance = Config.SkinDistance,
        canInteract = function(entity, distance, coords, name, bone)
            if not DoesEntityExist(entity) then
                print('[DEBUG] ox_target: Not found ped (entity does not exist)')
                return false
            end
            if not IsEntityDead(entity) then
                print('[DEBUG] ox_target: Not found ped (entity not dead)')
                return false
            end
            if IsPedAPlayer(entity) then
                print('[DEBUG] ox_target: Not found ped (entity is player)')
                return false
            end
            return true
        end,
        onSelect = function(data)
            local entity = data.entity
            local playerPed = PlayerPedId()
            playSkinningAnim(playerPed)
            giveSkinReward(entity)
        end,
        key = 'LMENU', -- ALT key
        hold = true,   -- Hold ALT to show
    })
end
]]

-- Proximity keybind: Hold [G] to skin nearest dead animal (with ox_lib text UI)
CreateThread(function()
    local showing = false
    local holdStart = nil
    while true do
        Wait(500)
        -- Only start scanning when G is being held
        if IsControlPressed(0, 0x760A9C6F) or IsControlPressed(0, 0x8CC9CD42) then -- G key
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local handle, ped = FindFirstPed()
            local success
            local closestPed, closestDist = nil, Config.SkinDistance
            if handle and ped then
                repeat
                    if DoesEntityExist(ped) and IsEntityDead(ped) and not IsPedAPlayer(ped) then
                        local pedCoords = GetEntityCoords(ped)
                        local dist = #(playerCoords - pedCoords)
                        if dist < closestDist then
                            closestPed = ped
                            closestDist = dist
                        end
                    end
                    success, ped = FindNextPed(handle)
                until not success
                EndFindPed(handle)
            end
            if closestPed then
                if not showing then
                    exports.ox_lib:showTextUI('[G] Hold to Skin Animal', { position = 'top-center', icon = 'fa-solid fa-drumstick-bite' })
                    showing = true
                end
                if not holdStart then
                    holdStart = GetGameTimer()
                elseif GetGameTimer() - holdStart > 1000 then -- 1 second hold
                    local pedCoords = GetEntityCoords(closestPed)
                    exports.ox_lib:showTextUI('Skinning Animal', { position = 'top-center', icon = 'fa-solid fa-drumstick-bite' })
                    playSkinningAnim(playerPed, pedCoords)
                    giveSkinReward(closestPed)
                    Wait(1000)
                    holdStart = nil
                end
            else
                if showing then
                    exports.ox_lib:hideTextUI()
                    showing = false
                end
                holdStart = nil
            end
        else
            if showing then
                exports.ox_lib:hideTextUI()
                showing = false
            end
            holdStart = nil
        end
    end
end)
