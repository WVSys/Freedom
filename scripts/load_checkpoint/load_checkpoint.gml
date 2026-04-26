function load_checkpoint()
{
    if (!file_exists("save.json"))
    {
        show_debug_message("No save.json found");
        return false;
    }

    var file = file_text_open_read("save.json");
    var json = "";

    while (!file_text_eof(file))
    {
        json += file_text_readln(file);
    }

    file_text_close(file);

    var save_data = json_parse(json);

    global.saved_hp = save_data.saved_hp;
    global.saved_guard = save_data.saved_guard;

    global.saved_helmet = save_data.saved_helmet;
    global.saved_chestplate = save_data.saved_chestplate;
    global.saved_greaves = save_data.saved_greaves;
    global.saved_gauntlets = save_data.saved_gauntlets;
    global.saved_sword = save_data.saved_sword;
    global.saved_shield = save_data.saved_shield;

    global.saved_helmet_level = save_data.saved_helmet_level;
    global.saved_chestplate_level = save_data.saved_chestplate_level;
    global.saved_greaves_level = save_data.saved_greaves_level;
    global.saved_gauntlets_level = save_data.saved_gauntlets_level;
    global.saved_sword_level = save_data.saved_sword_level;
    global.saved_shield_level = save_data.saved_shield_level;

    global.saved_helmet_durability = save_data.saved_helmet_durability;
    global.saved_chestplate_durability = save_data.saved_chestplate_durability;
    global.saved_greaves_durability = save_data.saved_greaves_durability;
    global.saved_gauntlets_durability = save_data.saved_gauntlets_durability;
    global.saved_sword_durability = save_data.saved_sword_durability;
    global.saved_shield_durability = save_data.saved_shield_durability;

    global.saved_helmet_durability_max = save_data.saved_helmet_durability_max;
    global.saved_chestplate_durability_max = save_data.saved_chestplate_durability_max;
    global.saved_greaves_durability_max = save_data.saved_greaves_durability_max;
    global.saved_gauntlets_durability_max = save_data.saved_gauntlets_durability_max;
    global.saved_sword_durability_max = save_data.saved_sword_durability_max;
    global.saved_shield_durability_max = save_data.saved_shield_durability_max;

    global.saved_coins = save_data.saved_coins;
    global.saved_armor_runes = save_data.saved_armor_runes;
    global.saved_shield_runes = save_data.saved_shield_runes;
    global.saved_sword_runes = save_data.saved_sword_runes;
    global.saved_hp_potions = save_data.saved_hp_potions;

    show_debug_message("Checkpoint loaded. Coins: " + string(global.saved_coins));

    return true;
}