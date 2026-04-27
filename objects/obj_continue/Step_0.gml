if (!active) exit;

var confirm_keyboard = keyboard_check_pressed(vk_enter);

var confirm_gamepad = false;

if (gamepad_is_connected(0))
{
    confirm_gamepad =
        gamepad_button_check_pressed(0, gp_face1) ||
        gamepad_button_check_pressed(0, gp_start);
}

if (focused && (confirm_keyboard || confirm_gamepad))
{
    global.load_save = true;
    room_goto(Forest);
}