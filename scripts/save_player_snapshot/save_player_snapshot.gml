function save_player_snapshot()
{
    global.saved_hp = obj_character.hp;
    global.saved_guard = obj_character.guard_meter;

    global.saved_helmet = obj_character.helmet;
    global.saved_chestplate = obj_character.chestplate;
    global.saved_greaves = obj_character.greaves;
    global.saved_gauntlets = obj_character.gauntlets;
    global.saved_sword = obj_character.sword;
    global.saved_shield = obj_character.shield;

    global.saved_helmet_level = obj_character.helmet_level;
    global.saved_chestplate_level = obj_character.chestplate_level;
    global.saved_greaves_level = obj_character.greaves_level;
    global.saved_gauntlets_level = obj_character.gauntlets_level;
    global.saved_sword_level = obj_character.sword_level;
    global.saved_shield_level = obj_character.shield_level;

    global.saved_helmet_durability = obj_character.helmet_durability;
    global.saved_chestplate_durability = obj_character.chestplate_durability;
    global.saved_greaves_durability = obj_character.greaves_durability;
    global.saved_gauntlets_durability = obj_character.gauntlets_durability;
    global.saved_sword_durability = obj_character.sword_durability;
    global.saved_shield_durability = obj_character.shield_durability;

    global.saved_helmet_durability_max = obj_character.helmet_durability_max;
    global.saved_chestplate_durability_max = obj_character.chestplate_durability_max;
    global.saved_greaves_durability_max = obj_character.greaves_durability_max;
    global.saved_gauntlets_durability_max = obj_character.gauntlets_durability_max;
    global.saved_sword_durability_max = obj_character.sword_durability_max;
    global.saved_shield_durability_max = obj_character.shield_durability_max;

    global.saved_coins = global.coins;
    global.saved_armor_runes = obj_character.armor_runes;
    global.saved_shield_runes = obj_character.shield_runes;
    global.saved_sword_runes = obj_character.sword_runes;
    global.saved_hp_potions = obj_character.hp_potions;
	
	global.saved_intro_merchant_seen = global.intro_merchant_seen;

    save_checkpoint();
}