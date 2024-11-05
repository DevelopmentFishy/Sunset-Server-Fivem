local QBCore = exports['qb-core']:GetCoreObject()
local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1191874220108554240/BPu7AX9D4lGQebwD_oEUj5Mx7SGAntFKTJG_bbhc1ZzT0Jnjc_siIKOU0wc5ftvUayMQ',
    ['testwebhook'] = '',
    ['playermoney'] = 'https://discord.com/api/webhooks/1183980103248658432/3IoEkM0gi9Ty_56UQ23F_rXwejc9S-Dqb0lPY0la84xOlAO8FkfykNEPxZeyD4m_I7DC',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1211766424654057513/ZsTGnmhPv8Pr3OVXoIcUW767OLcnxqFb6uXbEWcwa7eOi63-IH0nZ9BycJfBzvH4Ns5R',
    ['robbing'] = 'https://discord.com/api/webhooks/1183980273843580928/g2wxH1ir9ZHdDwoHY-r77rlVBRAw-LBYcf6TDlRbzRZxbvEbdsNSHHxbdG87HVZY8dvb',
    ['cuffing'] = 'https://discord.com/api/webhooks/1183980354122547321/ymZvJmUuqUHGK-6_kRRz0JFpYJ13edFCIzY4Co4YBb5y-GjZKBJjYkwTyRq65NJoWCZM',
    ['drop'] = 'https://discord.com/api/webhooks/1183980425224400916/7w-dGqovZTht-XHbRkNs9guh9t-kCIOHvM3pWBQGX-4HslF0GIrASJHZGSHluT8G1TyE',
    ['trunk'] = 'https://discord.com/api/webhooks/1183980484317950094/RIc-pxBzGd_4b338hxHGjEPKxfoLINLu8QAWP-NKEYMw9vjM8JJ4AhsmAHtCR2XpADI2',
    ['stash'] = 'https://discord.com/api/webhooks/1183980573472071801/Z3mLm03_1P7CoQk2KO6DIVAc4vlwS-0t7NmVmfg-1pA787JNZwUYJiNtHUyuiCZPyDuE',
    ['glovebox'] = 'https://discord.com/api/webhooks/1183980642359320698/JYGQomKYbmrvXMGQBA8GHxu4Old28hZ2M-DIjH5Iw8lZ6LRpLsH42TTIlGoYWvw-wAvB',
    ['banking'] = 'https://discord.com/api/webhooks/1183980725398143067/il0-Npn-4TqfyGe4JaCVZ5W4uO3o-eV7HC_y2vcbH_IC5tqN9NiTfIyvpRIhnMoeI610',
    ['vehicleshop'] = '',
    ['vehicleupgrades'] = '',
    ['shops'] = '',
    ['dealers'] = '',
    ['storerobbery'] = '',
    ['bankrobbery'] = '',
    ['powerplants'] = '',
    ['death'] = '',
    ['joinleave'] = 'https://discord.com/api/webhooks/1183980818482348162/NZkuv3W50_SZXC2hiKtYDA6cl9-tBO5kva3Qd-XVwi5a0loEEznsFl5ZvGjx_a-JHtgq',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = '',
    ['anticheat'] = '',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ['robbery'] = 'https://discord.com/api/webhooks/1211766424654057513/ZsTGnmhPv8Pr3OVXoIcUW767OLcnxqFb6uXbEWcwa7eOi63-IH0nZ9BycJfBzvH4Ns5R',
    ['casino'] = '',
    ['traphouse'] = '',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ['qbjobs'] = '',
}

local colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local logQueue = {}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local postData = {}
    local tag = tagEveryone or false
    if not Webhooks[name] then print('Tried to call a log that isn\'t configured with the name of ' ..name) return end
    local webHook = Webhooks[name] ~= '' and Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = colors[color] or colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://raw.githubusercontent.com/GhzGarage/qb-media-kit/main/Display%20Pictures/Logo%20-%20Display%20Picture%20-%20Stylized%20-%20Red.png',
            },
        }
    }

    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name] + 1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        if tag then
            postData = {username = 'QB Logs', content = '@everyone', embeds = {}}
        else
            postData = {username = 'QB Logs', embeds = {}}
        end
        for i = 1, #logQueue[name] do postData.embeds[#postData.embeds + 1] = logQueue[name][i].data[1] end
        PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
        logQueue[name] = {}
    end
end)

Citizen.CreateThread(function()
    local timer = 0
    while true do
        Wait(1000)
        timer = timer + 1
        if timer >= 60 then -- If 60 seconds have passed, post the logs
            timer = 0
            for name, queue in pairs(logQueue) do
                if #queue > 0 then
                    local postData = {username = 'QB Logs', embeds = {}}
                    for i = 1, #queue do
                        postData.embeds[#postData.embeds + 1] = queue[i].data[1]
                    end
                    PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), {['Content-Type'] = 'application/json'})
                    logQueue[name] = {}
                end
            end
        end
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')