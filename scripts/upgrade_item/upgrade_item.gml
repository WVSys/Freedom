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

            var was_owned = false;

            switch (item_name) {
                case "Helmet":
                    was_owned = obj_character.helmet;
                    obj_character.helmet = true;
                    obj_character.helmet_level += 1;
                    break;

                case "Chestplate":
                    was_owned = obj_character.chestplate;
                    obj_character.chestplate = true;
                    obj_character.chestplate_level += 1;
                    break;

                case "Greaves":
                    was_owned = obj_character.greaves;
                    obj_character.greaves = true;
                    obj_character.greaves_level += 1;
                    break;

                case "Gauntlets":
                    was_owned = obj_character.gauntlets;
                    obj_character.gauntlets = true;
                    obj_character.gauntlets_level += 1;
                    break;
            }
			
			// increases armor durability and defense
            obj_character.refresh_equipment_stats(false);

            if (!was_owned) {
                switch (item_name) {
                    case "Helmet":
                        obj_character.helmet_durability = obj_character.helmet_durability_max;
                        break;

                    case "Chestplate":
                        obj_character.chestplate_durability = obj_character.chestplate_durability_max;
                        break;

                    case "Greaves":
                        obj_character.greaves_durability = obj_character.greaves_durability_max;
                        break;

                    case "Gauntlets":
                        obj_character.gauntlets_durability = obj_character.gauntlets_durability_max;
                        break;
                }
            }

            break;

        case "Sword":
            if (global.coins < coin_cost) return false;
            if (obj_character.sword_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.sword_runes -= rune_cost;

            var was_owned = obj_character.sword;

            obj_character.sword = true;
            obj_character.sword_level += 1;

			// increases sword damage and durability max
            obj_character.refresh_equipment_stats(false);

            if (!was_owned) {
                obj_character.sword_durability = obj_character.sword_durability_max;
            }

            break;

        case "Shield":
            if (global.coins < coin_cost) return false;
            if (obj_character.shield_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.shield_runes -= rune_cost;

            var was_owned = obj_character.shield;

            obj_character.shield = true;
            obj_character.shield_level += 1;

			// increases guard meter max, guard regen and shield durability max
            obj_character.refresh_equipment_stats(false);

            if (!was_owned) {
                obj_character.shield_durability = obj_character.shield_durability_max;
            }

            break;

        default:
            return false;
    }

    return true;
}