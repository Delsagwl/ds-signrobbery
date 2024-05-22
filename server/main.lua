local QBCore = exports['qb-core']:GetCoreObject()
local objects = {}

QBCore.Functions.CreateCallback("ds-signrobbery:server:GetObjects", function(source, cb)
    cb(objects)
end)

QBCore.Functions.CreateCallback('ds-signrobbery:server:GetCops', function(_, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterNetEvent('ds-signrobbery:server:borrar', function(object)
    local src = source
    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    if #(srcCoords - object.coords) < 4 then
        local Player = QBCore.Functions.GetPlayer(tonumber(src))
        objects[#objects+1] = {coords = object.coords, model = object.model}
        TriggerClientEvent("signrobbery:client:borrar", -1, object)
        if object.model == -949234773 then
            Player.Functions.AddItem("stop", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stop'], "add")
        elseif object.model == 1502931467 then
            Player.Functions.AddItem("peatones", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['peatones'], "add")
        elseif object.model == 1191039009 then
            Player.Functions.AddItem("interseccion", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['interseccion'], "add")
        elseif object.model == 4138610559 then
            Player.Functions.AddItem("girou", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['girou'], "add")
        elseif object.model == 3830972543 then
            Player.Functions.AddItem("noparking", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['noparking'], "add")
        elseif  object.model == 2643325436 then
            Player.Functions.AddItem("giroizquierda", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['giroizquierda'], "add")
		elseif  object.model == 793482617 then
            Player.Functions.AddItem("giroderecha", 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['giroderecha'], "add")
		elseif  object.model == 1021214550 then
			Player.Functions.AddItem("nopasar", 1, false)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['nopasar'], "add")
		elseif  object.model == 3654973172 then
			Player.Functions.AddItem("ceda", 1, false)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['ceda'], "add")
		end
	end
end)

-- Señales
for key, value in pairs(Config.signs) do
    QBCore.Functions.CreateUseableItem(value, function(source, item)
		local src = source
		TriggerClientEvent('ds-signrobbery:usar:Sign', src, item)
	end)
end

local function esvalidoitem(sign)
    for key, value in pairs(Config.signs) do
        if value == sign then
            return true
        end
    end
    return false
end

RegisterServerEvent("ds-signRobbery:server:TradeItems", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local random = ""
	local amount = 0
    local sign = tostring(data)
	if esvalidoitem(sign) then
		if Player.Functions.GetItemByName(sign) ~= nil and Player.Functions.GetItemByName(sign).amount >= 1 then
            Player.Functions.RemoveItem(sign, 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[sign], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 3, math.random(1,2) do
				random = Config.Recompensas[math.random(1, #Config.Recompensas)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(random, amount, false)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[random], 'add', amount)
                Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "No tienes suficientes artículos")
		end
	end
end)