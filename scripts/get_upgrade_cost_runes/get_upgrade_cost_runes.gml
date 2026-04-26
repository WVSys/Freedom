function get_upgrade_cost_runes(item_name){
	switch (item_name)
    {
        case "Helmet":
        case "Chestplate":
        case "Greaves":
        case "Gauntlets":
            return get_item_level(item_name) + 1;

        case "Sword":
            return obj_character.sword_level + 1;

        case "Shield":
            return obj_character.shield_level + 1;
    }

    return 0;

}