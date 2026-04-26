function get_item_level(item_name){
	switch (item_name)
    {
        case "Helmet": return obj_character.helmet_level;
        case "Chestplate": return obj_character.chestplate_level;
        case "Greaves": return obj_character.greaves_level;
        case "Gauntlets": return obj_character.gauntlets_level;
        case "Sword": return obj_character.sword_level;
        case "Shield": return obj_character.shield_level;
    }

    return 0;

}