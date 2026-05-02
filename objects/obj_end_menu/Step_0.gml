// -------------------------
// Movement
// -------------------------
var move = false;

// Keyboard movement
if (keyboard_check_pressed(vk_up)) move = true;
if (keyboard_check_pressed(vk_down)) move = true;

// Controller movement
if (gamepad_is_connected(0)) {
    var ry = gamepad_axis_value(0, gp_axislv);

    // Stick must return near center before another movement is allowed
    if (abs(ry) < stick_release_threshold) {
        stick_ready = true;
    }

    // One move per stick push
    if (stick_ready && abs(ry) >= stick_press_threshold) {
        move = true;
        stick_ready = false;
    }

    // D-pad support
    if (gamepad_button_check_pressed(0, gp_padu)) move = true;
    if (gamepad_button_check_pressed(0, gp_padd)) move = true;
}

// Toggle option
if (move) {
    option = 1 - option;
}


// -------------------------
// Confirm
// -------------------------
var confirm = false;

// Keyboard confirm
if (keyboard_check_pressed(vk_enter)) {
    confirm = true;
}

// Controller confirm
if (gamepad_is_connected(0)) {
    if (gamepad_button_check_pressed(0, gp_face1)) {
        confirm = true;
    }
}

if (confirm) {
    if (option == 0) {
        // reset ending state
        global.ending_started = false;
        global.death_screen_active = false;

        // respawn from checkpoint
        global.respawn_from_checkpoint = true;

        with (obj_character) {
            ending_lock = false;
        }

        load_checkpoint();
        room_goto(Forest);
    } else {
        game_end();
    }
}