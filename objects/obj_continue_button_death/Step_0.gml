if (!active) exit;
if (!focused) exit;
if (!active) exit;

image_alpha = min(image_alpha + fade_speed, 1);

// Extra safety: only allow continue if the player is actually dead
if (!instance_exists(obj_character)) exit;

var player_dead = false;

with (obj_character)
{
    if (is_dead)
    {
        player_dead = true;
    }
}

if (!player_dead) exit;

var confirm_keyboard =
    keyboard_check_pressed(vk_enter);

var confirm_gamepad = false;

if (gamepad_is_connected(0))
{
    confirm_gamepad =
        gamepad_button_check_pressed(0, gp_face1) ||
        gamepad_button_check_pressed(0, gp_start);
}

var confirm = confirm_keyboard || confirm_gamepad;

if (confirm)
{
    with (obj_death_ui)
    {
        instance_destroy();
    }

    with (obj_character)
    {
        death_ui_created = false;
        is_dead = false;
    }

    load_checkpoint();
    global.respawn_from_checkpoint = true;
    room_goto(Forest);
}