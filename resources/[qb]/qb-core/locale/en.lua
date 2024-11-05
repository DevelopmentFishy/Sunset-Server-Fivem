local Translations = {
    error = {
        not_online = 'Speler niet online',
        wrong_format = 'Onjuiste opmaak',
        missing_args = 'Niet elk argument is ingevuld (x, y, z)',
        missing_args2 = 'Alle argumenten moeten worden ingevuld!',
        no_access = 'Geen toegang tot dit commando',
        company_too_poor = 'Je werkgever is arm',
        item_not_exist = 'Item bestaat niet',
        too_heavy = 'Broekzakken zitten vol',
        location_not_exist = 'Locatie bestaat niet',
        duplicate_license = 'Dubbele Rockstar-licentie gevonden',
        no_valid_license  = 'Geen geldige Rockstar-licentie gevonden',
        not_whitelisted = 'U bent niet whitelisted voor deze server',
        server_already_open = 'De server is al open',
        server_already_closed = 'De server is al gesloten',
        no_permission = 'Je hebt geen permissie voor dit..',
        no_waypoint = 'Geen bestemming geselecteerd',
        tp_error = 'Er is een foutje begaan tijdens het teleporteren',
        connecting_database_error = 'Er is een databasefout opgetreden tijdens het maken van een verbinding met de server. (Is de SQL-server ingeschakeld?)',
        connecting_database_timeout = 'Er is een time-out opgetreden voor verbinding met database. (Is de SQL-server ingeschakeld?)',
    },
    success = {
        server_opened = 'De server is geopend',
        server_closed = 'De server is gesloten',
        teleported_waypoint = 'Geteleporteerd naar bestemming',
    },
    info = {
        received_paycheck = 'Je hebt je salaris ontvangen van $%{value}',
        job_info = 'Job: %{value} | Graad: %{value2} | Dienst: %{value3}',
        gang_info = 'Gang: %{value} | Graad: %{value2}',
        on_duty = 'U bent nu in dienst!',
        off_duty = 'U bent nu uit dienst!',
        checking_ban = 'Hallo %s. We checken even of je op onze banlist staat.',
        join_server = 'Welkom %s bij {Server Name}.',
        checking_whitelisted = 'Hallo %s. We checken even of je toegang hebt.',
        exploit_banned = 'Je bent verbannen wegens cheating. Bekijk onze Discord voor meer informatie: %{discord}',
        exploit_dropped = 'Je bent gekicked voor exploitation',
    },
    command = {
        tp = {
            help = 'TP To Player or Coords (Admin Only)',
            params = {
                x = { name = 'id/x', help = 'ID of player or X position' },
                y = { name = 'y', help = 'Y position' },
                z = { name = 'z', help = 'Z position' },
            },
        },
        tpm = { help = 'TP To Marker (Admin Only)' },
        togglepvp = { help = 'Toggle PVP on the server (Admin Only)' },
        addpermission = {
            help = 'Give Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        removepermission = {
            help = 'Remove Player Permissions (God Only)',
            params = {
                id = { name = 'id', help = 'ID of player' },
                permission = { name = 'permission', help = 'Permission level' },
            },
        },
        openserver = { help = 'Open the server for everyone (Admin Only)' },
        closeserver = {
            help = 'Close the server for people without permissions (Admin Only)',
            params = {
                reason = { name = 'reason', help = 'Reason for closing (optional)' },
            },
        },
        car = {
            help = 'Spawn Vehicle (Admin Only)',
            params = {
                model = { name = 'model', help = 'Model name of the vehicle' },
            },
        },
        dv = { help = 'Delete Vehicle (Admin Only)' },
        dvall = { help = 'Delete All Vehicles (Admin Only)' },
        dvp = { help = 'Delete All Peds (Admin Only)' },
        dvo = { help = 'Delete All Objects (Admin Only)' },
        givemoney = {
            help = 'Give A Player Money (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                moneytype = { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Amount of money' },
            },
        },
        setmoney = {
            help = 'Set Players Money Amount (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                moneytype = { name = 'moneytype', help = 'Type of money (cash, bank, crypto)' },
                amount = { name = 'amount', help = 'Amount of money' },
            },
        },
        job = { help = 'Check Your Job' },
        setjob = {
            help = 'Set A Players Job (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                job = { name = 'job', help = 'Job name' },
                grade = { name = 'grade', help = 'Job grade' },
            },
        },
        gang = { help = 'Check Your Gang' },
        setgang = {
            help = 'Set A Players Gang (Admin Only)',
            params = {
                id = { name = 'id', help = 'Player ID' },
                gang = { name = 'gang', help = 'Gang name' },
                grade = { name = 'grade', help = 'Gang grade' },
            },
        },
        ooc = { help = 'OOC Chat Message' },
        me = {
            help = 'Show local message',
            params = {
                message = { name = 'message', help = 'Message to send' }
            },
        },
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
