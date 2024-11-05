local resource = GetCurrentResourceName()
local JSON = LoadResourceFile(resource, ('locales/%s.json'):format(Config.locale)) or LoadResourceFile(resource, 'locales/en.json')

function locale(str, ...)
    local dict = JSON and json.decode(JSON) or {}
    local lstr = dict[str]

    if lstr then
        if ... then
            return lstr and lstr:format(...)
        end

        return lstr
    end

    return ("Translation for '%s' does not exist"):format(str)
end

--[[ exemple 
    bought: "Vous avez acheté x%s %s"
    locale('bought', 3, 'chocolat')
    --> "Vous avez acheté x3 chocolat"
]]