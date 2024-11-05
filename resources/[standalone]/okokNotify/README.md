Hi, thank you for buying my script, I'm very grateful!

If you need help contact me on discord: okok#3488
Discord server: https://discord.gg/okok/

# You should use an artifacts version above the version 5181:
	- Windows: https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
	- Linux: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/

--------------------

To display a notification you should call it like below:

# Client side

exports['okokNotify']:Alert("Title", "Message", Time, 'type')

# Server side

TriggerClientEvent('okokNotify:Alert', source, "Title", "Message", Time, 'type')

[Time] - 1000 = 1 second | 5000 = 5 seconds

Types: 
	- success (green)
	- info (blue)
	- warning (yellow)
	- error (red)
	- phone (orange)
	- neutral (grey)

-------------------------

# How to add new colors

Navigate to config.lua, an example can be found there.