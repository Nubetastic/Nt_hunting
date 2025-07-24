# Advanced Hunting System for RSG Framework

An advanced hunting and animal skinning system for RedM/RSG servers with quality-based rewards.

## Dependencies
- Ox_lib
- RSG Core, NPC and Inventory

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
- Add images in imgs folder to [framework]\rsg-inventory\html
- Images used are from the icon library project for redm.
- https://the-icon-library-project-redm-webshop.tebex.io/category/2917878


-- Add these items below to [framework]\rsg-core\shared\items.lua


    -----------------------------------------------
    -- Hunting
    -----------------------------------------------

    h_medium_pelt       = { name = 'h_medium_pelt',       label = 'Medium Animal Pelt',     weight = 1500,  type = 'item', image = 'medium_pelt.png',                   unique = false, useable = false, description = 'A pelt from a medium-sized animal.' },
    h_large_pelt        = { name = 'h_large_pelt',        label = 'Large Animal Pelt',      weight = 3000,  type = 'item', image = 'large_pelt.png',                    unique = false, useable = false, description = 'A pelt from a large animal.' },
    h_small_pelt        = { name = 'h_small_pelt',        label = 'Small Animal Pelt',      weight = 800,   type = 'item', image = 'small_pelt.png',                    unique = false, useable = false, description = 'A pelt from a small animal.' },
    h_small_animal      = { name = 'h_small_animal',      label = 'Small Animal',           weight = 100,   type = 'item', image = 'small_animal.png',                  unique = false, useable = false, description = 'A small animal.' },
    h_feather           = { name = 'h_feather',           label = 'Bird Feather',           weight = 10,    type = 'item', image = 'feather.png',                       unique = false, useable = false, description = 'A feather from a bird.' },
    h_reptile_skin      = { name = 'h_reptile_skin',      label = 'Reptile Skin',           weight = 100,   type = 'item', image = 'reptile_skin.png',                  unique = false, useable = false, description = 'Skin from a reptile.' },
    h_turtle_shell      = { name = 'h_turtle_shell',      label = 'Turtle Shell',           weight = 100,   type = 'item', image = 'resource_shell_turtle.png',         unique = false, useable = false, description = 'A turtle shell.' },
    h_legendary_pelt    = { name = 'h_legendary_pelt',    label = 'Legendary Animal Pelt',  weight = 5000,  type = 'item', image = 'legendary_pelt.png',                unique = false, useable = false, description = 'A pelt from a legendary animal.' },
	h_wool              = { name = 'h_wool',              label = 'Wool',                   weight = 800,   type = 'item', image = 'wool.png',                          unique = false, useable = false, description = 'Wool.' },
    h_meat_game         = { name = 'h_meat_game',         label = 'Game Meat',              weight = 250,   type = 'item', image = 'consumable_meat_game.png',          unique = false, useable = false, description = 'Game Meat' },
    h_meat_big_game     = { name = 'h_meat_big_game',     label = 'Big Game Meat',          weight = 250,   type = 'item', image = 'consumable_meat_big_game.png',      unique = false, useable = false, description = 'Big Game Meat' },
    h_meat_small_game   = { name = 'h_meat_small_game',   label = 'Small Game Meat',        weight = 250,   type = 'item', image = 'consumable_meat_stringy.png',       unique = false, useable = false, description = 'Small Game Meat' },
    h_meat_bird         = { name = 'h_meat_bird',         label = 'Bird Meat',              weight = 250,   type = 'item', image = 'consumable_meat_plump_bird.png',    unique = false, useable = false, description = 'Bird Meat' },
    h_meat_reptile      = { name = 'h_meat_reptile',      label = 'Reptile Meat',           weight = 250,   type = 'item', image = 'consumable_meat_alligator.png',     unique = false, useable = false, description = 'Reptile Meat' },
    h_meat_legendary    = { name = 'h_meat_legendary',    label = 'Legendary Meat',         weight = 250,   type = 'item', image = 'consumable_meat_prime_beef.png',    unique = false, useable = false, description = 'Legendary Meat' },
    h_meat_mutton       = { name = 'h_meat_mutton',       label = 'Mutton',                 weight = 250,   type = 'item', image = 'consumable_meat_mutton.png',        unique = false, useable = false, description = 'Mutton Meat' },
    h_animal_fat        = { name = 'h_animal_fat',        label = 'Animal Fat',             weight = 250,   type = 'item', image = 'resource_animal_fat.png',           unique = false, useable = false, description = 'Animal Fat' },
    h_animal_heart      = { name = 'h_animal_heart',      label = 'Animal Heart',           weight = 250,   type = 'item', image = 'heart_grizzly.png',                 unique = false, useable = false, description = 'Animal heart from a large animal.' },
    h_animal_trophy     = { name = 'h_animal_trophy',     label = 'Animal Trophy',          weight = 250,   type = 'item', image = 'resource_animal_trophy.png',        unique = false, useable = false, description = 'Various trophies from animals.' },


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
	
	
	
-- Add this to [framework]\rsg-shops\Config.lua

-- Add to Products List

    ['butcher'] = {
        { name = 'h_small_pelt', amount = 0, buyPrice = string.format("%.2f", 1) },
        { name = 'h_medium_pelt', amount = 0, buyPrice = string.format("%.2f", 3) },
        { name = 'h_large_pelt', amount = 0, buyPrice = string.format("%.2f", 5) },
        { name = 'h_feather', amount = 0, buyPrice = string.format("%.2f", 0.1) },
        { name = 'h_reptile_skin', amount = 0, buyPrice = string.format("%.2f", 2) },
        { name = 'h_turtle_shell', amount = 0, buyPrice = string.format("%.2f", 3) },
        { name = 'h_legendary_pelt', amount = 0, buyPrice = string.format("%.2f", 100) },
        { name = 'h_wool', amount = 0, buyPrice = string.format("%.2f", 2) },
        { name = 'h_meat_reptile', amount = 0, buyPrice = string.format("%.2f", 1) },
        { name = 'h_meat_bird', amount = 0, buyPrice = string.format("%.2f", 1) },
        { name = 'h_meat_small_game', amount = 0, buyPrice = string.format("%.2f", 1.75) },
        { name = 'h_meat_game', amount = 0, buyPrice = string.format("%.2f", 2.50) },
        { name = 'h_meat_big_game', amount = 0, buyPrice = string.format("%.2f", 3) },
        { name = 'h_meat_mutton', amount = 0, buyPrice = string.format("%.2f", 4) },
        { name = 'h_animal_fat', amount = 0, buyPrice = string.format("%.2f", 2) },
        { name = 'h_animal_heart', amount = 0, buyPrice = string.format("%.2f", 2) },
        { name = 'h_animal_trophy', amount = 0, buyPrice = string.format("%.2f", 1) }
    },
	

# The string.format will prevent price display errors such as 1.3333333


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
### v1.1
- Added quality-based reward system
- Improved animal detection and skinning process
- Added automatic cleanup of skinned animals and pelts
- Standardized notifications using ox_lib
- Added proximity checks to ensure player stays near the animal
- Fixed various bugs and improved performance

### v1.0
- Initial release
	
