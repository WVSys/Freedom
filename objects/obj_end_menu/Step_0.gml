// keyboard
var move = false;

if (keyboard_check_pressed(vk_up)) move = true;
if (keyboard_check_pressed(vk_down)) move = true;

// controller
if (gamepad_is_connected(0))
{
    var ry = gamepad_axis_value(0, gp_axislv);

    if (abs(ry) < 0.5) ry = 0;

    if (ry <= -0.5) move = true;
    if (ry >= 0.5) move = true;
}

// toggle option
if (move)
{
    option = 1 - option;
}
if (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1))
{
    if (option == 0)
    {
        // reset ending state
        global.ending_started = false;
        global.death_screen_active = false;

        // respawn from checkpoint
        global.respawn_from_checkpoint = true;

        with (obj_character)
        {
            ending_lock = false;
        }

        load_checkpoint();
        room_goto(Forest);
    }
    else
    {
        game_end();
    }
}