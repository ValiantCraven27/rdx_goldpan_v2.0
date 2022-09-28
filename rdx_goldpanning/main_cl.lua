RDX              = nil
local PlayerData = {}

local Panning = false

Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('rdx:playerLoaded')
AddEventHandler('rdx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('rdx:alert')	
AddEventHandler('rdx:alert', function(txt)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

RegisterNetEvent('rdx:startpanning')
AddEventHandler('rdx:startpanning', function()
    if not Panning then 
        Panning = true
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local roll = math.random(0,10)
        local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x, coords.y, coords.z)
        for k,v in pairs(Config.WaterTypes) do
            if Water == Config.WaterTypes[k]["waterhash"]  then
                CrouchAnimAndAttach()
                Citizen.Wait(6000)
                ClearPedTasks(ped)
                GoldShake()
                w = math.random(10000,15000)
                Citizen.Wait(w)
                ClearPedTasks(ped)
                TriggerEvent('rdx:alert', 'Before server side')
                TriggerServerEvent('rdx:finishpanning', roll)
                Citizen.Wait(500)
                DeleteObject(entity)
                DeleteEntity(entity)              
                Panning = false
                break
            end
        end
    end
end)
--[[N_0x371d179701d9c082(entity)]] -- Called if entity is in water and submerged level is larger than 1f.
--[[N_0xdc88d06719070c39(ped)]] -- near water
--GetWaterMapZoneAtCoords(x --[[ number ]], y --[[ number ]], z --[[ number ]])

function CrouchAnimAndAttach()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    local modelHash = GetHashKey("P_CS_MININGPAN01X")
    LoadModel(modelHash)
    entity = CreateObject(modelHash, coords.x+0.3, coords.y,coords.z, true, false, false)
    SetEntityVisible(entity, true)
    SetEntityAlpha(entity, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
    SetModelAsNoLongerNeeded(modelHash)
    AttachEntityToEntity(entity,ped, boneIndex, 0.2, 0.0, -0.2, -100.0, -50.0, 0.0, false, false, false, true, 2, true)

    TaskPlayAnim(ped, dict, "inspectfloor_player", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function GoldShake()
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

