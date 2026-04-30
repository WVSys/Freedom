function upgrade_item(item_name) {
    var coin_cost = get_upgrade_cost_coins(item_name);
    var rune_cost = get_upgrade_cost_runes(item_name);

    switch (item_name) {
        case "Helmet":
        case "Chestplate":
        case "Greaves":
        case "Gauntlets":
            if (global.coins < coin_cost) return false;
            if (obj_character.armor_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.armor_runes -= rune_cost;

            switch (item_name) {
                case "Helmet":
                    obj_character.helmet = true;
                    obj_character.helmet_level += 1;
                    break;

                case "Chestplate":
                    obj_character.chestplate = true;
                    obj_character.chestplate_level += 1;
                    break;

                case "Greaves":
                    obj_character.greaves = true;
                    obj_character.greaves_level += 1;
                    break;

                case "Gauntlets":
                    obj_character.gauntlets = true;
                    obj_character.gauntlets_level += 1;
                    break;
            }

            obj_character.refresh_equipment_stats(true);
            break;

        case "Sword":
            if (global.coins < coin_cost) return false;
            if (obj_character.sword_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.sword_runes -= rune_cost;

            obj_character.sword = true;
            obj_character.sword_level += 1;

            // Increases sword damage and durability max, then refills durability.
            obj_character.refresh_equipment_stats(true);
            break;

        case "Shield":
            if (global.coins < coin_cost) return false;
            if (obj_character.shield_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.shield_runes -= rune_cost;

            obj_character.shield = true;
            obj_character.shield_level += 1;

            // Increases guard meter max, guard regen, shield durability max, then refills.
            obj_character.refresh_equipment_stats(true);
            break;

        default:
            return false;
    }

    return true;
}