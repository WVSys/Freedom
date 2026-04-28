global.debug = false;
global.next_spawn = -1;

global.coins = 1000;

global.merchant_menu_open = false;
global.respawn_from_checkpoint = false;

global.saved_hp = 100;
global.saved_guard = 15;

global.saved_helmet = false;
global.saved_chestplate = false;
global.saved_greaves = false;
global.saved_gauntlets = false;
global.saved_sword = false;
global.saved_shield = false;

global.saved_helmet_level = 0;
global.saved_chestplate_level = 0;
global.saved_greaves_level = 0;
global.saved_gauntlets_level = 0;
global.saved_sword_level = 0;
global.saved_shield_level = 0;

global.saved_helmet_durability = 0;
global.saved_chestplate_durability = 0;
global.saved_greaves_durability = 0;
global.saved_gauntlets_durability = 0;
global.saved_sword_durability = 0;
global.saved_shield_durability = 0;

global.saved_helmet_durability_max = 0;
global.saved_chestplate_durability_max = 0;
global.saved_greaves_durability_max = 0;
global.saved_gauntlets_durability_max = 0;
global.saved_sword_durability_max = 0;
global.saved_shield_durability_max = 0;

global.saved_coins = 0;
global.saved_armor_runes = 0;
global.saved_shield_runes = 0;
global.saved_sword_runes = 0;
global.saved_hp_potions = 0;

global.load_save = false;

global.respawn_from_checkpoint = false;

load_checkpoint();

save_file = "save.json";

start_focused = true;
continue_focused = false;

continue_available = false;

start_pressed = false;

global.game_paused = false;
global.tutorial_pause = false;

pause_index = 0;

pause_options = [
    "Resume",
    "Restart from Checkpoint",
    "Quit to Title"
];