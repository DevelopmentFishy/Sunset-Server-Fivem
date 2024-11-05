Settings = {}

Settings.play_button_sound = true
Settings.should_ai_cars_move = true
    -- If set to false, AI cars won't move out of the player's way when lights & sirens are running
    -- This will also prevent the car's wigwags from enabling outside of stage 3.
Settings.Debug = false -- If set to `true`, this will log additional information

Settings.WMSiren = false
    -- Setting this to true will make EZELS assume *all* sirens are using WMSirens
    -- This will cause non-WMSiren sirens to not work
    -- Read the guide for more info on using WMServerSirens

Settings.TurnSirensOffOnExit = true -- When you exit any police vehicle, the audible siren will turn off

Settings.lighting = {
    flash_delay = 20,
    environmental_brightness = 0.20,
    environmental_range = 155.0,
    environmental_falloff = 5.0,
    directional = false
}

Settings.ui_panel = {
    enabled = false,
    type = 'be200', -- Options are `luxart`, `minimal`, `be200`, or `be200alt`. Check the guide for instructions on custom panels.
    ui_color_override = nil -- Set to `nil` if you want to use the VCF-specified color. Otherwise use a hex code i.e. `#3030ff`
}

-- **NOTE** These are just the default keybindings. EZELS uses FiveM keymapping, so after a player joins they can customize they controls as they wish.
--          If you change a keybinding here, it will only effect players who haven't joined the server yet.
-- Control numbers can be found in the FiveM docs
-- https://docs.fivem.net/docs/game-references/controls/
Settings.input = {
    keyboard = {
        -- nil means control is disabled, use the controls link above to customize.
        guiToggle = 199, -- P
        modifier = 132, -- LCTRL
        stageChange = 85, -- Q
        takedown = 83, -- =
        sceneLights = 84, -- -
        cruiseLights = 194, -- Backspace
        horn = 86, -- E
        arrowboard = nil,
        siren = {
            tone_one = 157, -- 1
            tone_two = 158, -- 2
            tone_three = 160, -- 3
            tone_four = 164, -- 4
            hands_free = 86, -- E/horn. Use of this key is controlled by DefaultSirenMode in the VCF.
            manual_tone_one = nil,
            manual_tone_two = nil,
            cycle = nil -- Press to cycle, long press to turn off.
        },
        pattern = {
            primary = 163, -- 9
            secondary = 162, -- 8
            warning = 161 -- 7
        },
        warning = 246, -- Y
        secondary = 303, -- U
        primary = 7, -- L
    }
}

-- These RGB color values change both the color of the light emitters, and the UI colors
-- If you want to use a previously unsupported color in your VCF, you can just list it here
Settings.Colors = {}
Settings.Colors['blue'] = { r=0, g=21, b=160 }
Settings.Colors['eblue'] = { r=25, g=173, b=232 }
Settings.Colors['amber'] = { r=232, g=162, b=12 }
Settings.Colors['orange'] = Settings.Colors.amber
Settings.Colors['green'] = { r=0, g=255, b=0 }
Settings.Colors['red'] = { r=255, g=0, b=0 }
Settings.Colors['white'] = { r=255, g=255, b=255 }
Settings.Colors['grey'] = { r=128, g=128, b=128 }
Settings.Colors['gray'] = Settings.Colors.grey
Settings.Colors['yellow'] = { r=255, g=255, b=0 }
