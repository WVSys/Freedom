var move_down =
    keyboard_check_pressed(vk_down) ||
    keyboard_check_pressed(ord("S"));

var move_up =
    keyboard_check_pressed(vk_up) ||
    keyboard_check_pressed(ord("W"));

var gp_down = false;
var gp_up = false;

if (gamepad_is_connected(0))
{
    gp_down =
        gamepad_button_check_pressed(0, gp_padd) ||
        gamepad_axis_value(0, gp_axislv) > 0.5;

    gp_up =
        gamepad_button_check_pressed(0, gp_padu) ||
        gamepad_axis_value(0, gp_axislv) < -0.5;
}

move_down = move_down || gp_down;
move_up = move_up || gp_up;

// Only switch if Continue exists
if (has_continue && (move_down || move_up))
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

if (keyboard_check_pressed(ord("K")))
{
    if (file_exists("save.json"))
    {
        file_delete("save.json");
        show_debug_message("Deleted save.json");
    }
    else
    {
        show_debug_message("No save.json to delete");
    }

    room_restart();
}