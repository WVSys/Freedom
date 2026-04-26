function repair_item(item_name)
{
    var current_dur = get_item_durability(item_name);
    var max_dur = get_item_max_durability(item_name);

    if (current_dur >= max_dur) return false;

    var cost = get_repair_cost(item_name);
    if (global.coins < cost) return false;

    global.coins -= cost;

    switch (item_name)
    {
        case "Helmet": obj_character.helmet_durability = obj_character.helmet_durability_max; break;
        case "Chestplate": obj_character.chestplate_durability = obj_character.chestplate_durability_max; break;
        case "Greaves": obj_character.greaves_durability = obj_character.greaves_durability_max; break;
        case "Gauntlets": obj_character.gauntlets_durability = obj_character.gauntlets_durability_max; break;
        case "Sword": obj_character.sword_durability = obj_character.sword_durability_max; break;
        case "Shield": obj_character.shield_durability = obj_character.shield_durability_max; break;
        default: return false;
    }

    return true;
}