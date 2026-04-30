global.debug = false;
global.next_spawn = -1;

global.coins = 0;

global.merchant_menu_open = false;
global.respawn_from_checkpoint = false;

global.saved_hp = 100;
global.saved_guard = 15;

global.saved_helmet = false;
global.saved_chestplate = false;
global.saved_greaves = false;
global.saved_gauntlets = false;
global.saved_sword = true;
global.saved_shield = true;

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

global.saved_intro_merchant_seen = false;

global.load_save = false;

global.respawn_from_checkpoint = false;

stick_deadzone = 0.35;
stick_ready_y = true;

load_checkpoint();

save_file = "save.json";

start_focused = true;
continue_focused = false;

continue_available = false;

start_pressed = false;

global.game_paused = false;
global.tutorial_pause = false;

if (!variable_global_exists("dialogue_active"))
{
    global.dialogue_active = false;
}

if (!variable_global_exists("intro_merchant_seen"))
{
    global.intro_merchant_seen = false;
}

pause_index = 0;

pause_options = [
    "Resume",
    "Restart from Checkpoint",
    "Quit to Title"
];

// controller debug position
debug_controller_move = false;

controller_offset_x = -400;
controller_offset_y = -25;
controller_scale_x = 0.20133;
controller_scale_y = 0.20685;

debug_callout_move = false;
debug_callout_index = 0;

callout_label_x = [
    210,  // Attack
    50,     // Potion
    38,   // Block
    186,   // Confirm
    275,   // Jump
    -40,  // Move
    129,  // Look Up
    147     // Pause
];
callout_label_y = [
    -80,  // Attack
    247,  // Potion
    -44,  // Block
    237,     // Confirm
    205,    // Jump
    161,    // Move
    212,  // Look Up
    -12    // Pause
];

callout_target_x = [
    177,    // Attack
    91,    // Potion
    57,   // Block
    193,    // Confirm
    196,    // Jump
    62,  // Move
    158,  // Look Up
    150      // Pause
];

callout_target_y = [
    85,   // Attack
    115,  // Potion
    45,   // Block
    106,   // Confirm
    106,   // Jump
    82,   // Move
    126,   // Look Up
    85    // Pause
];

callout_names = ["Attack", "Potion", "Block", "Confirm","Jump","Move","Look Up","Pause"];
