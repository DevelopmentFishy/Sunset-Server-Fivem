function getid(source,parametre2)

    local identifier = {}
    local identifiers = {}
 
    identifiers = GetPlayerIdentifiers(source)
  
    for i = 1, #identifiers do
        if string.match(identifiers[i], "discord:") then
            identifier["discord"] = string.sub(identifiers[i], 9)
            identifier["discord"] = "<@"..identifier["discord"]..">"
        end
        if parametre2 == 'esx' then
        if string.match(identifiers[i], "steam:") then
            identifier["license"] = identifiers[i]
        end
        else
            if string.match(identifiers[i], "license:") then
                identifier["license"] = identifiers[i]
            end
            
        end
    end
    if identifier["discord"] == nil then
        identifier["discord"] = "Bilinmiyor"
    end
    return identifier
 end
 
 function dclog(webhook, title, text, target)
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 3092790,
            ["title"] = title,
            ["description"] = text,
            ["footer"] = {
                ["text"] = "CodeM Store      " ..time,
                ["icon_url"] = Config.IconURL,
            },
        }
    }
    PerformHttpRequest(Config.PlayerWebhook, function(err, text, headers) end, 'POST', json.encode({username = Config.Botname, embeds = connect, avatar_url = Config.Logo}), { ['Content-Type'] = 'application/json' })
 end