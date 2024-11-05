--░██╗░░░░░░░██╗███████╗██████╗░██╗░░██╗░█████╗░░█████╗░██╗░░██╗░██████╗
--░██║░░██╗░░██║██╔════╝██╔══██╗██║░░██║██╔══██╗██╔══██╗██║░██╔╝██╔════╝
--░╚██╗████╗██╔╝█████╗░░██████╦╝███████║██║░░██║██║░░██║█████═╝░╚█████╗░
--░░████╔═████║░██╔══╝░░██╔══██╗██╔══██║██║░░██║██║░░██║██╔═██╗░░╚═══██╗
--░░╚██╔╝░╚██╔╝░███████╗██████╦╝██║░░██║╚█████╔╝╚█████╔╝██║░╚██╗██████╔╝
--░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░╚═╝╚═════╝░



--      _       _     _   _
--     / \   __| | __| | | |__   ___ _ __ ___
--    / _ \ / _` |/ _` | | '_ \ / _ \ '__/ _ \
--   / ___ \ (_| | (_| | | | | |  __/ | |  __/
--  /_/   \_\__,_|\__,_| |_| |_|\___|_|  \___|


--- @param Important, add a webhook here, otherwise the images won't work.

-- Mandatory webhook or Fivemanage token [https://www.fivemanage.com] (full use)
Config.Webhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'

Config.TwitterWebhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'
Config.InstagramWebhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'
Config.YellowPagesWebhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'
Config.NewsWebhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'
Config.DarkWebBuy = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB'
Config.BankWebhook = 'https://discord.com/api/webhooks/1191002998420283464/dINXWMYjmMxrNbx6kEwQo82pduHJKwU5FSRcjGxCpWnB7aOe_zxew14xDBe2ZN-UdEHB' -- You can modify on qs-smartphone/server/custom/misc/bank.lua


--      _       _     _   _
--     / \   __| | __| | | |__   ___ _ __ ___
--    / _ \ / _` |/ _` | | '_ \ / _ \ '__/ _ \
--   / ___ \ (_| | (_| | | | | |  __/ | |  __/
--  /_/   \_\__,_|\__,_| |_| |_|\___|_|  \___|





-- Options
Config.PublicWebhookFooter = 'Quasar Smartphone Logs'
Config.WebhookImage = 'https://media.discordapp.net/attachments/926274292373655562/999502096430796950/xd.png?width=676&height=676'

Config.Webhooks = { -- Enable or disable webhooks.
    twitter = true,
    instagram = true,
    yellowpages = true,
    news = true,
}

Config.WebhooksTranslations = { -- All webhook translations.
    ['twitter'] = {
        name = 'Twitter',
        title = 'New Tweet!',
        username = '**Username**: @',
        description = '\n**Description**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999492805770608710/tweedle.png'
    },

    ['instagram'] = {
        name = 'Instagram',
        title = 'New Post!',
        username = '**Username**: @',
        description = '\n**Description**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999504825450500157/instagraph.png'
    },

    ['yellowpages'] = {
        name = 'Yellow Pages',
        title = 'New Post!',
        username = '**Username**: ',
        description = '\n**Description**: ',
        number = '\n**Number**: ',
        image = 'https://media.discordapp.net/attachments/926274292373655562/999508700907700234/yellow_pages.png'
    },

    ['news'] = {
        name = 'News',
        title = 'New Storie!',
        storie = '**Title**: ',
        description = '\n**Description**: ',
        date = '\n**Number**: ',
        image = 'https://media.discordapp.net/attachments/989917195972788234/1002266182994362379/news.png'
    },
}

function WebhookDarkWeb(player, item, data, exploit)
    local embed = {}
    local message

    if exploit then
        message = '@everyone'
        dataFinal = {
            Item = tostring(data.Item) or false,
            Label = tostring(data.Label) or false,
            isItem = tostring(data.isItem) or false,
            Price = tostring(data.Price) or false,
            Count = tostring(data.Count) or false,
        }
        embed = {
            ['color'] = 16711680,
            ['title'] = 'qs-smartphone DarkWeb EXPLOITED',
            ['description'] = '**ID:** `' .. player.source .. '` \n**Identifier:** `' .. player.identifier .. '` \n**Item:** `' .. item .. '`.',
            ['footer'] = {
                ['text'] = 'Data: \nItem : ' .. dataFinal.Item .. ' \nLabel : ' .. dataFinal.Label .. ' \nisItem? : ' .. dataFinal.isItem .. ' \nPrice : ' .. dataFinal.Price .. ' \nCount : ' .. dataFinal.Count .. ' \nEncoded Data : ' .. json.encode(data, { indent = true }) .. '.'
            }
        }
    else
        message = ''
        embed = {
            ['color'] = 65280,
            ['title'] = 'SMARTPHONE DarkWeb',
            ['description'] = '**ID:** `' .. player.source .. '` \n**Identifier:** `' .. player.identifier .. '` \n**Item:** `' .. item .. '` **amount:** `' .. data .. '`.',
        }
    end

    PerformHttpRequest(Config.DarkWebBuy, function(err, text, headers) end, 'POST', json.encode({ username = 'Smartphone', content = message, embeds = { embed } }), { ['Content-Type'] = 'application/json' })
end
