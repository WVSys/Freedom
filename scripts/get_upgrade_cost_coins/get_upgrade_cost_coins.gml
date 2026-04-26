function get_upgrade_cost_coins(item_name){
	switch (item_name)
    {
        case "Helmet": return (obj_character.helmet_level + 1) * 50;
        case "Chestplate": return (obj_character.chestplate_level + 1) * 60;
        case "Greaves": return (obj_character.greaves_level + 1) * 55;
        case "Gauntlets": return (obj_character.gauntlets_level + 1) * 50;
        case "Sword": return (obj_character.sword_level + 1) * 75;
        case "Shield": return (obj_character.shield_level + 1) * 70;
    }

    return 0;

}