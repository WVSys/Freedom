if (!global.merchant_menu_open)
{
    instance_destroy();
    exit;
}

var move_up = false;
var move_down = false;
var move_left = false;
var move_right = false;
var confirm = false;
var cancel = false;

// keyboard
if (keyboard_check_pressed(vk_up)) move_up = true;
if (keyboard_check_pressed(vk_down)) move_down = true;
if (keyboard_check_pressed(vk_left)) move_left = true;
if (keyboard_check_pressed(vk_right)) move_right = true;
if (keyboard_check_pressed(vk_enter)) confirm = true;
if (keyboard_check_pressed(ord("E"))) confirm = true;
if (keyboard_check_pressed(vk_escape)) cancel = true;

// controller
if (gamepad_is_connected(0))
{
    var ry = gamepad_axis_value(0, gp_axisrv);
    var rx = gamepad_axis_value(0, gp_axisrh);

    if (abs(ry) < stick_deadzone) stick_ready_y = true;
    if (abs(rx) < stick_deadzone) stick_ready_x = true;

    if (stick_ready_y)
    {
        if (ry <= -stick_deadzone)
        {
            move_up = true;
            stick_ready_y = false;
        }
        else if (ry >= stick_deadzone)
        {
            move_down = true;
            stick_ready_y = false;
        }
    }

    if (stick_ready_x)
    {
        if (rx <= -stick_deadzone)
        {
            move_left = true;
            stick_ready_x = false;
        }
        else if (rx >= stick_deadzone)
        {
            move_right = true;
            stick_ready_x = false;
        }
    }

    if (gamepad_button_check_pressed(0, gp_face1)) confirm = true; // A
    if (gamepad_button_check_pressed(0, gp_face2)) cancel = true;  // B
}

// navigation
if (move_up)
{
    if (menu_mode == "category")
    {
        category_index--;
        if (category_index < 0) category_index = array_length(categories) - 1;
    }
    else
    {
        action_index--;
        if (action_index < 0) action_index = array_length(actions) - 1;
    }
}

if (move_down)
{
    if (menu_mode == "category")
    {
        category_index++;
        if (category_index >= array_length(categories)) category_index = 0;
    }
    else
    {
        action_index++;
        if (action_index >= array_length(actions)) action_index = 0;
    }
}

if (move_right)
{
    if (menu_mode == "category")
    {
        var item_name = categories[category_index];

        if (item_name != "Save" && item_name != "HP Potion")
        {
            menu_mode = "action";
            action_index = 0;
        }
    }
}

if (move_left)
{
    if (menu_mode == "action")
    {
        menu_mode = "category";
    }
}

// confirm
if (confirm)
{
    var item_name = categories[category_index];

    if (menu_mode == "category")
    {
        if (item_name == "Save")
        {
            save_player_snapshot();
            message = "Game Saved";
            message_timer = room_speed;
        }
        else if (item_name == "HP Potion")
        {
            var potion_cost = 25;

            if (global.coins >= potion_cost)
            {
                global.coins -= potion_cost;
                obj_character.hp_potions += 1;

                message = "Bought HP Potion";
                message_timer = room_speed;
            }
            else
            {
                message = "Not enough coins";
                message_timer = room_speed;
            }
        }
        else
        {
            menu_mode = "action";
            action_index = 0;
        }
    }
    else
    {
        var success = false;

        switch (action_index)
        {
            case 0:
                success = upgrade_item(item_name);
                message = success ? item_name + " upgraded" : "Cannot upgrade";
            break;

            case 1:
                success = repair_item(item_name);
                message = success ? item_name + " repaired" : "Cannot repair";
            break;
        }

        message_timer = room_speed;
    }
}

if (cancel)
{
    if (menu_mode == "action")
    {
        menu_mode = "category";
    }
    else
    {
        global.merchant_menu_open = false;
        instance_destroy();
    }
}

if (message_timer > 0)
{
    message_timer--;
}