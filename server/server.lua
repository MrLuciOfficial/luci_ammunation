ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('luci_amunation:kupi-oruzije')
AddEventHandler('luci_amunation:kupi-oruzije', function(predmetIme, predmetHex, cenaPredmeta)
    local igrac = ESX.GetPlayerFromId(source)

    if not igrac.getWeapon(predmetHex) then
        if (igrac.getMoney() >= tonumber(cenaPredmeta)) then
            igrac.removeMoney(tonumber(cenaPredmeta))
            igrac.addWeapon(predmetHex, 0)
            Logovi('``🔫`` KUPOVINA ORUZIJA', '**IGRAC:** ``'.. GetPlayerName(source) ..'``\n**ORUZIJE:** ``'.. predmetIme ..'``\n**CENA:** ``$'.. cenaPredmeta ..'``', 65280)
            TriggerClientEvent('luci_notifikacije:notifikacija', source, "Kupili ste ".. predmetIme .."", 5000)
        else
            TriggerClientEvent('luci_notifikacije:notifikacija', source, "Nemate dovoljno novca!", 5000)
        end
    else
        TriggerClientEvent('luci_notifikacije:notifikacija', source, "Ovo oruzije imas kod sebe", 5000)
    end
end)

RegisterNetEvent('luci_amunation:kupi-predmet')
AddEventHandler('luci_amunation:kupi-predmet', function(predmetIme, predmetHex, cenaPredmeta)
    local igrac = ESX.GetPlayerFromId(source)

    if (igrac.getMoney() >= tonumber(cenaPredmeta)) then
        igrac.removeMoney(tonumber(cenaPredmeta))
        igrac.addInventoryItem(predmetHex, 1)
        Logovi('``🔫`` KUPOVINA PREDMETA', '**IGRAC:** ``'.. GetPlayerName(source) ..'``\n**PREDMET:** ``'.. predmetIme ..'``\n**CENA:** ``$'.. cenaPredmeta ..'``', 65280)
        TriggerClientEvent('luci_notifikacije:notifikacija', source, "Kupili ste ".. predmetIme .."", 5000)
    else
        TriggerClientEvent('luci_notifikacije:notifikacija', source, "Nemate dovoljno novca!", 5000)
    end
end)

function Logovi(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "LOGOVI",
              },
          }
      }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "LOGOVI", embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end 