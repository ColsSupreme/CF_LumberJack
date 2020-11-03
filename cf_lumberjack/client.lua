CF = nil
local chopactive = false
local impacts = 0
local timer = 0
local ProcessingActive = false
local MakingPaper = false
local blips = true
local blipActive = false
local firstspawn = false

local locations = {
    { ['x'] = -490.87,  ['y'] = 5651.19,  ['z'] = 58.6},
    { ['x'] = -487.72,  ['y'] = 5647.36,  ['z'] = 59.68},
    { ['x'] = -486.96,  ['y'] = 5620.81,  ['z'] = 64.07},
    { ['x'] = -482.33,  ['y'] = 5614.63,  ['z'] = 65.71},
    { ['x'] = -506.22,  ['y'] = 5610.24,  ['z'] = 64.42},
    { ['x'] = -463.97,  ['y'] = 5613.8,  ['z'] = 66.16},
    { ['x'] = -476.35,  ['y'] = 5586.67,  ['z'] = 69.94},
    { ['x'] = -477.7,  ['y'] = 5583.34,  ['z'] = 70.37},
}
local locationsp = {
    { ['x'] = -533.64,  ['y'] = 5287.93,  ['z'] = 74.17 },
    { ['x'] = -533.07,  ['y'] = 5291.75,  ['z'] = 74.17 },
    { ['x'] = -528.99,  ['y'] = 5295.87,  ['z'] = 74.17 },
    { ['x'] = -524.15,  ['y'] = 5293.88,  ['z'] = 74.17 },
    { ['x'] = -525.2,  ['y'] = 5288.97,  ['z'] = 74.17 },
    { ['x'] = -526.2,  ['y'] = 5285.35,  ['z'] = 74.17 },
    { ['x'] = -528.3,  ['y'] = 5281.35,  ['z'] = 74.17 },
    { ['x'] = -529.67,  ['y'] = 5277.52,  ['z'] = 74.17 },
}
local locationsph = {{['h']= 70},
{['h']= 6.95},
{['h']= 344.09},
{['h']= 344.09},
{['h']= 252.74},
{['h']= 252.74},
{['h']= 252.74},
{['h']= 252.74}}

local locationsr = {
    { ['x'] = 1213.44,  ['y'] = -1238.42,  ['z'] = 36.33},
    { ['x'] = 1213.65,  ['y'] = -1244.65,  ['z'] = 36.33},
    { ['x'] = 1213.54,  ['y'] = -1247.86,  ['z'] = 36.33},
    { ['x'] = 1213.63,  ['y'] = -1251.22,  ['z'] = 36.33},
    { ['x'] = 1213.57,  ['y'] = -1256.34,  ['z'] = 35.23},
    { ['x'] = 1213.54,  ['y'] = -1262.71,  ['z'] = 35.23},
    { ['x'] = 1220.24,  ['y'] = -1270.31,  ['z'] = 35.23},
    { ['x'] = 1194.20,  ['y'] = -1248.18,  ['z'] = 35.36},
}



Citizen.CreateThread(function()
    TriggerEvent("esx_lumberjack:createblips")
end)  


local function ShowHelpMessage(msg)
  AddTextEntry('cfHelpNotification', msg)
  BeginTextCommandDisplayHelp('cfHelpNotification')
  EndTextCommandDisplayHelp(0, false, true, -1)
end 


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and chopactive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        Draw3DText( locations[i].x, locations[i].y,locations[i].z+0.5 -1.400, ('Press ~r~E ~w~to start cutting down the tree'), 4, 0.1, 0.1)
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                chopactive = true
                            end
                        end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locationsp, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[i].x, locationsp[i].y, locationsp[i].z, true) < 25 and ProcessingActive == false then
                DrawMarker(20, locationsp[i].x, locationsp[i].y, locationsp[i].z, 0, 0, 0, 0, 0, locationsph[i].h, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[i].x, locationsp[i].y, locationsp[i].z, true) < 1 then
                        Draw3DText( locationsp[i].x, locationsp[i].y,locationsp[i].z+0.5 -1.400, ('Press ~r~E ~w~to start processing logs'), 4, 0.1, 0.1)
                            if IsControlJustReleased(1, 51) then
                                ProcessingActive = true
                                local heading = locationsph[i].h
                                local item = CF.GetInventory()['log']
                                if item.count >0 then
                                    cutting(heading)
                                    TriggerServerEvent('esx_lumberjack:processlogs', item)
                                else
                                    TriggerServerEvent('esx_lumberjack:NoLogs')
                                    ProcessingActive = false
                                end
                            end
                        end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locationsr, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[i].x, locationsr[i].y, locationsr[i].z, true) < 25 and MakingPaper == false then
                DrawMarker(20, locationsr[i].x, locationsr[i].y, locationsr[i].z, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[i].x, locationsr[i].y, locationsr[i].z, true) < 1 then
                        Draw3DText( locationsr[i].x, locationsr[i].y,locationsr[i].z+0.5 -1.400, ('Press ~r~E ~w~to start making paper '), 4, 0.1, 0.1)
                            if IsControlJustReleased(1, 51) then
                                MakingPaper = true
                                
                                local item = CF.GetInventory()['planks']
                                if item.count >0 then
                                    Paper()
                                    TriggerServerEvent('esx_lumberjack:processplanks', item)
                                    
                                else
                                    TriggerServerEvent('esx_lumberjack:Noplanks')
                                    MakingPaper = false
                                end
                            end
                        end
            end
        end
    end
end)

function Animation()
    Citizen.CreateThread(function()
        local item = CF.GetInventory()['log']
            if item.count < 10 then
                while impacts < 5 do
                    Citizen.Wait(1)
                local ped = PlayerPedId()	
                        RequestAnimDict("melee@large_wpn@streamed_core")
                        Citizen.Wait(100)
                        TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                        SetEntityHeading(ped, 270.0)
                        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'chop', 0.5)
                        
                        if impacts == 0 then
                            pickaxe = CreateObject(GetHashKey("prop_tool_fireaxe"), 0, 0, 0, true, true, true) 
                            AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                        end  
                        Citizen.Wait(2500)
                        ClearPedTasks(ped)
                        impacts = impacts+1
                        if impacts == 5 then
                            DetachEntity(pickaxe, 1, true)
                            DeleteEntity(pickaxe)
                            DeleteObject(pickaxe)
                            chopactive = false
                            impacts = 0
                            
                            TriggerServerEvent("esx_lumberjack:givelogs")
                            break
                        end           
                end
            else
            TriggerServerEvent("esx_lumberjack:ToomuchLogs")
            chopactive = false
            end
    end)
end

function cutting(heading)
    
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@load_box")
    ProcessingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, heading)
    TaskPlayAnim((ped), 'anim@heists@load_box', 'load_box_3', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_lumberjack:timer")
    Citizen.Wait(16200)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    ProcessingActive = false
end

function Paper()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_lumberjack:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    MakingPaper = false
    
end

Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_y_construct_01")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 64.0, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

RegisterNetEvent('esx_lumberjack:createblips')
AddEventHandler('esx_lumberjack:createblips', function()
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
                if blips == true and blipActive == false then
                    blip1 = AddBlipForCoord(-478.97, 5626.67, 64.15)
                    blip2 = AddBlipForCoord(Config.ProcessingX, Config.ProcessingY, Config.ProcessingZ)
                    blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
                    blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
                    SetBlipSprite(blip1, 365)
                    SetBlipColour(blip1, 1)
                    SetBlipAsShortRange(blip1, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Harvest Logs")
                    EndTextCommandSetBlipName(blip1)   
                    SetBlipSprite(blip2, 365)
                    SetBlipColour(blip2, 1)
                    SetBlipAsShortRange(blip2, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Processing Logs")
                    EndTextCommandSetBlipName(blip2)   
                    SetBlipSprite(blip3, 365)
                    SetBlipColour(blip3, 1)
                    SetBlipAsShortRange(blip3, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Make Paper")
                    EndTextCommandSetBlipName(blip3)
                    SetBlipSprite(blip4, 272)
                    SetBlipColour(blip4, 1)
                    SetBlipAsShortRange(blip4, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Selling items")
                    EndTextCommandSetBlipName(blip4)    
                    blipActive = true
                elseif blips == false and blipActive == false then
                    RemoveBlip(blip1)
                    RemoveBlip(blip2)
                    RemoveBlip(blip3)
                end
        end
    end)
end)






Citizen.CreateThread(function()
	while CF == nil do 
        Citizen.Wait(0)
        TriggerEvent('cf:getSharedObject', function(obj) CF = obj end)
    end
    
end)



RegisterNetEvent('esx_lumberjack:timer')
AddEventHandler('esx_lumberjack:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[1].x, locationsp[1].y, locationsp[1].z, true) < 1.25 then
                Draw3DText( locationsp[1].x, locationsp[1].y, locationsp[1].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[2].x, locationsp[2].y, locationsp[2].z, true) < 1.25 then
                Draw3DText( locationsp[2].x, locationsp[2].y, locationsp[2].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[3].x, locationsp[3].y, locationsp[3].z, true) < 1.25 then
                Draw3DText( locationsp[3].x, locationsp[3].y, locationsp[3].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[4].x, locationsp[4].y, locationsp[4].z, true) < 1.25 then
                Draw3DText( locationsp[4].x, locationsp[4].y, locationsp[4].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[5].x, locationsp[5].y, locationsp[5].z, true) < 1.25 then
                Draw3DText( locationsp[5].x, locationsp[5].y, locationsp[5].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[6].x, locationsp[6].y, locationsp[6].z, true) < 1.25 then
                Draw3DText( locationsp[6].x, locationsp[6].y, locationsp[6].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[7].x, locationsp[7].y, locationsp[7].z, true) < 1.25 then
                Draw3DText( locationsp[7].x, locationsp[7].y, locationsp[7].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsp[8].x, locationsp[8].y, locationsp[8].z, true) < 1.25 then
                Draw3DText( locationsp[8].x, locationsp[8].y, locationsp[8].z+0.5 -1.400, ('Processing logs in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[1].x, locationsr[1].y, locationsr[1].z, true) < 1.25 then
                Draw3DText( locationsr[1].x, locationsr[1].y, locationsr[1].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[2].x, locationsr[2].y, locationsr[2].z, true) < 1.25 then
                Draw3DText( locationsr[2].x, locationsr[2].y, locationsr[2].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[3].x, locationsr[3].y, locationsr[3].z, true) < 1.25 then
                Draw3DText( locationsr[3].x, locationsr[3].y, locationsr[3].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[4].x, locationsr[4].y, locationsr[4].z, true) < 1.25 then
                Draw3DText( locationsr[4].x, locationsr[4].y, locationsr[4].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[5].x, locationsr[5].y, locationsr[5].z, true) < 1.25 then
                Draw3DText( locationsr[5].x, locationsr[5].y, locationsr[5].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[6].x, locationsr[6].y, locationsr[6].z, true) < 1.25 then
                Draw3DText( locationsr[6].x, locationsr[6].y, locationsr[6].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[7].x, locationsr[7].y, locationsr[7].z, true) < 1.25 then
                Draw3DText( locationsr[7].x, locationsr[7].y, locationsr[7].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationsr[8].x, locationsr[8].y, locationsr[8].z, true) < 1.25 then
                Draw3DText( locationsr[8].x, locationsr[8].y, locationsr[8].z+0.5 -1.400, ('Making Paper in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 then
                Draw3DText( Config.SellX, Config.SellY,Config.SellZ+1 -1.400, ('Press ~r~E ~w~to sell your items'), 4, 0.1, 0.1)
                    if IsControlJustReleased(1, 51) then
                        Jeweler()                      
            end
        end
    end
 end)
    

function Jeweler()
    local elements = {
        {label = '<span style="color: #765c48 "><b>Sell 1 Log </b></span>',   value = 'log'},
        {label = '<span style="color: #765c48 "><b>Sell All Logs </b></span>',   value = 'logs'},
        {label = '<span style="color: #a88454"><b>Sell 1 Plank </b></span>',      value = 'Plank'},
        {label = '<span style="color: #a88454"><b>Sell All Planks </b></span>',      value = 'APlank'},
        {label = '<span style="color: #a19d94"><b>Sell 1 Saw Dust</b></span>',       value = 'SDust'},
        {label = '<span style="color: #a19d94"><b>Sell All Saw Dust</b></span>',       value = 'ASDust'},
        {label = '<span style="color: #bea265"><b>Sell 1 Paper</b></span>',       value = 'Paper'},
        {label = '<span style="color: #bea265"><b>Sell All Paper</b></span>',       value = 'APaper'},
        {label = '<span style="color: red"><b>Exit</b></span>',       value = 'exit'}
    }

    CF.UI.Menu.CloseAll()

    CF.UI.Menu.Open('default', GetCurrentResourceName(), 'Lumber-Actions', {
        title    = 'Lumber - sale',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        local item1 = CF.GetInventory()['log']
        local item2 = CF.GetInventory()['planks']
        local item3 = CF.GetInventory()['sawdust']
        local item4 = CF.GetInventory()['paper']
        if data.current.value == 'logs' then
            menu.close()
            print('test')
            local item = CF.GetInventory()['log']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item1,0)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item1)
            end
        elseif data.current.value == 'log' then
            menu.close()
            local item = CF.GetInventory()['log']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item1,1)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item1)
            end
        elseif data.current.value == 'Plank' then
            menu.close()
            local item = CF.GetInventory()['planks']     
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item2,1)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item2)
            end
        elseif data.current.value == 'APlank' then
            menu.close()
            local item = CF.GetInventory()['planks']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item2,0)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item2)
            end
        elseif data.current.value == 'SDust' then
            menu.close()
            local item = CF.GetInventory()['sawdust']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item3,1)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item3)
            end
        elseif data.current.value == 'ASDust' then
            menu.close()
            local item = CF.GetInventory()['sawdust']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item3,0)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item3)
            end
        elseif data.current.value == 'Paper' then
            menu.close()
            local item = CF.GetInventory()['paper']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item4,1)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item4)
            end
        elseif data.current.value == 'APaper' then
            menu.close()
            local item = CF.GetInventory()['paper']
            if item.count > 0 then
                TriggerServerEvent("esx_lumberjack:sellitem",item4,0)
            else
                TriggerServerEvent("esx_lumberjack:noitem",item4)
            end
        elseif data.current.value == 'exit' then
            menu.close()
        end
    end)
end