Config = {}

Config.InvNotify = true -- inventory notify

Config.SkinDistance = 3
Config.Timeout = 60 * 1000 -- 60 seconds

Config.AnimalList = {

    -- Reptile Meat
    [-407730502]  = { name = "Snapping Turtle", givenItem = { "h_turtle_shell", "h_meat_reptile" }, givenAmount = { 1, {2, 2, 3} } },
    [-22968827]   = { name = "Water Snake", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [-229688157]  = { name = "CottonMouth Water Snake", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [-1790499186] = { name = "Snake Red Boa", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [1464167925]  = { name = "Snake Fer-De-Lance", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [846659001]   = { name = "Black-Tailed Rattlesnake", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [545068538]   = { name = "Western Rattlesnake", givenItem = { "h_snake_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [-1854059305] = { name = "Green Iguana", givenItem = { "h_skin_iguana", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [-593056309]  = { name = "Desert Iguana", givenItem = { "h_skin_iguana", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [-1892280447] = { name = "Alligator Small", givenItem = { "h_skin_alligator", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2}  } },
    [-2004866590] = { name = "Alligator", givenItem = { "h_skin_alligator", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2}  } },
    [-1295720802] = { name = "Northern American Alligator", givenItem = { "h_skin_alligator", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },
    [45741642]    = { name = "Gila Monster", givenItem = { "h_reptile_skin", "h_meat_reptile" }, givenAmount = { 1, {1, 1, 2} } },


    -- Small Game Meat
    [-1797625440] = { name = "Armadillo", givenItem = { "h_skin_armadillo", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-1170118274] = { name = "American Badger", givenItem = { "h_pelt_badger", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-1134449699] = { name = "American Muskrat", givenItem = { "h_pelt_muskrat", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [1458540991]  = { name = "North American Racoon", givenItem = { "h_pelt_raccoon", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-541762431]  = { name = "Black-Tailed Jackrabbit", givenItem = { "h_pelt_rabbit", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-1414989025] = { name = "Virginia Possum", givenItem = { "h_pelt_opossum", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-121266332]  = { name = "Striped Skunk", givenItem = { "h_pelt_skunk", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [-1211566332] = { name = "Striped Skunk", givenItem = { "h_pelt_skunk", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },
    [759906147]   = { name = "North American Beaver", givenItem = { "h_pelt_beaver", "h_meat_small_game" }, givenAmount = { 1, {1, 1, 2} } },

    -- Medium Game Meat
    [1755643085]  = { name = "American Pronghorn Doe", givenItem = { "h_skin_pronghorn", "h_meat_game", "h_animal_heart" }, givenAmount = { 1, {2, 2, 3}, 1 } },
    [-1568716381] = { name = "Big Horn Ram", givenItem = { "h_skin_ram", "h_meat_game", "h_animal_heart", "h_horn_animal" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [-1963605336] = { name = "Buck", givenItem = { "h_skin_buck", "h_meat_game", "h_animal_heart", "h_antler_buck" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [252669332]   = { name = "American Red Fox", givenItem = { "h_pelt_fox", "h_meat_game", "h_animal_heart" }, givenAmount = { 1, {2, 2, 3}, 1 } },
    [-1143398950] = { name = "Big Grey Wolf", givenItem = { "h_pelt_wolf", "h_meat_game", "h_animal_heart", "h_claw_animal" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [-885451903]  = { name = "Medium Grey Wolf", givenItem = { "h_pelt_wolf", "h_meat_game", "h_animal_heart", "h_claw_animal" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [-829273561]  = { name = "Small Grey Wolf", givenItem = { "h_pelt_wolf", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, {2, 2, 3}, {1, 1, 2} } },
    [480688259]   = { name = "Coyote", givenItem = { "h_pelt_coyote", "h_meat_game", "h_animal_heart" }, givenAmount = { 1, {2, 2, 3}, 1 } },
    [1654513481]  = { name = "Panther", givenItem = { "h_skin_panther", "h_meat_game", "h_animal_heart", "h_claw_animal" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [-753902995]  = { name = "Alpine Goat", givenItem = { "h_skin_goat", "h_meat_game", "h_animal_heart" }, givenAmount = { 1, {2, 2, 3}, 1 } },
    [1007418994]  = { name = "Berkshire Pig", givenItem = { "h_skin_pig", "h_meat_game", "h_animal_heart", "h_animal_fat" }, givenAmount = { 1, {2, 2, 3}, 1, {2, 3, 4},  } },
    [1751700893]  = { name = "Peccary Pig", givenItem = { "h_skin_pig", "h_meat_game", "h_animal_heart", "h_animal_fat" }, givenAmount = { 1, {2, 2, 3}, 1, {2, 3, 4},   } },
    [556355544]   = { name = "Angus Ox", givenItem = { "h_hide_cow", "h_meat_big_game", "h_animal_heart" }, givenAmount = { 1, {2, 2, 3}, 1 } },
    [1110710183]  = { name = "Whitetail Deer", givenItem = { "h_skin_deer", "h_meat_game", "h_animal_heart", "h_antler_buck" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [2028722809]  = { name = "Boar", givenItem = { "h_skin_javelina_boar", "h_meat_game", "h_animal_heart", "h_animal_fat", "h_tusk_boar"}, givenAmount = { 1, {2, 2, 3}, 1, {2, 3, 4}, {1, 1, 2},  } },


    -- Large Game Meat
    [-1124266369] = { name = "Bear", givenItem = { "h_skin_bear", "h_meat_big_game", "h_animal_heart", "h_claw_animal" }, givenAmount = { 1, {4, 4, 6}, 1, {1, 1, 2} } },
    [1556473961]  = { name = "Bison", givenItem = { "h_skin_buffalo", "h_meat_big_game", "h_animal_heart", "h_horn_animal" }, givenAmount = { 1, {4, 4, 6}, 1, {1, 1, 2} } },
    [367637652]   = { name = "Bison", givenItem = { "h_skin_buffalo", "h_meat_big_game", "h_animal_heart", "h_horn_animal" }, givenAmount = { 1, {4, 4, 6}, 1, {1, 1, 2} } },
    [1957001316]  = { name = "Bull", givenItem = { "h_hide_cow", "h_meat_big_game", "h_animal_heart", "h_horn_animal" }, givenAmount = { 1, {5, 5, 5}, 1, {1, 1, 2} } },
    [-1098441944] = { name = "Moose", givenItem = { "h_skin_moose", "h_meat_big_game", "h_animal_heart", "h_antler_moose" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },
    [90264823]    = { name = "Cougar", givenItem = { "h_skin_cougar", "h_meat_big_game", "h_animal_heart", "h_claw_animal" }, givenAmount = { 1, {2, 3, 5}, 1, {1, 1, 2} } },
    [-50684386]   = { name = "Florida Cracker Cow", givenItem = { "h_hide_cow", "h_meat_big_game", "h_animal_heart" }, givenAmount = { 1, {2, 3, 5}, 1 } },
    [-2021043433] = { name = "Elk", givenItem = { "h_skin_elk", "h_meat_big_game", "h_animal_heart", "h_antler_elk" }, givenAmount = { 1, {2, 2, 3}, 1, {1, 1, 2} } },

    -- Bird
    [-1003616053] = { name = "Duck", givenItem = { "h_feather", "h_meat_bird", "h_animal_fat" }, givenAmount = { {1, 2, 3}, 1, {1, 1, 2} } },
    [1459778951]  = { name = "Eagle", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [831859211]   = { name = "Egret", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1} },
    [1104697660]  = { name = "Vulture", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-466054788]  = { name = "Wild Turkey", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 2 } },
    [-2011226991] = { name = "Wild Turkey", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 2 } },
    [-166054593]  = { name = "Wild Turkey", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 2 } },
    [-164963696]  = { name = "Herring Seagull", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-1076508705] = { name = "Roseate Spoonbill", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [2023522846]  = { name = "Dominique Rooster", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 2 } },
    [-466687768]  = { name = "Red-Footed Booby", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-575340245]  = { name = "Wester Raven", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [2079703102]  = { name = "Greater Prairie Chicken", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [1416324601]  = { name = "Ring-Necked Pheasant", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [1265966684]  = { name = "American White Pelican", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-1797450568] = { name = "Blue And Yellow Macaw", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [120598262]   = { name = "Californian Condor", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-2063183075] = { name = "Dominique Chicken", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [-2073130256] = { name = "Double-Crested Cormorant", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [1095117488] = { name = "Heron", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 1, 2}, 1 } },
    [-564099192] = { name = "Whooping Crane", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 1, 2}, 1 } },
    [1746830155]  = { name = "Parakeet", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [723190474] = { name = "Canadian Goose", givenItem = { "h_feather", "h_meat_bird", "h_animal_fat" }, givenAmount = { {1, 2, 3}, 2, {1, 2, 3} } },
    [-2145890973]  = { name = "Hawk", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [386506078] = { name = "Loon", givenItem = { "h_feather", "h_meat_bird", "h_animal_fat" }, givenAmount = { {1, 2, 3}, 1, {1, 1, 2} } },
    [-861544272]  = { name = "Owl", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },
    [2105463796]  = { name = "Quail", givenItem = { "h_feather", "h_meat_bird" }, givenAmount = { {1, 2, 3}, 1 } },


    -- Other
    [40345436]    = { name = "Merino Sheep", givenItem = { "h_wool", "h_meat_mutton", "h_animal_heart" }, givenAmount = { {1, 1, 2}, {2, 2, 3}, 1 } },


    -- Small Animals
    [989669666]   = { name = "Rat", givenItem = { "h_small_animal" }, givenAmount = { 1 } },
    [-1550768676] = { name = "Chipmunk", givenItem = { "chipmunk_c" }, givenAmount = { 1 } },
    [1582986780] = { name = "Blue Jay", givenItem = { "bluejay_c" }, givenAmount = { 1 } },
    [1784941179] = { name = "Cardinal", givenItem = { "cardinal_c" }, givenAmount = { 1 } },
    [-292997097] = { name = "Cedar waxwing", givenItem = { "cedarwaxwing_c" }, givenAmount = { 1 } },
    [-2037578922] = { name = "Cuban Crab", givenItem = { "crab_c" }, givenAmount = { 1 } },
    [-1763055991] = { name = "Crawfish", givenItem = { "crawfish_c" }, givenAmount = { 1 } },
    [98537260] = { name = "Crow", givenItem = { "crow_c" }, givenAmount = { 1 } },
    [-930822792] = { name = "Bull Frog", givenItem = { "frogbull_c" }, givenAmount = { 1 } },
    [-1302821723] = { name = "Hooded Oriole", givenItem = { "oriole_c" }, givenAmount = { 1 } },
    [111281960] = { name = "Pigeon", givenItem = { "pigeon_c" }, givenAmount = { 1 } },
    [674267496] = { name = "Bat", givenItem = { "bat_c" }, givenAmount = { 1 } },
    [-1210546580] = { name = "Robin", givenItem = { "robin_c" }, givenAmount = { 1 } },
    [-1910795227] = { name = "Songbird", givenItem = { "songbird_c" }, givenAmount = { 1 } },
    [-1028170431] = { name = "Sparrow", givenItem = { "sparrow1_c" }, givenAmount = { 1 } },
    [1502581273] = { name = "Toad", givenItem = { "toad_c" }, givenAmount = { 1 } },
    [510312109] = { name = "Red-bellied Woodpecker", givenItem = { "woodpeck01_c" }, givenAmount = { 1 } },
    [729471181] = { name = "Pileate Woodpecker", givenItem = { "woodpeck02_c" }, givenAmount = { 1 } },
    [1465438313] = { name = "Grey Squirrel", givenItem = { "squirrel_grey_c" }, givenAmount = { 1 } },

    -- Legendary Animals
    [674287411] = { name = "Legendary Gator", givenItem = { "h_skin_alligator_legendary", "h_meat_reptile" }, givenAmount = { 1, 8, 1 } },
    [-511163808] = { name = "Legendary Ram", givenItem = { "h_skin_ram_legendary", "h_meat_game", "h_horn_animal" }, givenAmount = { 1, 6, 1 } },
    [-389300196] = { name = "Legendary Boar", givenItem = { "h_skin_javelina_boar_legendary", "h_meat_big_game", "h_tusk_boar" }, givenAmount = { 1, 7, 1 } },
    [-557149691] = { name = "Legendary Fox", givenItem = { "h_pelt_fox_legendary", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    [-1392359921] = { name = "Legendary Wolf", givenItem = { "h_pelt_wolf_legendary", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    [-781967776] = { name = "Legendary Elk", givenItem = { "h_skin_elk_legendary", "h_meat_big_game", "h_antler_elk" }, givenAmount = { 1, 8, 1 } },
    [-1433814131] = { name = "Legendary Cougar", givenItem = { "h_skin_cougar_legendary", "h_meat_big_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    [-1307757043] = { name = "Legendary Coyote", givenItem = { "h_pelt_coyote_legendary", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    [-1754211037] = { name = "Legendary Buck", givenItem = { "h_skin_buck_legendary", "h_meat_game", "h_antler_buck" }, givenAmount = { 1, 6, 1 } },
    [-1149999295] = { name = "Legendary Beaver", givenItem = { "h_pelt_beaver_legendary", "h_meat_small_game" }, givenAmount = { 1, 5 } },
    [-915290938] = { name = "Legendary Bison", givenItem = { "h_skin_buffalo_legendary", "h_meat_big_game", "h_horn_animal" }, givenAmount = { 1, 8, 1 } },
    [-1189368951] = { name = "Legendary Panther", givenItem = { "h_skin_panther_legendary", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    -- Need to add animals to other script
    [-551216071] = { name = "Legendary Bear", givenItem = { "h_skin_bear_grizzly_legendary", "h_meat_game", "h_claw_animal" }, givenAmount = { 1, 6, 1 } },
    [-117665949] = { name = "Legendary Moose", givenItem = { "h_skin_moose_legendary", "h_meat_game", "h_antler_moose" }, givenAmount = { 1, 6, 1 } },

}

