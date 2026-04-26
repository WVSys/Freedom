function get_item_max_durability(item_name){
	switch (item_name)
    {
        case "Helmet": return obj_character.helmet_durability_max;
        case "Chestplate": return obj_character.chestplate_durability_max;
        case "Greaves": return obj_character.greaves_durability_max;
        case "Gauntlets": return obj_character.gauntlets_durability_max;
        case "Sword": return obj_character.sword_durability_max;
        case "Shield": return obj_character.shield_durability_max;
    }

    return 0;

}