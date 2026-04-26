menu_mode = "category";
category_index = 0;
action_index = 0;

categories = [];
array_push(categories, "Save");

if (obj_character.helmet)     array_push(categories, "Helmet");
if (obj_character.chestplate) array_push(categories, "Chestplate");
if (obj_character.greaves)    array_push(categories, "Greaves");
if (obj_character.gauntlets)  array_push(categories, "Gauntlets");
if (obj_character.sword)      array_push(categories, "Sword");
if (obj_character.shield)     array_push(categories, "Shield");

array_push(categories, "HP Potion");

actions = ["Upgrade", "Repair"];

stick_deadzone = 0.5;
stick_ready_y = true;
stick_ready_x = true;

message = "";
message_timer = 0;