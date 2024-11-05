# JSON Areas

JSON Areas tool has been created to make creating new loot areas much easier. No coding knowledge needed.
___
### What are JSON areas?
JSON Areas are loot areas loaded via configs made via our [online tool](https://kuzquality.com/lootareas-generator). 
These work exactly the same as normal programmatically created loot areas. They're just loaded in in a different, simpler way.

___
### How to create a new JSON area?
1. Head over to https://kuzquality.com/lootareas-generator
2. Fill all the values. The form has no forced validation so make sure to fill in each field which is marked as required (*)
3. Download the area JSON file.
4. Drag and drop it into the `json_areas` folder within the `kq_lootareas` resource
5. Add the JSON area file name to the `kq_lootareas` config file under the `jsonAreas` section
6. Execute the `refresh` command followed by `ensure kq_lootareas`, or restart your server
7. Test out your new loot area

___
Make sure to join our Discord: https://discord.gg/fZsyam7Rvz
