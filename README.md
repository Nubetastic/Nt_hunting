# Advanced Hunting System for RSG Framework

An advanced hunting and animal skinning system for RedM/RSG servers with quality-based rewards.

## Dependencies
- Ox_lib
- RSG Core, NPC and Inventory
Optional
    - rsg-Inventory Notify
        A custom made export to use the rsg inventory notification instead of ox_lib for receiving items.
        In config.lua set Config.InvNotify = true, to use it

## Features
- Automatic detection of skinning completion
- Multiple failsafe mechanisms to ensure rewards are always given
- Quality-based reward system (poor, good, perfect animals)
- Automatic cleanup of skinned animals and pelts
- Standardized notifications using ox_lib
- Proximity checks to ensure player stays near the animal

## How to use
1. Find and kill an animal
2. Approach the dead animal
3. Press E to initiate skinning
4. The system will automatically detect when skinning is complete
5. Rewards will be distributed based on animal type and quality
6. The animal body and pelts will be automatically removed

## Quality-Based Rewards
The system now detects animal quality and provides different amounts of meat and resources based on the quality:

- **Poor Quality (0)**: Minimum amount of meat and resources
- **Good Quality (1)**: Medium amount of meat and resources
- **Perfect Quality (2)**: Maximum amount of meat and resources
- **Legendary Quality (3)**: Premium amount of meat and resources

### Configuration Example
```lua
-- Example configuration for a Deer with quality-based meat rewards
[1110710183] = { 
    name = "Deer", 
    givenItem = { "h_medium_pelt", "h_meat_game", "h_animal_heart" }, 
    givenAmount = { 1, {1, 2, 3}, 1 } 
},
```

In this example:
- The pelt amount is always 1
- The meat amount varies based on quality: 1 for poor (0), 2 for good (1), 3 for perfect (2), 4 for legendary (3)
- The heart amount is always 1

Animal rewards are generic to reduce inventory space used and simplify it for the player.
All rewards and quantities can be modified in config.

## Setup Guide

### Installation
1. Add this resource to your server
2. Ensure the dependencies are installed
3. Add the following items and configurations to your framework

### Images
- Add images in imgs folder to [framework]\rsg-inventory\html\images
- Images used are from the icon library project for redm.
- https://the-icon-library-project-redm-webshop.tebex.io/category/2917878


-- Add items listed in Install\ItemTable.lua below to [framework]\rsg-core\shared\items.lua
All items have a h_ prefex to prevent conflict issues with existing items.

-- Add these locations to [framework]\rsg-npcs\Config.lua

    -- butchers
    {    -- butcher Valentine 
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-339.26, 767.7, 116.57, 103.16),
    },
    {    -- butcher Saint Denis
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2817.6848, -1323.25, 46.607814, 54.587085),
    },
    {    -- butcher Rhodes
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(1297.3735, -1277.661, 75.876304, 158.4201),
    },
    {    -- butcher Annesburg
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2934.1706, 1301.2891, 44.483638, 78.346809),
    },
    {    -- butcher Tumbleweed
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-5509.831, -2947.271, -1.89185, 256.48596),
    },
    {    -- butcher Blackwater
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-753.0086, -1284.84, 43.470008, 267.18395),
    },
    {    -- butcher Strawberry
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(-1753.137, -392.8364, 156.24348, 189.32403),
    },
    {    -- butcher Van Horn
        model = `U_M_M_VALBUTCHER_01`,
        coords = vector4(2992.4711, 572.20001, 44.365322, 263.94104),
    },
	
	
	
-- Add Install\Shop.lua to [framework]\rsg-shops\Config.lua
	It allows players to sell items like they would to any other rsg shop. No items can be purchased.

The string.format will prevent price display errors such as 1.3333333


-- Add to StoreLocations List
	
    ---------------------------------
    -- butcher
    ---------------------------------
    {
        label = 'Valentine Butcher',
        name = 'butcher-valentine',
        products = 'butcher',
        shopcoords = vector3(-341.05, 767.33, 116.70),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'St Denis Butcher',
        name = 'butcher-stdenis',
        products = 'butcher',
        shopcoords = vector3(2816.37, -1322.24, 46.61),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Rhodes Butcher',
        name = 'butcher-rhodes',
        products = 'butcher',
        shopcoords = vector3(1296.36, -1279.26, 75.84),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Annesburg Butcher',
        name = 'butcher-annesburg',
        products = 'butcher',
        shopcoords = vector3(2932.49, 1301.95, 44.48),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Tumbleweed Butcher',
        name = 'butcher-tumbleweed',
        products = 'butcher',
        shopcoords = vector3(-5508.10, -2947.73, -1.87),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Blackwater Butcher',
        name = 'butcher-blackwater',
        products = 'butcher',
        shopcoords = vector3(-751.102, -1284.896, 43.276576),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Strawberry Butcher',
        name = 'butcher-strawberry',
        products = 'butcher',
        shopcoords = vector3(-1752.91, -394.74, 156.19),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },
    {
        label = 'Van Horn Butcher',
        name = 'butcher-vanhorn',
        products = 'butcher',
        shopcoords = vector3(2994.23, 571.79, 44.35),
        blipsprite = 'blip_shop_butcher',
        blipscale = 0.2,
        showblip = true,
        persistentStock = false,
    },

	
	
	
## Special Thanks
- List of animals is from Vorp Hunting, so thank you to the Vorpcore team.
- Original script by Nubetastic
- Quality-based reward system enhancement added in v1.1

## Changelog
## v1.0.2
- Added several more animal parts while keeping the total to a minimum.

### v1.0.1
- Added quality-based reward system
- Improved animal detection and skinning process
- Added automatic cleanup of skinned animals and pelts
- Standardized notifications using ox_lib
- Added proximity checks to ensure player stays near the animal
- Fixed various bugs and improved performance

### v1.0
- Initial release
	
