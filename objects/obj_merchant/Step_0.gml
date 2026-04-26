can_interact = false;

/*if (instance_exists(obj_character))
{
    if (point_distance(x, y, obj_character.x, obj_character.y) < 40)
    {
        can_interact = true;

        if (keyboard_check_pressed(ord("E")))
        {
            global.saved_hp = obj_character.hp;
            global.saved_guard = obj_character.guard_meter;
            global.saved_helmet = obj_character.helmet;
            global.saved_chestplate = obj_character.chestplate;
            global.saved_gaunlets = obj_character.gauntlets;
            global.saved_greaves = obj_character.greaves;
            global.saved_coins = obj_character.coins;
            global.saved_armor_runes = obj_character.armor_runes;
            global.saved_shield_runes = obj_character.shield_runes;
            global.saved_sword_runes = obj_character.sword_runes;

            save_checkpoint();

            saved_message_timer = room_speed * 2;
        }
    }
}
if (instance_exists(obj_character))
{
    if (point_distance(x, y, obj_character.x, obj_character.y) < 40)
    {
        if (keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_face2))
        {
            global.merchant_menu_open = true;

            if (!instance_exists(obj_merchant_menu))
            {
                instance_create_layer(0, 0, "Instances", obj_merchant_menu);
            }
        }
    }
}

if (saved_message_timer > 0)
{
    saved_message_timer--;
}*/