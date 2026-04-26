function save_checkpoint()
{
    var save_data = {
        saved_hp : global.saved_hp,
        saved_guard : global.saved_guard,

        saved_helmet : global.saved_helmet,
        saved_chestplate : global.saved_chestplate,
        saved_greaves : global.saved_greaves,
        saved_gauntlets : global.saved_gauntlets,
        saved_sword : global.saved_sword,
        saved_shield : global.saved_shield,

        saved_helmet_level : global.saved_helmet_level,
        saved_chestplate_level : global.saved_chestplate_level,
        saved_greaves_level : global.saved_greaves_level,
        saved_gauntlets_level : global.saved_gauntlets_level,
        saved_sword_level : global.saved_sword_level,
        saved_shield_level : global.saved_shield_level,

        saved_helmet_durability : global.saved_helmet_durability,
        saved_chestplate_durability : global.saved_chestplate_durability,
        saved_greaves_durability : global.saved_greaves_durability,
        saved_gauntlets_durability : global.saved_gauntlets_durability,
        saved_sword_durability : global.saved_sword_durability,
        saved_shield_durability : global.saved_shield_durability,

        saved_helmet_durability_max : global.saved_helmet_durability_max,
        saved_chestplate_durability_max : global.saved_chestplate_durability_max,
        saved_greaves_durability_max : global.saved_greaves_durability_max,
        saved_gauntlets_durability_max : global.saved_gauntlets_durability_max,
        saved_sword_durability_max : global.saved_sword_durability_max,
        saved_shield_durability_max : global.saved_shield_durability_max,

        saved_coins : global.saved_coins,
        saved_armor_runes : global.saved_armor_runes,
        saved_shield_runes : global.saved_shield_runes,
        saved_sword_runes : global.saved_sword_runes,
        saved_hp_potions : global.saved_hp_potions
    };

    var json = json_stringify(save_data);

    var file = file_text_open_write("save.json");
    file_text_write_string(file, json);
    file_text_close(file);

    show_debug_message("Checkpoint saved. Coins: " + string(global.saved_coins));

    return true;
}