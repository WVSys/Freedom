if(keyboard_check_pressed(ord("U"))) global.debug = !global.debug
if( keyboard_check_pressed(ord("M"))) global.tutorial_pause = !global.tutorial_pause;


if (keyboard_check_pressed(vk_f11)) {
	window_enable_borderless_fullscreen(true);
    window_set_fullscreen(!window_get_fullscreen());
}

var pause_blocked = (
    room == Title_Screen
);

if (pause_blocked)
{
    global.game_paused = false;
    exit;
}

var pause_pressed = keyboard_check_pressed(ord("P"));

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
    // D-pad navigation
    move_up = move_up || gamepad_button_check_pressed(0, gp_padu);
    move_down = move_down || gamepad_button_check_pressed(0, gp_padd);

    // Left stick navigation
    var ly = gamepad_axis_value(0, gp_axislv);

    // reset when stick returns to center
    if (abs(ly) < stick_deadzone)
    {
        stick_ready_y = true;
    }

    // only move once per stick flick
    if (stick_ready_y)
    {
        if (ly <= -stick_deadzone)
        {
            move_up = true;
            stick_ready_y = false;
        }
        else if (ly >= stick_deadzone)
        {
            move_down = true;
            stick_ready_y = false;
        }
    }

    // A confirm
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

if (global.game_paused && debug_callout_move)
{
    var move_speed = 1;

    if (keyboard_check(vk_shift))
    {
        move_speed = 5;
    }

    // switch selected callout
    if (keyboard_check_pressed(ord("1"))) debug_callout_index = 0;
    if (keyboard_check_pressed(ord("2"))) debug_callout_index = 1;
    if (keyboard_check_pressed(ord("3"))) debug_callout_index = 2;
    if (keyboard_check_pressed(ord("4"))) debug_callout_index = 3;
	if (keyboard_check_pressed(ord("5"))) debug_callout_index = 4;
	if (keyboard_check_pressed(ord("6"))) debug_callout_index = 5;
	if (keyboard_check_pressed(ord("7"))) debug_callout_index = 6;
	if (keyboard_check_pressed(ord("8"))) debug_callout_index = 7;

    // move label with arrow keys
    if (keyboard_check(vk_left))  callout_label_x[debug_callout_index] -= move_speed;
    if (keyboard_check(vk_right)) callout_label_x[debug_callout_index] += move_speed;
    if (keyboard_check(vk_up))    callout_label_y[debug_callout_index] -= move_speed;
    if (keyboard_check(vk_down))  callout_label_y[debug_callout_index] += move_speed;

    // move arrow target with WASD
    if (keyboard_check(ord("A"))) callout_target_x[debug_callout_index] -= move_speed;
    if (keyboard_check(ord("D"))) callout_target_x[debug_callout_index] += move_speed;
    if (keyboard_check(ord("W"))) callout_target_y[debug_callout_index] -= move_speed;
    if (keyboard_check(ord("S"))) callout_target_y[debug_callout_index] += move_speed;

    // print current selected values
    if (keyboard_check_pressed(vk_space))
    {
        show_debug_message("Selected callout: " + string(debug_callout_index) + " / " + callout_names[debug_callout_index]);

        show_debug_message("label_x = " + string(callout_label_x[debug_callout_index]));
        show_debug_message("label_y = " + string(callout_label_y[debug_callout_index]));

        show_debug_message("target_x = " + string(callout_target_x[debug_callout_index]));
        show_debug_message("target_y = " + string(callout_target_y[debug_callout_index]));
    }
	
	if (keyboard_check_pressed(ord("Z")))
    {
        var label_x_text = "callout_label_x = [";
        var label_y_text = "callout_label_y = [";
        var target_x_text = "callout_target_x = [";
        var target_y_text = "callout_target_y = [";

        for (var i = 0; i < array_length(callout_names); i++)
        {
            var comma = (i < array_length(callout_names) - 1) ? ", " : "";

            label_x_text += string(callout_label_x[i]) + comma;
            label_y_text += string(callout_label_y[i]) + comma;
            target_x_text += string(callout_target_x[i]) + comma;
            target_y_text += string(callout_target_y[i]) + comma;
        }

        label_x_text += "];";
        label_y_text += "];";
        target_x_text += "];";
        target_y_text += "];";

        show_debug_message("--------- CALLOUT FINAL VALUES ---------");
        show_debug_message(label_x_text);
        show_debug_message(label_y_text);
        show_debug_message(target_x_text);
        show_debug_message(target_y_text);
        show_debug_message("----------------------------------------");
    }
}

