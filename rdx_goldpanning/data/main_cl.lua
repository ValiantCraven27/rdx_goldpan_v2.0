RDX, Action = nil,{Panning = false, Time = 18000, Probability = Config.Probability, Fail = 0}
Citizen.CreateThread(function() while RDX == nil do TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end) Citizen.Wait(0) end end)
local NoWeapons = false

RegisterCommand('attachpan', function()
    if not Action.Panning then
        GPN:AttachPan()
        NoWeapons = true
    end      
end)

RegisterCommand('deletepan', function()
    if not Action.Panning then
        GPN:DeletePan(kit_goldpan)
        NoWeapons = false
    end              
end)  

RegisterNetEvent('rdx:playerLoaded')
AddEventHandler('rdx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('rdx:alert')	
AddEventHandler('rdx:alert', function(txt,model)
    SetTextScale(0.45, 0.45)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)   
end)

RegisterNetEvent('rdx:playsound')
AddEventHandler('rdx:playsound', function(sound,volume)
    TriggerServerEvent('InteractSound_SV:PlayOnSource',sound, volume) 
end)

RegisterNetEvent('goldpanning:start')
AddEventHandler('goldpanning:start', function()
    if not Action.Panning then 
        Action.Panning = true
        
        local ped                     = PlayerPedId()
        local coords                  = GetEntityCoords(ped)
        local WindSpeed               = GetWindSpeed()
        local Water                   = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x, coords.y, coords.z)       
        local IsPedInWater            = IsEntityInWater(ped)       

        Action.Probability      = math.random(0,100) 
        Action.Fail             = math.random(10,20) + WindSpeed
 
        

        if GPN:CanPan(boolean) then 
        for k,v in pairs(Config.WaterTypes) do            
            if Water == Config.WaterTypes[k]["waterhash"] then  

                GPN:AttachPan()
                GPN:CrouchAnim()                
                Citizen.Wait(6000)
                ClearPedTasks(ped)
                GPN:GoldShake()
                if math.random(1,100) > 50 then
                    Action.Time = 18000
                    TriggerEvent('rdx:playsound','drums',0.30)
                else
                    Action.Time = 16500
                    TriggerEvent('rdx:playsound','pumpitup',0.30)
        
                end                            
                exports.rprogress:Start(Config.rprogress['gold_panning'], Action.Time)
                if Action.Probability > Action.Fail then                                   
                    TriggerServerEvent("goldpanning:finish",source)                                            
                else
                   TriggerEvent('rdx:alert', Config.Nothing['nothing'], 1)                    
                end
                Citizen.Wait(2000)                                                                    
                GPN:DeletePan(kit_goldpan)           
                Action.Panning = false
                Action.Probability = 0  
                Action.Fail = 0              
                break
              end
            end 
        end
    end
end)

if Config.HUD then
 Citizen.CreateThread(function()
    while true do
	    Wait(1)
        local player   = PlayerPedId()
        local heading  = GetEntityHeading(player)
        local ped      = PlayerPedId()
        local coords   = GetEntityCoords(ped)
        local WaterHash  = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x, coords.y, coords.z)   
        local showText = Config.WaterNames[WaterHash]       
         
        if showText ~= nil then

            GPN:DrawTxt(""..showText.."",0.09, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true)
        else             
            
            showText = nil
        end       
    end
 end)
end

Citizen.CreateThread(function()
    while true do
	    Wait(1)
        local player   = PlayerPedId()
        local heading  = GetEntityHeading(player)
        local ped      = PlayerPedId()
        local coords   = GetEntityCoords(ped)
        local WaterHash  = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x, coords.y, coords.z)   
        local showText = Config.WaterNames[WaterHash]       
         
        if NoWeapons then
            DisablePlayerFiring(player,true)  
        end       
    end
 end)

