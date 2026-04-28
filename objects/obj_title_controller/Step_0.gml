var confirm_keyboard = keyboard_check_pressed(vk_enter);
var cancel_keyboard = keyboard_check_pressed(vk_escape);

var up_keyboard = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var down_keyboard = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));

var confirm_gamepad = false;
var cancel_gamepad = false;
var up_gamepad = false;
var down_gamepad = false;

if (gamepad_is_connected(0))
{
    confirm_gamepad =
        gamepad_button_check_pressed(0, gp_face1) ||
        gamepad_button_check_pressed(0, gp_start);

    cancel_gamepad =
        gamepad_button_check_pressed(0, gp_face2); // B / Circle

    up_gamepad = gamepad_button_check_pressed(0, gp_padu);
    down_gamepad = gamepad_button_check_pressed(0, gp_padd);

    var ly = gamepad_axis_value(0, gp_axislv);

    if (abs(ly) < stick_deadzone)
    {
        stick_ready_y = true;
    }

    if (stick_ready_y)
    {
        if (ly < -stick_deadzone)
        {
            up_gamepad = true;
            stick_ready_y = false;
        }
        else if (ly > stick_deadzone)
        {
            down_gamepad = true;
            stick_ready_y = false;
        }
    }
}

var confirm = confirm_keyboard || confirm_gamepad;
var cancel = cancel_keyboard || cancel_gamepad;
var move_up = up_keyboard || up_gamepad;
var move_down = down_keyboard || down_gamepad;


// OVERWRITE CONFIRMATION MODE
if (confirm_overwrite)
{
    if (confirm)
    {
        // Start fresh and overwrite old save later
        if (file_exists(save_file))
        {
            file_delete(save_file);
        }

        global.load_save = false;
        global.respawn_from_checkpoint = false;
        global.new_game = true;

        room_goto(Forest);
    }

    if (cancel)
    {
        confirm_overwrite = false;

        with (obj_start)
        {
            focused = true;
        }

        with (obj_continue)
        {
            focused = false;
        }

        menu_index = 0;
    }

    exit;
}


// NORMAL MENU MODE
if (has_continue && (move_up || move_down))
{
    menu_index = 1 - menu_index;

    with (obj_start)
    {
        focused = (other.menu_index == 0);
    }

    with (obj_continue)
    {
        focused = (other.menu_index == 1);
    }
}

if (confirm)
{
    if (menu_index == 0)
    {
        // Start selected
        if (file_exists(save_file))
        {
            confirm_overwrite = true;

            with (obj_start)
            {
                focused = false;
            }

            with (obj_continue)
            {
                focused = false;
            }
        }
        else
        {
            global.load_save = false;
            global.respawn_from_checkpoint = false;
            global.new_game = true;

            room_goto(Forest);
        }
    }
    else if (menu_index == 1 && has_continue)
    {
        // Continue selected
        global.load_save = true;
        global.respawn_from_checkpoint = false;
        global.new_game = false;

        room_goto(Forest);
    }
}