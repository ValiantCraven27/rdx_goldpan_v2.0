RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end) 


RDX.RegisterUsableItem('kit_goldpan', function(source)
  
    local xPlayer = RDX.GetPlayerFromId(source)
    TriggerClientEvent('goldpanning:start', source)
    TriggerClientEvent('rdx:alert' ,source, ""..Config.UseMsg['used_goldpan'].."", 3)
 
end)

RegisterCommand('goldpan', function(source)
  local xPlayer = RDX.GetPlayerFromId(source)        
  local getItem = xPlayer.getInventoryItem('kit_goldpan')	   

  if getItem ~= 0 then		
     TriggerClientEvent('goldpanning:start', source)
  end	  
end)

RegisterServerEvent("goldpanning:finish")
AddEventHandler("goldpanning:finish", function() 
 local xPlayer = RDX.GetPlayerFromId(source)
 local roll  = math.random(1,30) 
 local callItem = Config.ItemSet[roll]
 local callText = Config.FoundMsg[roll]		
 
 TriggerClientEvent('rdx:alert', source, 'Before Item', 3)

  if callItem ~= nil then
    TriggerClientEvent('rdx:alert', source, ''..callText..'', 3)
    xPlayer.addInventoryItem(callItem, 1)
  else
    TriggerClientEvent('rdx:alert' , source, ''..callText..'', 3)	
  end      

end)


