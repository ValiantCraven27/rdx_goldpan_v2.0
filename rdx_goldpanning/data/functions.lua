GPN = {}

function GPN:LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function GPN:CanPan()
    if not IsPedSwimmingUnderWater(PlayerPedId()) and IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and IsPedOnFoot(PlayerPedId()) then
     boolean = true
    else        
     boolean = false 
    end 
    return (boolean)
  end

function GPN:CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

function GPN:AttachPan()
    --GPN:DeletePan(kit_goldpan)
    if not DoesEntityExist(kit_goldpan) then
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local modelHash = GetHashKey("P_CS_MININGPAN01X")  
    GPN:LoadModel(modelHash)    
    kit_goldpan = CreateObject(modelHash, coords.x+0.30, coords.y+0.10,coords.z, true, false, false)
    SetEntityVisible(kit_goldpan, true)
    SetEntityAlpha(kit_goldpan, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, kit_goldpan, true)   
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    AttachEntityToEntity(kit_goldpan,PlayerPedId(), boneIndex, 0.2, 0.0, -0.20, -100.0, -50.0, 0.0, false, false, false, true, 2, true)
    SetModelAsNoLongerNeeded(modelHash)
    end
end

function GPN:DeletePan(entity)
    DeleteObject(entity)
    DeleteEntity(entity)
    Citizen.Wait(100)                
    ClearPedTasks(PlayerPedId()) 
end

function GPN:GoldShake()    
    --TriggerEvent('rdx:playsound','drums',0.25)
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false) 
      
end

function GPN:DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

--[[function GPN:StopMusicEvent()
   Citizen.InvokeNative(0x706D57B0F50DA710, "MC_MUSIC_STOP")  -- TRIGGER_MUSIC_EVENT
end]]

--[[function GPN:StartMusicEvent()
   Citizen.InvokeNative(0x1E5185B72EF5158A, "WNT4_START_2")  -- PREPARE_MUSIC_EVENT
   Citizen.InvokeNative(0x706D57B0F50DA710, "WNT4_START_2")  -- TRIGGER_MUSIC_EVENT
end]]

--[[function GPN:RandomMusicEvent()
    local MusicEvent = math.random(1,#Info.MusicEvent)
    Citizen.InvokeNative(0x1E5185B72EF5158A, MusicEvent)  -- PREPARE_MUSIC_EVENT
    Citizen.InvokeNative(0x706D57B0F50DA710, MusicEvent)  -- TRIGGER_MUSIC_EVENT
end]]


