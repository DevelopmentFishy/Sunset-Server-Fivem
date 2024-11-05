Config = Config or {}
-- ██╗███╗░░░███╗██████╗░░█████╗░██████╗░████████╗░█████╗░███╗░░██╗████████╗
-- ██║████╗░████║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗░██║╚══██╔══╝ 
-- ██║██╔████╔██║██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██╔██╗██║░░░██║░░░ 
-- ██║██║╚██╔╝██║██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║╚████║░░░██║░░░
-- ██║██║░╚═╝░██║██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║██║░╚███║░░░██║░░░
-- ╚═╝╚═╝░░░░░╚═╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░ 

--[[

    BEFORE YOU CONTINUE READ THIS

    If you are going to make any changes in these apps.
    How to translate them, change the order, delete them.

    It is very important that you USE the /deletallapps command in your server console and then restart the server.

    IF YOU DO NOT DO this the apps will continue as before

]]

-- ██████╗░███████╗███████╗░█████╗░██╗░░░██╗██╗░░░░░████████╗   ░█████╗░██████╗░██████╗░░██████╗
-- ██╔══██╗██╔════╝██╔════╝██╔══██╗██║░░░██║██║░░░░░╚══██╔══╝   ██╔══██╗██╔══██╗██╔══██╗██╔════╝
-- ██║░░██║█████╗░░█████╗░░███████║██║░░░██║██║░░░░░░░░██║░░░   ███████║██████╔╝██████╔╝╚█████╗░
-- ██║░░██║██╔══╝░░██╔══╝░░██╔══██║██║░░░██║██║░░░░░░░░██║░░░   ██╔══██║██╔═══╝░██╔═══╝░░╚═══██╗
-- ██████╔╝███████╗██║░░░░░██║░░██║╚██████╔╝███████╗░░░██║░░░   ██║░░██║██║░░░░░██║░░░░░██████╔╝
-- ╚═════╝░╚══════╝╚═╝░░░░░╚═╝░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░   ╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═════╝░

--[[
    -- Pre-installed applications (If you modify them, remember to empty the "apps" column of your sql "users").
    -- Example app DONT UNCOMMENT

    [1] = {                             -- Slot id, 'It is important that you follow the order of the numbers [1], [2], [3]....'
        custom = false,                 -- Is a custom app?
        app = "phone",                  -- name of app (dont touch if it is not custom).
        color = "img/apps/phone.png",   -- App visual image.
        tooltipText = "Phone",          -- Name on smartphone (Traslate if you want).
        tooltipPos = "top",             -- Ignore.
        job = false,                    -- Ignore.
        blockedjobs = {},               -- Ignore.
        slot = 1,                       -- Slot where the app will appear.
        Alerts = 0,                     -- Alerts that will appear in the app as soon as you use the phone.
        bottom = true                   -- Ignore.
    },
]]

Config.PhoneApplications = {
    [1] = {                           --- @param -- Slot id, 'It is important that you follow the order of the numbers [1], [2], [3]....'
        custom = false,               --
        app = 'phone',                -- App label.
        color = 'img/apps/phone.png', -- App visual image.
        tooltipText = 'Phone',        -- Ignore.
        tooltipPos = 'top',           -- Ignore.
        job = false,                  -- Ignore.
        blockedjobs = {},             -- Ignore.
        slot = 1,                     -- Slot where the app will appear.
        Alerts = 0,                   -- Alerts that will appear in the app as soon as you use the phone.
        bottom = true                 -- Ignore.
    },
    [2] = {
        custom = false,
        app = 'photos',
        color = 'img/apps/gallery.png',
        tooltipText = 'Gallery',
        job = false,
        slot = 2,
        blockedjobs = {},
        Alerts = 0,
        bottom = true
    },
    [3] = {
        custom = false,
        app = 'messages',
        color = 'img/apps/messages.png',
        tooltipText = 'Messages',
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
        bottom = true
    },
    [4] = {
        custom = false,
        app = 'safari',
        color = 'img/apps/zoo.png',
        tooltipText = 'Zoo',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
        bottom = true
    },
    [5] = {
        custom = false,
        app = 'mail',
        color = 'img/apps/mail.png',
        tooltipText = 'Mail',
        job = false,
        slot = 5,
        blockedjobs = {},
        Alerts = 0
    },
    [6] = {
        custom = false,
        app = 'calendar',
        color = 'img/apps/calendar.png',
        tooltipText = 'Calendar',
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0
    },
    [7] = {
        custom = false,
        app = 'camera',
        color = 'img/apps/camera.png',
        tooltipText = 'Camera',
        job = false,
        slot = 7,
        blockedjobs = {},
        Alerts = 0
    },
    [8] = {
        custom = false,
        app = 'store',
        color = 'img/apps/appstore.png',
        tooltipText = 'App Store',
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0
    },
    [9] = {
        custom = false,
        app = 'clock',
        color = 'img/apps/clock.png',
        tooltipText = 'Clock',
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0
    },
    [10] = {
        custom = false,
        app = 'ping',
        color = 'img/apps/ping.png',
        tooltipText = 'Ping',
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0
    },
    [11] = {
        custom = false,
        app = 'calculator',
        color = 'img/apps/calculator.png',
        tooltipText = 'Calculator',
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0
    },
    [12] = {
        custom = false,
        app = 'bank',
        color = 'img/apps/bank.png',
        tooltipText = 'Wallet',
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0
    },
    [13] = {
        custom = false,
        app = 'weather',
        color = 'img/apps/weather.png',
        tooltipText = 'Weather',
        job = false,
        slot = 13,
        blockedjobs = {},
        Alerts = 0
    },
    [14] = {
        custom = false,
        app = 'notes',
        color = 'img/apps/notes.png',
        tooltipText = 'Notes',
        job = false,
        slot = 14,
        blockedjobs = {},
        Alerts = 0
    },
    [15] = {
        custom = false,
        app = 'settings',
        color = 'img/apps/settings.png',
        tooltipText = 'Settings',
        job = false,
        blockedjobs = {},
        slot = 15,
        Alerts = 0
    },
    [16] = {
        custom = false,
        app = 'business',
        color = 'img/apps/business.png',
        tooltipText = 'Business',
        job = false,
        slot = 16,
        blockedjobs = {},
        Alerts = 0
    },
    --[[ [17] = {
        custom = false,
        app = "tips",
        color = "img/apps/tips.png",
        tooltipText = "Tips",
        job = false,
        slot = 17,
        blockedjobs = {},
        Alerts = 1
    }, ]]

    -- Temple for custom app!
    -- Check in docuementation for more info.
    --[[ [18] = {
        custom = true,
        app = "example",
        color = "img/apps/example.png",
        tooltipText = "Example",
        job = false,
        slot = 18,
        blockedjobs = {},
        Alerts = 0
    }, ]]
}

--░█████╗░██████╗░██████╗░  ░██████╗████████╗░█████╗░██████╗░███████╗
--██╔══██╗██╔══██╗██╔══██╗  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝
--███████║██████╔╝██████╔╝  ╚█████╗░░░░██║░░░██║░░██║██████╔╝█████╗░░
--██╔══██║██╔═══╝░██╔═══╝░  ░╚═══██╗░░░██║░░░██║░░██║██╔══██╗██╔══╝░░
--██║░░██║██║░░░░░██║░░░░░  ██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗
--╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░  ╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝

Config.StoreAppToday = {
    {
        header = 'NEW VERSION!',
        head = 'Enjoy iQS 2.0 and its beautiful design',
        image = 'https://media.discordapp.net/attachments/1166657197263036428/1212574938091880519/uPLQMVZ.png?ex=65f25569&is=65dfe069&hm=c275be88a242f8f79ee5a649e54358c58d1690a91359ab656169ef0c92441b41&=&format=webp&quality=lossless',
        footer = 'Your smartphone has iQS 2.0 now!',
        textcolor = 'white'
    },
}

Config.StoreApps = {
    -- Apps from the App Store.
    ['instagram'] = {
        custom = false,                    -- Is custom app?
        app = 'instagram',                 -- App label.
        color = 'img/apps/instagraph.png', -- App visual image.
        tooltipText = 'Instagraph',        -- Visual app name.
        tooltipPos = 'top',                -- Ignore.
        job = false,                       -- If you want this app to work only with jobs, put them inside ' '.
        blockedjobs = {},                  -- If you want this app to crash with jobs, put them inside {}.
        slot = 18,                         -- Slot where the app will be installed.
        Alerts = 0,                        -- Ignore.
        creator = 'Instagraph, Inc.​',
        password = false,
        isGame = false,
        description = 'Free - Offers In-App Purchases.',
        score = '4.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '22.5M Ratings',
        age = '16+',
        extraDescription = {
            {
                header = 'INSTAGRAPH',
                head = 'Enjoy with your friends!',
                image = 'https://img.freepik.com/premium-photo/group-diverse-friends-taking-selfie-beach_53876-91925.jpg?w=2000',
                footer = 'Bringing you closer to the people and things you love!',
                textcolor = 'white'
            }
        }
    },
    ['garage'] = {
        custom = false,
        app = 'garage',
        color = 'img/apps/garages.png',
        tooltipText = 'My Garage',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 19,
        creator = 'Raffaele Di Marzo.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Manage your vehicles data.',
        score = '3.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '48 Ratings',
        age = '18+',
        extraDescription = {
            {
                header = 'MY GARAGE',
                head = 'Manage your vehicles here.',
                image = 'https://i.ibb.co/k6VyMMC/Pv9-W8i-P-d.webp',
                footer = 'My Garage is the application that all owners of cars, motorcycles or other vehicles.',
                textcolor = 'white'
            }
        }
    },
    ['whatsapp'] = {
        custom = false,
        app = 'whatsapp',
        color = 'img/apps/chitchat.png',
        tooltipText = 'ChitChat',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 20,
        creator = 'ChitChat Inc.',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Simple. Reliable. Private.',
        score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '9.6M Ratings',
        age = '16+',
        extraDescription = {
            {
                header = 'CHITCHAT',
                head = '#3 in Social Networking',
                image = 'https://img.freepik.com/premium-photo/happy-indian-guy-using-mobile-phone-blue-studio-background_116547-20423.jpg?w=360',
                footer = 'ChitChat from Facebook is a FREE messaging and video calling app.',
                textcolor = 'white'
            }
        }
    },
    ['twitter'] = {
        custom = false,
        app = 'twitter',
        color = 'img/apps/tweedle.png',
        tooltipText = 'Tweedle',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 21,
        creator = 'Tweedle, Inc.',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Contains Ads·Offers in-app purchases',
        score = '3.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '19.3M Ratings',
        age = '17+',
        extraDescription = {
            {
                header = 'TWEEDLE',
                head = 'Are you ready to Tweet?',
                image = 'https://heraldodemexico.com.mx/u/fotografias/m/2022/12/12/f425x230-634931_648913_0.png',
                footer = 'Expand your social network and stay updated on whats trending now.',
                textcolor = 'white'
            }
        }
    },
    ['advert'] = {
        custom = false,
        app = 'advert',
        color = 'img/apps/yellow_pages.png',
        tooltipText = 'Yellow Pages',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 22,
        creator = 'YELLOWPAGES.COM LLC.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Find local businesses near you.',
        score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '36.1K Ratings',
        age = '4+',
        extraDescription = {
            {
                header = 'YELLOW PAGES',
                head = 'Advertise your articles here.',
                image = 'https://thumbs.dreamstime.com/b/portsmouth-hampshire-uk-mobile-phone-cell-being-held-hand-yellow-pages-app-open-screen-209900632.jpg',
                footer = 'More than 30,000 people publish their articles here!',
                textcolor = 'white'
            }
        }
    },
    ['tinder'] = {
        custom = false,
        app = 'tinder',
        color = 'img/apps/finder.png',
        tooltipText = 'Finder',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 23,
        creator = 'Finder Inc.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Chat and meet new people!',
        score = '4.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '10.5M Ratings',
        age = '16+',
        extraDescription = {
            {
                header = 'FINDER',
                head = 'With 30 billion matches to date!',
                image = 'https://www.lavanguardia.com/files/og_thumbnail/uploads/2018/07/10/5fa43bdde7073.jpeg',
                footer = 'Finder is the most popular app in the world to meet new people.',
                textcolor = 'white'
            }
        }
    },
    -- ['youtube'] = {
    --     custom = false,
    --     app = 'youtube',
    --     color = 'img/apps/youlink.png',
    --     tooltipText = 'YouLink',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 24,
    --     creator = 'YouLink LLC.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'Videos, Music and Live Streams',
    --     score = '3.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '24.3M Ratings',
    --     age = '17+',
    --     extraDescription = {
    --         {
    --             header = 'YOULINK',
    --             head = 'Your favorite videos and creators.',
    --             image = 'https://us.123rf.com/450wm/ufabizphoto/ufabizphoto1808/ufabizphoto180800224/105916085-mesa-de-trabajo-del-fot%C3%B3grafo.jpg?ver=6',
    --             footer = 'Discover a large number of videos and content creators!',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    ['uber'] = {
        custom = false,
        app = 'uber',
        color = 'img/apps/Catcafe.png',
        tooltipText = 'CatCafé',
        tooltipPos = 'top',
        job = { 'catcafe' },
        blockedjobs = {},
        slot = 25,
        creator = 'Sunset, Inc.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'De app voor de medewerkers van catcafé!',
        score = '4.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '4.9M Ratings',
        age = '12+',
        extraDescription = {
            {
                header = 'CatCafé',
                head = 'Find food delivery on your budget.',
                image = 'img/apps/Catcafe.png',
                footer = 'Start working now, with a simple click!',
                textcolor = 'white'
            }
        }
    },
    -- ['darkweb'] = {
    --     custom = false,
    --     app = 'darkweb',
    --     color = 'img/apps/darkweb.png',
    --     tooltipText = 'Onion Browser',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = { 'police' },
    --     slot = 26,
    --     creator = 'Mike Tigas.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'Secure, anonymous web with Tor.',
    --     score = '3.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '1.2K Ratings',
    --     age = '18+',
    --     extraDescription = {
    --         {
    --             header = 'ONION OR TOR',
    --             head = 'Secure, anonymous web/shop with Tor',
    --             image = 'https://www.adslzone.net/app/uploads-adslzone.net/2018/09/tor-browser-android.jpg?x=480&y=375&quality=40',
    --             footer = 'The best Tor-related offering on iOS right now is Onion Browser',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    ['state'] = {
        custom = false,
        app = 'state',
        color = 'img/apps/workspace.png',
        tooltipText = 'State',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 28,
        creator = 'Los Santos Inc.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Contact Los Santos employees.',
        score = '4.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = ' 12M Ratings',
        age = '4+',
        extraDescription = {
            {
                header = 'STATE',
                head = 'Police, ambulances and much more here',
                image = 'https://cdn.oldskull.net/wp-content/uploads/2014/12/los-santos-ciudad-de-gta.jpg',
                footer = 'Contact them directly now.',
                textcolor = 'white'
            }
        }
    },
    ['meos'] = {
        custom = false,
        app = 'meos',
        color = 'img/apps/police.png',
        tooltipText = 'Police',
        tooltipPos = 'top',
        job = { 'police' },
        blockedjobs = {},
        slot = 29,
        creator = 'LS Department.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Exclusive MDT for policemen.',
        score = '5', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = ' 12 Ratings',
        age = '18+',
        extraDescription = {
            {
                header = 'MDT',
                head = 'Database for police!',
                image = 'https://i.ibb.co/vV7zBqV/xIn2bWQ.png',
                footer = 'The Saints are safe thanks to your work.',
                textcolor = 'white'
            }
        }
    },
    -- ['jump'] = {
    --     custom = false,
    --     app = 'jump',
    --     color = 'img/apps/jump.png',
    --     tooltipText = 'Doodle Jump',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 30,
    --     creator = 'Hydra Dev.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = true,
    --     description = 'Insanely Addictive!',
    --     score = '4.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = ' 660 Ratings',
    --     age = '4+',
    --     extraDescription = {
    --         {
    --             header = 'DOODLE JUMP',
    --             head = 'BE WARNED: Insanely addictive!',
    --             image = 'https://thumbs.gfycat.com/ContentEnragedIridescentshark-size_restricted.gif',
    --             footer = 'Very fun jumping game!',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['spotify'] = {
    --     custom = false,
    --     app = 'spotify',
    --     color = 'img/apps/soundfy.png',
    --     tooltipText = 'Soundfy',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 31,
    --     creator = 'Soundfy AB.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'Play your music!',
    --     score = '4.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '25M Ratings',
    --     age = '12+',
    --     extraDescription = {
    --         {
    --             header = 'SOUNDFY',
    --             head = 'Play your music"',
    --             image = 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bXVzaWN8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
    --             footer = 'Listen to some tunes on Soundfy radio.',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['flappy'] = {
    --     custom = false,
    --     app = 'flappy',
    --     color = 'img/apps/flappy.png',
    --     tooltipText = 'Flappy Bird',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 32,
    --     creator = 'Essendon Studios.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = true,
    --     description = 'Jump with your Bird around the world!',
    --     score = '4.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '2M Ratings',
    --     age = '12+',
    --     extraDescription = {
    --         {
    --             header = 'FLAPPY BIRD',
    --             head = 'Jump with your Bird around the world!',
    --             image = 'https://deblogsyjuegos.files.wordpress.com/2015/10/flappygif.gif',
    --             footer = 'Have fun with the new Flappy Bird!',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['kong'] = {
    --     custom = false,
    --     app = 'kong',
    --     color = 'img/apps/kong.png',
    --     tooltipText = 'Donkey Kong',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 33,
    --     creator = 'Nintendo Inc.​',
    --     Alerts = 0,
    --     password = false,
    --     isGame = true,
    --     description = 'Save the princess!',
    --     score = '2.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '3M Ratings',
    --     age = '4+',
    --     extraDescription = {
    --         {
    --             header = 'DONKEY KONG',
    --             head = 'Save the princess!',
    --             image = 'https://i.gifer.com/1INx.gif',
    --             footer = 'Play as Mario to save Princess Peach from the clutches of Donkey Kong!',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['uberDriver'] = {
    --     custom = false,
    --     app = 'uberDriver',
    --     color = 'img/apps/drivenow.png',
    --     tooltipText = 'Drive Now',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 36,
    --     creator = 'Drive Now, Inc.',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'Request trips whenever you want',
    --     score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '12M Ratings',
    --     age = '16+',
    --     extraDescription = {
    --         {
    --             header = 'DRIVE NOW',
    --             head = 'Request trips whenever you want',
    --             image = 'https://www.acunor.es/wp-content/uploads/elementor/thumbs/shutterstock_2045581154FILEminimizer-pu611nm0zd2qyrj4p5mdneydbdm3yslsn9p6mk7mcw.jpg',
    --             footer = 'In Drive Now we commit ourselves to your security.',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['weazel'] = {
    --     custom = false,
    --     app = 'weazel',
    --     color = 'img/apps/news.png',
    --     tooltipText = 'News',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 37,
    --     creator = 'iQS Basics',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'Discover all the fresh news',
    --     score = '4.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '18M Ratings',
    --     age = '9+',
    --     extraDescription = {
    --         {
    --             header = 'News',
    --             head = 'Journalists of all Los Santos!',
    --             image = 'https://cdn.neow.in/news/images/uploaded/2020/02/1580744740_og__divs9jfd19aq.jpg',
    --             footer = 'Discover all the fresh news.',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['tiktok'] = {
    --     custom = false,
    --     app = 'tiktok',
    --     color = 'img/apps/ticktock.png',
    --     tooltipText = 'TickTock',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 38,
    --     creator = 'TickTock Pte. Ltd.',
    --     Alerts = 0,
    --     password = false,
    --     isGame = false,
    --     description = 'TickTock is a global short video community.',
    --     score = '5', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '900M Ratings',
    --     age = '9+',
    --     extraDescription = {
    --         {
    --             header = 'TickTock',
    --             head = 'TickTock is a global short video community.',
    --             image = 'https://images.saymedia-content.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTc0MzA4OTQ1ODc0NjU5MTk2/soul-line-dances.jpg',
    --             footer = 'With this app you can discover, create and edit incredible videos',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['tower'] = {
    --     custom = false,
    --     app = 'tower',
    --     color = 'img/apps/tower.png',
    --     tooltipText = 'City Building',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 39,
    --     creator = 'Cool Happy',
    --     Alerts = 0,
    --     password = false,
    --     isGame = true,
    --     description = 'Happy Tower House Construction Game',
    --     score = '3.75', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '20K Ratings',
    --     age = '9+',
    --     extraDescription = {
    --         {
    --             header = 'City Building',
    --             head = 'Happy Fun House',
    --             image = 'https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/dd/09/0d/dd090df4-bf4c-788f-62e0-ca006227886d/source/512x512bb.jpg',
    --             footer = 'Happy Tower House Construction Game',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    -- ['labyrinth'] = {
    --     custom = false,
    --     app = 'labyrinth',
    --     color = 'img/apps/labyrinth.png',
    --     tooltipText = 'Maze Puzzle Game',
    --     tooltipPos = 'top',
    --     job = false,
    --     blockedjobs = {},
    --     slot = 40,
    --     creator = 'iOS Basics',
    --     Alerts = 0,
    --     password = false,
    --     isGame = true,
    --     description = 'Classic labyrinth game where you control the ball',
    --     score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
    --     rating = '100K Ratings',
    --     age = '9+',
    --     extraDescription = {
    --         {
    --             header = 'Maze Puzzle Game',
    --             head = 'Classic labyrinth game where you control the ball',
    --             image = 'https://i.ytimg.com/vi/JRXC2A9Hgl0/maxresdefault.jpg',
    --             footer = 'Play the best labyrinth maze game on your mobile',
    --             textcolor = 'white'
    --         }
    --     }
    -- },
    ['radio'] = {
        custom = false,
        app = 'radio',
        color = 'img/apps/radio.png',
        tooltipText = 'Radio',
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 42,
        creator = 'LS Radio Inc.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Radio work for all users.',
        score = '3.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = ' 332 Ratings',
        age = '16+',
        extraDescription = {
            {
                header = 'RADIO',
                head = 'A radio to connect to many frequencies!',
                image = 'https://i.ibb.co/RB7Pv6n/ENBVOUI.png',
                footer = 'Communicate quickly and safely.',
                textcolor = 'black'
            }
        }
    },

    -- Temple for custom app!
    -- Check in docuementation for more info.
    --[[ ['example'] = {
        custom = true,
        app = "example",
        color = "./img/apps/example.png",
        background = "#FFFFFF",
        tooltipText = "Example",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 44,
        creator = "Lucceti's Pizza, Inc.",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Request Pizza Deliveries',
        score = '4', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '12M Ratings',
        age = '3+',
        extraDescription = {
            {
                header = 'Uber',
                head = 'Request Pizza Deliveries',
                image = 'https://www.autofacil.es/wp-content/uploads/2021/05/coche_uber.jpg',
                footer = 'In Uber we commit ourselves to your security.',
                textcolor = 'white'
            }
        }
    }, ]]
    --[[ ['rentel'] = { -- Rental DLC.
        custom = false,
        app = "rentel",
        color = "img/apps/rentel.png",
        tooltipText = "Nextbike",
        tooltipPos = 'top',
        job = false,
        blockedjobs = {},
        slot = 45,
        creator = "nextbike.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Start cycling!',
        score = '3.50', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '333 Ratings',
        age = '4+',
        extraDescription = {
            {
                header = 'NEXTBIKE',
                head = 'The best bike rental app!',
                image = 'https://i.ibb.co/tsQT2hH/WPzp1PV.png',
                footer = 'Find bike rental areas or even make friends!',
                textcolor = 'white'
            }
        }
    }, ]]
    ['racing'] = { -- Racing DLC.
        custom = false,
        app = 'racing',
        color = 'img/apps/racing.png',
        tooltipText = 'Racing',
        tooltipPos = 'top',
        job = false,
        blockedjobs = { 'police' },
        slot = 46,
        creator = 'Los Santos Customs.​',
        Alerts = 0,
        password = false,
        isGame = false,
        description = 'Los Santos Illegal Racing App.',
        score = '4.25', -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = '5M Ratings',
        age = '16+',
        extraDescription = {
            {
                header = 'RACING',
                head = 'Illegal racing in Los Santos!',
                image = 'https://ibb.co/mzvLSRx',
                footer = 'Application created by LS Customs, to provide comfort to drivers.',
                textcolor = 'white'
            }
        }
    },

    --[[ ["sellix"] = { -- Sellix DLC.
        custom = false,
        app = "sellix",
        color = "img/apps/sellix.png",
        tooltipText = "Sellix",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 47,
        creator = "Sellix Inc.​",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "eCommerce Dashboard",
        score = "2.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = " 199 Ratings",
        age = "18+",
        extraDescription = {
            {
                header = "SELLIX",
                head = "eCommerce Dashboard",
                image = "https://i.ytimg.com/vi/yjEKxwnHLEc/maxresdefault.jpg",
                footer = "Manage your products and sales",
                textcolor = 'black'
            }
        }
    }, ]]

    --[[ ["crypto"] = {
        custom = false,
        app = "crypto",
        color = "img/apps/crypto.png",
        tooltipText = "Binance",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 41,
        creator = "Binance LTD",
        Alerts = 0,
        password = false,
        isGame = false,
        description = "A crypto exchange for all those diamondhands",
        score = "4.25", -- Options: 0, 0.25, 0.5, 0.75, 1, 1.25, 1.50, 1.75, 2, 2.25, 2.50, 2.75, 3, 3.25, 3.50, 3.75, 4, 4.25, 4.50, 4.75, 5
        rating = "316K Ratings",
        age = "18+",
        extraDescription = {
            {
                header = "BINANCE",
                head = "Cryptocurrency Exchange",
                image = "https://v2.cimg.co/news/75173/174150/adobestock-iryna-budanova-1-1.jpg",
                footer = "Binance: Buy Bitcoin!",
                textcolor = 'white'
            }
        }
    }, ]]
}
