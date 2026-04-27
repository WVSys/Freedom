if(keyboard_check_pressed(ord("P"))) global.debug = !global.debug
if( keyboard_check_pressed(ord("M"))) global.tutorial_pause = !global.tutorial_pause;

if (keyboard_check_pressed(vk_f11)) {
	window_enable_borderless_fullscreen(true);
    window_set_fullscreen(!window_get_fullscreen());
}

var in_gameplay_room = (room == Forest);

if (!in_gameplay_room)
{
    global.game_paused = false;
    exit;
}

var pause_pressed =
    keyboard_check_pressed(vk_escape) ||
    keyboard_check_pressed(ord("P"));

if (gamepad_is_connected(0))
{
    pause_pressed = pause_pressed || gamepad_button_check_pressed(0, gp_start);
}

if (pause_pressed)
{
    global.game_paused = !global.game_paused;
}

if (!global.game_paused)
{
    exit;
}

var move_up =
    keyboard_check_pressed(vk_up) ||
    keyboard_check_pressed(ord("W"));

var move_down =
    keyboard_check_pressed(vk_down) ||
    keyboard_check_pressed(ord("S"));

var confirm =
    keyboard_check_pressed(vk_enter) ||
    keyboard_check_pressed(vk_space);

if (gamepad_is_connected(0))
{
    move_up = move_up || gamepad_button_check_pressed(0, gp_padu);
    move_down = move_down || gamepad_button_check_pressed(0, gp_padd);

    confirm = confirm || gamepad_button_check_pressed(0, gp_face1);
}

if (move_up)
{
    pause_index--;

    if (pause_index < 0)
    {
        pause_index = array_length(pause_options) - 1;
    }
}

if (move_down)
{
    pause_index++;

    if (pause_index >= array_length(pause_options))
    {
        pause_index = 0;
    }
}

if (confirm)
{
    if (pause_index == 0)
    {
        global.game_paused = false;
    }
    else if (pause_index == 1)
    {
        global.game_paused = false;

        global.respawn_from_checkpoint = true;
        global.load_save = false;
        global.new_game = false;

        room_restart();
    }
    else if (pause_index == 2)
    {
        global.game_paused = false;

        global.respawn_from_checkpoint = false;
        global.load_save = false;
        global.new_game = false;

        room_goto(Title_Screen);
    }
}



