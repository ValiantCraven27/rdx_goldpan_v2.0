RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end) 

RDX.RegisterUsableItem('item_goldpan', function(source)
    local xPlayer = RDX.GetPlayerFromId(source)
    TriggerClientEvent('rdx:startpanning', source)
end)

RegisterServerEvent('rdx:finishpanning')
AddEventHandler('rdx:finishpanning', function(roll)
 local _src = source
 local xPlayer = RDX.GetPlayerFromId(_src)
 local callItem = Config.ItemSet[roll]
 local callText = Config.MsgSet[roll]		
 
 TriggerClientEvent('rdx:alert', _src, 'Before Item', 3)

  if callItem ~= nil then
    TriggerClientEvent('rdx:alert', _src, '..callText..', 3)
    xPlayer.addInventoryItem(callItem, 1)
  else
    TriggerClientEvent('rdx:alert' ,_src, '..callText..', 3)	
  end      
end)
