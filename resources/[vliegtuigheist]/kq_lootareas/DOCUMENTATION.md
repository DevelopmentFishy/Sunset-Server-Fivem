# KuzQuality Loot Areas
___
## No scripting experience?
> This documentation file is created for other developer. If you have low or no scripting experience
, please check out `HOW_TO_CREATE_JSON_AREA.md` instead

___
### General information
`kq_lootareas` is a script which enables simple creation of areas in which loot can be spawned.
Spawned loot is synchronized between players in a custom, reliable and very performant manner.
Before mentioned loot can be picked up by players.


___

## Creating loot areas

To create a new area, use the export functions provided with this resource.
In this case the function you'll want to call is called `CreateArea`

***CreateArea(areaKey, areaData)***

### Example
```lua
-- in this example case 'areaData' would be filled with all the data of the area you wish to create
exports['kq_lootareas']:CreateArea('my_area_key', areaData)
```

### Area key
As mentioned example the `CreateArea` takes an "AreaKey" as its first parameter.
This will be the key you will need to use to delete or update the area in the future.
Try keeping this unique as there can be only one area with the same key.
Creating an area with a key which already exists will overwrite it. (Old area will be deleted)
### Area data
Area data is everything the script needs to create a working loot area. All possible parameters are listed below.
___
- **name** Name of the loot area (visible in the blips)
- **renderDistance** Distance at which the 3d props will be rendered (from the edge of the area) (Higher values recommended for bigger props. Lower values for smaller props)
- **coords** A table containing x, y and z values of the center of the area (z should be the high point of the area)
- **radius** Radius in which the loot will spawn
- **amount** Amount of loot that will be spawned
- **event** Event that will be triggered when player picks up a loot (return parameters: player id, area key, prop key, prop object)
- **eventType** `server`/`client` side on which the event will be triggered on
- **regrowTime** Time it will take to regrow/respawn loot after one is picked up (in seconds) (items will respawn in a new random spot)
- **jobs** *(optional)* A table of jobs which are allowed to pickup the items (don't include this to let anyone pick items up)
- **blip** *(optional)* A table containing values listed below
  - **blipVisible** Whether or not to show the blip on the map
  - **areaVisible** Whether or not to display the area (radius) on the map
  - **icon** Blip icon id https://docs.fivem.net/docs/game-references/blips/
  - **color** Blip color id https://docs.fivem.net/docs/game-references/blips/
  - **scale** Scale of the blip
- **items** A table containing multiple tables containing values listed below
  - **item** Name of the item that will be given to the player after pickup
  - **chance** Chance of getting the item after picking it up
  - **amount** Table containing min and max amount values
- **props** Table containing all the information about the 3d props that will be shown as the loot
  - **hash** 3d model hash
  - **textureVariation** Texture variation of the model (view https://docs.fivem.net/natives/?_0x971DA0055324D033)
  - **chance** (optional) Chance of this prop spawning (compared to other props). Don't set this to keep equal odds of spawning for each prop type
  - **minimumDistanceBetween** The minimum distance between the objects in game
  - **offset** Offset that will be applied to the object (table containing x, y and z)
  - **rotation** Custom rotation that will be forced onto all the props (table containing x, y and z)
  - **upsideDown** Whether or not the prop should be upside down
  - **forceZCoordinate** Whether or not to force the Z coordinate to be as defined in the location (by default the script will put objects on the ground)
  - **items** (optional) A table containing multiple tables containing values listed below. If this is not defined on the prop level the global area items list will be used
    - **item** Name of the item that will be given to the player after pickup
    - **chance** Chance of getting the item after picking it up
    - **amount** Table containing min and max amount values
  - **animation** *(optional)* Table containing values regarding the animation which will be played while looting
    - **duration** Animation duration in seconds
    - **dict** Dict of the animation
    - **anim** Name of the animation
    - **flag** Animation flags
  - **tool** *(optional)* Table containing information about tool that is going to be spawned for the player such as a pickaxge etc.
    - **pos** table containing x, y and z offsets
    - **rot** table containing x, y and z rotations
    - **model** String model name of the tool
    - **bone** Player bone to which the tool will be attached
  - **labelSingular** Singular label of the item name
  - **labelPlurar** Plural label of the item name
  - **collectMessage** Message which will be displayed to collect the loot
  - **icon** *(optional)* Icon used in targeting systems
  - **glow** *(optional)* Table containing values about the items glow
    - **rgb** Table containing rgb values of the glow color e.g {255, 255, 255}
    - **scale** Glow scale
    - **intensity** Glow intensity
  - **requiredItems** *(optional)* Table containing information about item(s) that will be required to pick this loot up. If multiple items are given only one from the list will be required
    - **items** List of items that can be used to collect the item
    - **errorMessage** Message that will be shown to the player ("You don't have the required tool" e.g.)
    - **takeItem** Whether or not the item should be taken/consumed after collecting the loot
___

### Example
```lua
local newAreaExample = {
    name = 'Poppy field',
    renderDistance = 100.0,
    coords = {
      x = 1528.39, y = 4492.0, z = 54.73
    },
    radius = 14.0,
    amount = 13,
    regrowTime = 10,
    
    
    blip = {
      blipVisible = true,
      areaVisible = true,
      icon = 468,
      color = 61,
      scale = 0.9,
    },
    items = {
      {
        item = 'kq_poppy_seeds',
        chance = 90,
        amount = {
          min = 1,
          max = 2,
        },
      },
      {
        item = 'kq_pristine_poppy_seeds',
        chance = 10,
        amount = {
          min = 1,
          max = 2,
        },
      }
    },
    props = {
      {
        hash = 'prop_plant_fern_01b',
        textureVariation = 4,
        minimumDistanceBetween = 1.5,
        offset = {
          x = 0.0, y = 0.0, z = -0.3,
        },
        animation = {
          duration = 1,
          dict = 'mp_take_money_mg',
          anim = 'put_cash_into_bag_loop',
          flag = 1,
        },
        labelSingular = 'Poppy seed',
        labelPlurar = 'Poppy seeds',
        collectMessage = 'Collect poppy seeds',
        icon = 'fas fa-seedling',
        
        glow = {
          rgb = {190, 255, 190},
          scale = 1.75,
          intensity = 0.6,
        }
      }, 
    },
}

exports['kq_lootareas']:CreateArea('poppy_field', newAreaExample)
```

### Extra information
If you wish to create a loot area with items that will never respawn simply set the time to a value over 24 hours (86400 or higher).
By doing that the script will not add the items to the respawn pool slightly cutting the script resource usage.

To move an area you will need to delete it and create a new area at the new location.

If you wish to have multiple different items which are bound to a specific 3d model you'll need to create multiple loot areas.
___
## Deleting loot areas
To delete a loot area use the `DeleteArea` function. This function takes just one argument being the area key.

### Example
```lua
exports['kq_lootareas']:DeleteArea('poppy_field')
```

### Feature requests
If you're working on a script which implements `kq_lootareas` and you'd want something to be added feel free
to create a feature request on our [Discord](https://discord.gg/fZsyam7Rvz) in the ***#suggestions*** channel 
