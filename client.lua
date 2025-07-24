
-- Global variables for tracking skinning state
isListening = false

lastAnimalSkinned = nil
skinningStartTime = 0

-- Simpler DataView implementation for handling native memory buffers
DataView = {}
DataView.__index = DataView

function DataView.ArrayBuffer(length)
    local buffer = string.rep("\0", length)
    return setmetatable({
        buffer = buffer,
        length = length
    }, DataView)
end

function DataView:GetInt32(offset)
    local b1, b2, b3, b4 = string.byte(self.buffer, offset + 1, offset + 4)
    return b1 | (b2 << 8) | (b3 << 16) | (b4 << 24)
end

function DataView:SetInt32(offset, value)
    local bytes = {
        value & 0xFF,
        (value >> 8) & 0xFF,
        (value >> 16) & 0xFF,
        (value >> 24) & 0xFF
    }
    
    for i = 1, 4 do
        self.buffer = string.sub(self.buffer, 1, offset + i - 1) .. 
                      string.char(bytes[i]) .. 
                      string.sub(self.buffer, offset + i + 1)
    end
end

function DataView:Buffer()
    return self.buffer
end



-- Function to give rewards after skinning is complete
local function giveSkinReward(entity)
    if not entity or not DoesEntityExist(entity) then
        print("[HUNTING] Cannot give reward - entity does not exist: " .. tostring(entity))
        exports.ox_lib:notify({
            title = 'Hunting Error',
            description = 'Cannot find animal to reward',
            type = 'error',
            position = 'top-right',
            duration = 4000
        })
        return
    end
    
    local model = GetEntityModel(entity)
    
    -- Get animal quality (0=poor, 1=good, 2=perfect, 3=legendary)
    local quality = Citizen.InvokeNative(0x7BCC6087D130312A, entity) or 1
    
    local reward = Config.AnimalList[model]
    
    if reward then
        
        -- Determine quality text for notification
        local qualityText = "poor"
        if quality == 0 then
            qualityText = "poor"
        elseif quality == 1 then
            qualityText = "good"
        elseif quality == 2 then
            qualityText = "perfect"
        elseif quality == 3 then
            qualityText = "legendary"
        end
        
        
        for i, item in ipairs(reward.givenItem) do
            local amount = reward.givenAmount[i] or 1
            
            -- Check if this item has quality-based amounts
            if type(amount) == "table" and #amount >= 3 then
                -- Use the appropriate amount based on quality
                amount = amount[quality] or amount[1]
            end
            
            TriggerServerEvent('rsg_hunting:giveHuntingReward', item, amount, entity, quality)
            -- Add a small delay between items to prevent race conditions
            Citizen.Wait(100)
        end
    else
        print("[HUNTING] No reward configuration found for animal model: " .. model)
        exports.ox_lib:notify({
            title = 'Hunting Error',
            description = 'This animal is not registered for rewards! (Model: '..model..')',
            type = 'error',
            position = 'top-right',
            duration = 4000
        })
    end
end


-- This function is no longer needed as we're directly processing the skinned animal
-- when EVENT_LOOT_COMPLETE is detected


-- Listen for reward result and delete the skinned entity if successful
RegisterNetEvent('rsg_hunting:rewardResult')
AddEventHandler('rsg_hunting:rewardResult', function(success, entityId)
    -- Make sure we're not in listening mode anymore
    isListening = false
    

    
    if success and entityId and DoesEntityExist(entityId) then
        -- Request control of the entity if needed
        if not NetworkHasControlOfEntity(entityId) then
            NetworkRequestControlOfEntity(entityId)
            local timeout = 0
            while not NetworkHasControlOfEntity(entityId) and timeout < 50 do
                Citizen.Wait(10)
                NetworkRequestControlOfEntity(entityId)
                timeout = timeout + 1
            end
        end
        
        -- Delete the entity if we have control
        if NetworkHasControlOfEntity(entityId) then
            DeleteEntity(entityId)
        end
        
        -- Also remove the pelt from the player if they're holding one
        local playerPed = PlayerPedId()
        local peltEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, playerPed) -- GET_FIRST_ENTITY_PED_IS_CARRYING
        
        if peltEntity and DoesEntityExist(peltEntity) then
            if not NetworkHasControlOfEntity(peltEntity) then
                NetworkRequestControlOfEntity(peltEntity)
                local timeout = 0
                while not NetworkHasControlOfEntity(peltEntity) and timeout < 50 do
                    Citizen.Wait(10)
                    NetworkRequestControlOfEntity(peltEntity)
                    timeout = timeout + 1
                end
            end
            
            if NetworkHasControlOfEntity(peltEntity) then
                DeleteEntity(peltEntity)
            end
        end
        
        -- Remove any nearby pelts as well
        local playerCoords = GetEntityCoords(playerPed)
        local objects = GetGamePool('CObject')
        for _, obj in ipairs(objects) do
            if DoesEntityExist(obj) then
                local objCoords = GetEntityCoords(obj)
                local distance = #(playerCoords - objCoords)
                
                if distance < 5.0 then
                    -- Check if this is a pelt object
                    local modelName = Citizen.InvokeNative(0x47B870F5, obj)
                    if modelName and string.find(string.lower(tostring(modelName)), "pelt") then
                        DeleteEntity(obj)
                    end
                end
            end
        end
    end
end)


-- Proximity keybind: Press [E] to start listening for skinning events
CreateThread(function()
    local wasPressed = false
    
    while true do
        Wait(500)
        
        -- Detect when E is pressed (not held)
        local isPressed = IsControlPressed(0, 0xCEFD9220) -- E key (correct code: 0xCEFD9220)
        
        -- Detect the moment E is pressed (transition from not pressed to pressed)
        if isPressed and not wasPressed and not isListening then
            -- First check if there's a dead animal nearby before starting to listen
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local closestAnimal = nil
            local closestDistance = Config.SkinDistance or 10.0
            local animalFound = false
            
            -- Find the closest dead animal
            local entities = GetGamePool('CPed')
            for _, entity in ipairs(entities) do
                if entity ~= playerPed and DoesEntityExist(entity) and IsEntityDead(entity) then
                    local model = GetEntityModel(entity)
                    if Config.AnimalList[model] then
                        local entityCoords = GetEntityCoords(entity)
                        local distance = #(playerCoords - entityCoords)
                        
                        if distance < closestDistance then
                            closestAnimal = entity
                            closestDistance = distance
                            animalFound = true
                        end
                    end
                end
            end
            
            -- Only proceed if we found a dead animal nearby
            if animalFound then
                isListening = true
                skinningStartTime = GetGameTimer()
                lastAnimalSkinned = closestAnimal
                

            else
                -- No dead animal found nearby
                return
            end
            local closestDistance = Config.SkinDistance or 10.0
            local playerCoords = GetEntityCoords(playerPed)
            
            -- Find the closest dead animal
            local entities = GetGamePool('CPed')
            for _, entity in ipairs(entities) do
                if entity ~= playerPed and DoesEntityExist(entity) and IsEntityDead(entity) then
                    local model = GetEntityModel(entity)
                    if Config.AnimalList[model] then
                        local entityCoords = GetEntityCoords(entity)
                        local distance = #(playerCoords - entityCoords)
                        
                        if distance < closestDistance then
                            closestAnimal = entity
                            closestDistance = distance
                            lastAnimalSkinned = entity
                        end
                    end
                end
            end
            
            -- Start a thread to listen for EVENT_LOOT_COMPLETE
            local listenThread = CreateThread(function()
                local startTime = GetGameTimer()
                local timeoutDuration = 30000 -- 30 second timeout (reduced from 60s)
                local eventDetected = false
                local threadId = GetIdOfThisThread() -- Store the thread ID for termination
                local lastAnimalCheck = 0
                local animalCheckInterval = 2000 -- Check if animal is still nearby every 2 seconds
                
                -- Listen for events until timeout
                while isListening and GetGameTimer() - startTime < timeoutDuration do
                    Wait(0) -- Check every frame for events
                    
                    -- Check if thread should terminate early
                    if not isListening then
                        return
                    end
                    
                    -- Periodically check if the animal is still nearby
                    local currentTime = GetGameTimer()
                    if currentTime - lastAnimalCheck > animalCheckInterval then
                        lastAnimalCheck = currentTime
                        
                        -- Check if lastAnimalSkinned still exists and is nearby
                        if not lastAnimalSkinned or not DoesEntityExist(lastAnimalSkinned) then
                             isListening = false
                           
                               return
                        end
                        
                        -- Check if animal is still in range
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        local animalCoords = GetEntityCoords(lastAnimalSkinned)
                        local distance = #(playerCoords - animalCoords)
                        
                        if distance > (Config.SkinDistance or 10.0) then
                            isListening = false
                           
                            return
                        end
                    end
                    
                    -- Check for EVENT_LOOT_COMPLETE event
                    local size = GetNumberOfEvents(0)
                    if size > 0 then
                        for index = 0, size - 1 do
                            local event = GetEventAtIndex(0, index)
                            if event == `EVENT_LOOT_COMPLETE` then
                                -- Create a buffer for event data
                                local buffer = DataView.ArrayBuffer(24)
                                
                                -- Initialize the buffer with zeros
                                buffer:SetInt32(0, 0)  -- Player
                                buffer:SetInt32(8, 0)  -- Entity
                                buffer:SetInt32(16, 0) -- Status
                                
                                -- Get event data
                                local dataExists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, 0, index, buffer:Buffer(), 3)
                                
                                if dataExists then
                                    -- Get the player ID from the event data
                                    local playerFromEvent = buffer:GetInt32(0)
                                    local pedid = buffer:GetInt32(8)
                                    local status = buffer:GetInt32(16)
                                    
                                   
                                    -- Check if this event is for our player and status is 1 (success)
                                    if PlayerPedId() == playerFromEvent and status == 1 then
                                        eventDetected = true
                                        -- Process the skinned animal
                                        if DoesEntityExist(pedid) then
                                            -- Give rewards for the skinned animal
                                            giveSkinReward(pedid)
                                            
                                            -- Remove the skinned animal and any dropped pelts
                                            CreateThread(function()
                                                Wait(500) -- Small delay to ensure skinning is complete
                                                if DoesEntityExist(pedid) then
                                                    DeleteEntity(pedid)
                                                end
                                                
                                                -- Remove any pelts in the area
                                                local playerCoords = GetEntityCoords(PlayerPedId())
                                                local objects = GetGamePool('CObject')
                                                for _, obj in ipairs(objects) do
                                                    if DoesEntityExist(obj) then
                                                        local objCoords = GetEntityCoords(obj)
                                                        local distance = #(playerCoords - objCoords)
                                                        
                                                        if distance < 5.0 then
                                                            -- Check if this is a pelt object
                                                            local modelName = Citizen.InvokeNative(0x47B870F5, obj)
                                                            if modelName and string.find(string.lower(tostring(modelName)), "pelt") then
                                                                DeleteEntity(obj)
                                                            end
                                                        end
                                                    end
                                                end
                                            end)
                                            
                                        else
                                            print("[HUNTING] Entity " .. pedid .. " does not exist")
                                        end
                                        
                                        -- Stop listening and terminate thread
                                        isListening = false
                                       
          
                                        return -- Exit the thread immediately
                                    end
                                else
                                    print("[HUNTING] Failed to get event data")
                                end
                            end
                        end
                    end
                    
                    -- Check if player is carrying a pelt (alternative detection method)
                    local peltEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                    if peltEntity and DoesEntityExist(peltEntity) and not eventDetected and GetGameTimer() - skinningStartTime > 5000 then
                        -- Player is carrying a pelt and we didn't detect the event, but enough time has passed
                        eventDetected = true
                        
                        -- Process the last animal we were near
                        if lastAnimalSkinned and DoesEntityExist(lastAnimalSkinned) then
                            giveSkinReward(lastAnimalSkinned)
                            
                            -- Remove the skinned animal
                            DeleteEntity(lastAnimalSkinned)
                            
                        else
                            exports.ox_lib:notify({
                                title = 'Hunting',
                                description = 'Detected skinning but could not find animal',
                                type = 'warning',
                                position = 'top-right',
                                duration = 4000
                            })
                        end
                        
                        -- Stop listening and terminate thread
                        isListening = false
                       
                        
                        return -- Exit the thread immediately
                    end
                end
                
                -- If we reach here, the timeout has occurred
                if isListening then
                    
                    -- Failsafe: If we have a lastAnimalSkinned and it's been more than 10 seconds
                    if lastAnimalSkinned and DoesEntityExist(lastAnimalSkinned) and GetGameTimer() - skinningStartTime > 10000 then
                        giveSkinReward(lastAnimalSkinned)
                        DeleteEntity(lastAnimalSkinned)
                    

                    end
                    
                    -- Ensure we clean up properly
                    isListening = false
                   
                    
                end
            end)
        end
        
        -- Update wasPressed for the next frame
        wasPressed = isPressed
        
        -- Hide UI when we're done listening (redundant check to ensure UI is always hidden properly)
    end
end)

-- These detection threads are no longer needed as we're directly processing
-- the skinned animal when EVENT_LOOT_COMPLETE is detected in the main thread
