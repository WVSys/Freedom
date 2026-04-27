function upgrade_item(item_name)
{
    var coin_cost = get_upgrade_cost_coins(item_name);
    var rune_cost = get_upgrade_cost_runes(item_name);

    switch (item_name)
    {
        case "Helmet":
        case "Chestplate":
        case "Greaves":
        case "Gauntlets":
            if (global.coins < coin_cost) return false;
            if (obj_character.armor_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.armor_runes -= rune_cost;

            switch (item_name)
            {
                case "Helmet":
                    obj_character.helmet_level += 1;
                    obj_character.helmet_durability_max += 10;
                    obj_character.helmet_durability = obj_character.helmet_durability_max;
                break;

                case "Chestplate":
                    obj_character.chestplate_level += 1;
                    obj_character.chestplate_durability_max += 12;
                    obj_character.chestplate_durability = obj_character.chestplate_durability_max;
                break;

                case "Greaves":
                    obj_character.greaves_level += 1;
                    obj_character.greaves_durability_max += 9;
                    obj_character.greaves_durability = obj_character.greaves_durability_max;
                break;

                case "Gauntlets":
                    obj_character.gauntlets_level += 1;
                    obj_character.gauntlets_durability_max += 8;
                    obj_character.gauntlets_durability = obj_character.gauntlets_durability_max;
                break;
            }
        break;

        case "Sword":
            if (global.coins < coin_cost) return false;
            if (obj_character.sword_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.sword_runes -= rune_cost;
            obj_character.sword_level += 1;
            obj_character.sword_durability_max += 10;
            obj_character.sword_durability = obj_character.sword_durability_max;
        break;

        case "Shield":
            if (global.coins < coin_cost) return false;
            if (obj_character.shield_runes < rune_cost) return false;

            global.coins -= coin_cost;
            obj_character.shield_runes -= rune_cost;
            obj_character.shield_level += 1;
            obj_character.shield_durability_max += 10;
            obj_character.shield_durability = obj_character.shield_durability_max;
        break;

        default:
            return false;
    }

    return true;
}