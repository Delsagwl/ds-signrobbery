local QBCore = exports['qb-core']:GetCoreObject()
local senyales = {}
local mostrando = false
local prop = nil
local Cooldown = false

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('ds-signrobbery:server:GetObjects', function(incObjects)
        senyales = incObjects
    end)
end)

--Functions
local function AlertCops()
    if not Cooldown then
        ExecuteCommand(Config.comando.." "..Config.texto)
        Cooldown = true
    end
end

local function desguazar()
    TriggerEvent("ds-signRobbery:Mesa:Menu")
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

local function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

--Eventos
RegisterNetEvent("ds-signrobbery:client:robarSign", function(data)
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('ds-signrobbery:server:GetCops', function(cops)
        if cops >= Config.minimopolicia then
            exports['ps-ui']:Circle(function(success)
                AlertCops()
                if success then
                    loadAnimDict("amb@prop_human_bum_bin@base")
                    TaskPlayAnim(ped, "amb@prop_human_bum_bin@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                    QBCore.Functions.Progressbar("robbing_sign", "Robando señal..", math.random(5000, 7000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, function()
                    end, function()
                        local coords = GetEntityCoords(data.entity)
                        SetEntityAsMissionEntity(data.entity, true, true)
                        StopAnimTask(ped, "amb@prop_human_bum_bin@base", "base", 1.0)
                        DeleteEntity(data.entity)
                        local object = {coords = coords, model = -949234773}
                        TriggerServerEvent("ds-signrobbery:server:borrar", object)
                    end)
                end
            end, 2, 6)
        else
            QBCore.Functions.Notify("No hay suficientes policías de servicio", "error")
        end
    end)
end)

function animacionSenyal(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    loadAnimDict("amb@world_human_janitor@male@base")
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(prop1)
    TaskPlayAnim(Player, "amb@world_human_janitor@male@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)

    CreateThread(function()
        while mostrando do
            Wait(1000)
            if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_janitor@male@base", "base", 3) and mostrando then
                mostrando = false
                DeleteEntity(prop)
            end
        end
    end)
end

--Emotes
RegisterNetEvent("ds-signrobbery:usar:Sign", function(item)
    if not mostrando then
        if item == "stop" then
            mostrando = true
            animacionSenyal("prop_sign_road_01a", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "peatones" then
            mostrando = true
            animacionSenyal("prop_sign_road_05a", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "interseccion" then
            mostrando = true
            animacionSenyal("prop_sign_road_03e", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "girou" then
            mostrando = true
            animacionSenyal("prop_sign_road_03m", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "noparking" then
            mostrando = true
            animacionSenyal("prop_sign_road_04a", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "giroizquierda" then
            mostrando = true
            animacionSenyal("prop_sign_road_05e", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "giroderecha" then
            mostrando = true
            animacionSenyal("prop_sign_road_05f", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "nopasar" then
            mostrando = true
            animacionSenyal("prop_sign_road_restriction_10", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        elseif item == "ceda" then
            mostrando = true
            animacionSenyal("prop_sign_road_02a", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        else
            mostrando = true
            animacionSenyal("prop_sign_road_02a", 57005, 0.10, -1.0, 0.0, -90.0, -250.0, 0.0)
        end
    else
        mostrando = false
        DeleteEntity(prop)
        ClearPedSecondaryTask(PlayerPedId())
    end
end)

--Deleting The Sign Event
RegisterNetEvent("signrobbery:client:borrar", function(object)
    senyales[#senyales+1] = {coords = object.coords, model = object.model}
    local ent = GetClosestObjectOfType(object.coords.x, object.coords.y, object.coords.z, 0.1, object.model, false, false, false)
    if DoesEntityExist(ent) then
        SetEntityAsMissionEntity(ent, 1, 1)
        DeleteObject(ent)
        SetEntityAsNoLongerNeeded(ent)
    end
end)

RegisterNetEvent('ds-signRobbery:client:TradeAnim', function(data)
    local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('ds-signRobbery:server:TradeItems', data)
	TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(1500)
    mostrando = false
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
    RemoveAnimDict("mp_common")
end)

RegisterNetEvent('ds-signRobbery:Mesa:Menu', function()
    exports['qb-menu']:openMenu({
		{ header = "Desguazar señal", txt = "Desguazar", isMenuHeader = true },
		{ header = "Señal de Stop", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "stop" } },
		{ header = "Señal de paso de peatones",  txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "peatones" } },
        { header = "Señal de no bloquear intersección",  txt = "InDesguazartercambiar", params = { event = "ds-signRobbery:client:TradeAnim", args = "interseccion" } },
        { header = "Giro en U", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "girou" } },
        { header = "Señal de No Aparcar", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "noparking" } },
        { header = "Señal de  giro a la izquierda", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "giroizquierda" } },
        { header = "Señal de  giro a la derecha", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "giroderecha" } },
        { header = "Señal de No pasar", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "nopasar" } },
        { header = "Ceda el paso", txt = "Desguazar", params = { event = "ds-signRobbery:client:TradeAnim", args = "ceda" } },
        { header = "", txt = "❌ Cerrar", params = { event = "ds-signRobbery:CloseMenu" } },
    })
end)
RegisterNetEvent("ds-signRobbery:CloseMenu", function() exports['qb-menu']:closeMenu() end)


--Target hilos
CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.props, {
        options = {
            {
                type = 'client',
                event = "ds-signrobbery:client:robarSign",
                icon = 'fas fa-user-secret',
                label = 'Robar Señal',
            }
        },
        distance = 4.0,
    })
    exports['qb-target']:AddBoxZone("SignRobberyScrap", vector3(-575.28, -1654.31, 19.53), 1.5, 1, {
        name = "SignRobberyScrap",
        heading = 243.06,
        debugPoly = false,
        minZ = 18.35,
        maxZ = 20.35,
    }, {
        options = {
            {
                type = "client",
                event = "ds-signRobbery:Mesa:Menu",
                icon = "fas fa-recycle",
                label = "Desguazar Señal",
            },
        },
        distance = 2.5
    })
end)

--Cooldown
CreateThread(function()
    while true do
        if Cooldown == true then
            Wait(60000)
            Cooldown = false
        end
        Wait(1000)
    end
end)

CreateThread(function()
    RequestModel(GetHashKey("prop_tool_bench02_ld"))
    while not HasModelLoaded(GetHashKey("prop_tool_bench02_ld")) do Wait(1) end
    mesatrabajo = CreateObject(GetHashKey("prop_tool_bench02_ld"),-575.28, -1654.31, 18.53,false,false,false)
    SetEntityHeading(mesatrabajo, 243.06)
    FreezeEntityPosition(mesatrabajo, true)
    
    while true do
        local sleep = 4000
        local pos = GetEntityCoords(PlayerPedId())
        local coords = vector3(-575.97, -1655.19, 19.67)
        if #(pos- coords) < 10 then
            DrawMarker(21, -575.97, -1655.19, 19.67, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0, 0, 0, 222, false, false, false, true, false, false, false)
            sleep = 5
            if #(pos- coords) < 1.5 then
                exports['qb-core']:DrawText("[E] Desguazar señales", 'left')
                if IsControlJustPressed(0,38) then
                    desguazar()
                end
            else
                exports['qb-core']:HideText()
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        for k = 1, #senyales, 1 do
            v = senyales[k]
            local ent = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 0.1, v.model, false, false, false)
            if DoesEntityExist(ent) then
                SetEntityAsMissionEntity(ent, 1, 1)
                DeleteObject(ent)
                SetEntityAsNoLongerNeeded(ent)
            end
        end
        Wait(1000)
    end
end)