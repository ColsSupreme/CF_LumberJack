CF = nil

TriggerEvent('cf:getSharedObject', function(obj) CF = obj end)

RegisterNetEvent("esx_lumberjack:givelogs")
AddEventHandler("esx_lumberjack:givelogs", function(item, count)
    local _source = source
    local xPlayer  = exports.essentialmode:getPlayerFromId(_source)
        if xPlayer ~= nil then
                CF.AddItem(_source,'log', 1)
                CF.ShowNotification(_source, 'You received ~b~Logs.')   
        end
    end)

    RegisterNetEvent("esx_lumberjack:ToomuchLogs")
AddEventHandler("esx_lumberjack:ToomuchLogs", function(item, count)
    _source = source
    CF.ShowNotification(_source, 'You do not have enough space for ~b~Logs.')
end)

    RegisterNetEvent("esx_lumberjack:NoLogs")
AddEventHandler("esx_lumberjack:NoLogs", function(item, count)
    _source = source
    CF.ShowNotification(_source, 'You do not have enough  ~b~Logs.')
end)

    RegisterNetEvent("esx_lumberjack:Noplanks")
AddEventHandler("esx_lumberjack:Noplanks", function(item, count)
    _source = source
    CF.ShowNotification(_source, 'You do not have enough  ~b~Planks.')
end)

RegisterNetEvent("esx_lumberjack:processlogs")
AddEventHandler("esx_lumberjack:processlogs", function(item, heading)
    local _source = source
    local xPlayer  = exports.essentialmode:getPlayerFromId(_source)
        if xPlayer ~= nil then
            if item.count > 0 then
                
                CF.RemoveItem(_source,'log',1)
                CF.AddItem(_source,'planks', 2)
                CF.AddItem(_source,'sawdust',4)
                CF.ShowNotification(_source, 'You Processed ~b~Logs.') 
                Citizen.Wait(1000)
                CF.ShowNotification(_source, 'You Recived ~b~Planks.')   
                Citizen.Wait(1000)
                CF.ShowNotification(_source, 'You Recived ~b~Sawdust.')   
            else     
                CF.ShowNotification(_source, 'You do not have enough ~b~Logs.')
            end
        end
    end)


RegisterNetEvent("esx_lumberjack:processplanks")
AddEventHandler("esx_lumberjack:processplanks", function(item, heading)
    local _source = source
    local xPlayer  = exports.essentialmode:getPlayerFromId(_source)
        if xPlayer ~= nil then
            if item.count > 0 then
                
                CF.RemoveItem(_source,'planks',1)
                CF.AddItem(_source,'paper',4)
                CF.ShowNotification(_source, 'You Processed ~b~Planks.') 
                Citizen.Wait(1000)
                CF.ShowNotification(_source, 'You Recived ~b~Paper.') 
            else     
                CF.ShowNotification(_source, 'You do not have enough ~b~Planks.')
            end
        end
    end)



    
RegisterNetEvent("esx_lumberjack:sellitem")
AddEventHandler("esx_lumberjack:sellitem", function(item,all)
    local _source = source
    price = 1
    amounts = 1
    if item.label == "Logs" then
        price = Config.LogPrice
        tosell = "log"
    elseif item.label == "Planks" then
        price = Config.PlankPrice
        tosell = "planks"
    elseif item.label == "Sawdust" then
        price = Config.SawdustPrice 
        tosell = "sawdust"
    else
        tosell = "paper"
        price = Config.PaperPrice
    end
    local user = exports.essentialmode:getPlayerFromId(_source)
    if all ~= 1 then
        amounts = item.count
    else
        amounts = 1
    end
    CF.RemoveItem(_source,tosell, amounts)
    user.addMoney(price*amounts)
    CF.ShowNotification(_source, 'You have sold '.. amounts ..' ~b~'.. item.label ..' ~w~for ~g~$' ..  price*amounts) 
end)


RegisterNetEvent("esx_lumberjack:noitem")
AddEventHandler("esx_lumberjack:noitem", function(item)
    local _source = source
    local lable = item.label
    CF.ShowNotification(_source, 'You do not have enough ~b~'.. lable)
end)