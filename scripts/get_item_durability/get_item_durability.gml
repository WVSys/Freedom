function get_item_durability(item_name){
	switch (item_name)
    {
        case "Helmet": return obj_character.helmet_durability;
        case "Chestplate": return obj_character.chestplate_durability;
        case "Greaves": return obj_character.greaves_durability;
        case "Gauntlets": return obj_character.gauntlets_durability;
        case "Sword": return obj_character.sword_durability;
        case "Shield": return obj_character.shield_durability;
    }

    return 0;

}