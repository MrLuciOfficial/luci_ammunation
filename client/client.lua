ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback("exit", function()
    SetDisplay(false)
end)

RegisterNUICallback("kupovina", function(data)
    if (data.status) then
        TriggerServerEvent('luci_amunation:kupi-oruzije', data.predmetIme, data.predmetHex, data.cenaPredmeta)
    else
        TriggerServerEvent('luci_amunation:kupi-predmet', data.predmetIme, data.predmetHex, data.cenaPredmeta)
    end
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        predmeti = Config.Predmeti,
    })
end

Citizen.CreateThread(function()
    while false do
        Citizen.Wait(0)
        DisableControlAction(0, 1, false)
        DisableControlAction(0, 2, false)
        DisableControlAction(0, 142, false)
        DisableControlAction(0, 18, false)
        DisableControlAction(0, 322, false)
        DisableControlAction(0, 106, false)
    end
end)

Citizen.CreateThread(function()
    for i = 1, #Config.Lokacije do
        local amcik = Config.Lokacije[i]
        local blip = AddBlipForCoord(amcik[1], amcik[2], amcik[3])

        SetBlipSprite (blip, 110)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 1)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Ammunation Shop')
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler("otvoriKataklog", function()
    SetDisplay(true)
end)

local kasa = {
	1165564444,
}

exports["qtarget"]:AddTargetModel(kasa, {
	
	options = {
		{
		event = "otvoriKataklog",
		icon = "fas fa-book-open",
		label = "Pogledaj katalog",
		},
	},
	job = {"all"},
	distance = 1.0
})