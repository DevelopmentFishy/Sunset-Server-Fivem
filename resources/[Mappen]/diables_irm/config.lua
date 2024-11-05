Config = {}
--Only be activated when the script is not working properly, sending lots of information to the console so that the developer can see on a screenshot or in the log file where the problem is coming from.   
Config.debug = false

-- TARGET CONFIG

Config.target = 'qb-target' -- qb-target, ox-target, qtarget, luck-contextmenu, custom,

Config.menu = false -- for no user target, set true for active menu set Config.target false for no target
Config.menuTextControl = '~g~Appuyez sur E pour ouvrir le menu'
Config.menuTextSit = '~g~Appuyez sur E pour vous coucher'

Config.TargetLabelStop = 'Maak de MRI af'
Config.TargetLabelStart = 'Begin met MRI'
Config.TargetLabelSit = 'Liggen'

Config.KeyLeave = true -- true = players may leave the table at any time | false = players leave the table only when the doctor stops the machine
Config.KeyLeaveTable = 'X' -- Key for players to lower themselves from the table
Config.KeyTextLeaveTable = 'Afstappen van de MRI' -- Key text visible in FiveM keys

--Camera
Config.Camera = true
Config.CameraPos = vector4(316.53854370117, -582.36700439453, 38.325695037842+0.9, 34.364753723145)

Config.speed_up = 0.01

-- ON or OFF FlashEffect in IRM
Config.Flash = true

-- Config for Sound IRM
Config.Sound = true
Config.SoundVolume = 0.05
Config.SoundFile = "IRM.mp3"

-- Anim
Config.AnimDict = "anim@gangops@morgue@table@"
Config.AnimName = "body_search"