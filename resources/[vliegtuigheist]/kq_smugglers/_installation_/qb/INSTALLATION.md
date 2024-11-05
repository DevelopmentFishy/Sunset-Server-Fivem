## KQ_SMUGGLERS INSTALLATION GUIDE [QB]

This guide will provide step-by-step instructions on how to install and set up the KQ_SMUGGLERS script for FiveM. This script requires the QBCore framework to be installed and running on your server.

## Step 0:
Before installing KQ_SMUGGLERS, make sure that the `kq_lootareas` script is already installed and started on your server. You can download and install `kq_lootareas` from https://kuzquality.com/package/5355106.

## Step 1:
After downloading the KQ_SMUGGLERS script, unzip the folder and place it in the `resources` directory on your FiveM server.

## Step 2:
Add the items to your qb-core shared.lua file `qb-core/shared/items.lua` or `qb-core/shared.lua`

## Step 3:
Open the `config.lua` file in the KQ_SMUGGLERS script folder and make sure that the correct framework is enabled.

## Step 4:
After the config file has been set up, add the KQ_SMUGGLERS script to your `server.cfg` file. Make sure that it's added **after** the ESX framework, so that it loads and starts properly.

## Step 5:
⚠ Make sure that any script isn't preventing the plane nor pilot from spawning. Anti-cheats or qb-smallresources often have the `shamal` plane blacklisted!

- plane model = 'shamal'
- plane object model = 'ex_prop_exec_crashedp'
- pilot model = 's_m_m_pilot_01'
- cartel model = 'g_m_m_armlieut_01'

## Done
Enjoy the script


https://kuzquality.com/

## Extra info

You may want to rename some of the items or use existing items. You can easily change all the items in the `config.lua` file
