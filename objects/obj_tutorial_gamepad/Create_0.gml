visible = true;

control_mode = "none";
// valid values:
// "attack"
// "block"
// "potion"
// "rune"
pulse = 0;
image_xscale = 0.08133;
image_yscale = 0.10685;

keyboard_text = "";
gamepad_text = "";
title_text = "";

set_control = function(_mode) {
    control_mode = _mode;

    switch (_mode) {
        case "attack":
            title_text = "ATTACK";
            keyboard_text = "Keyboard: F";
            gamepad_text = "Gamepad: X ";
            break;

        case "block":
            title_text = "BLOCK";
            keyboard_text = "Keyboard: G";
            gamepad_text = "Gamepad: Left Shoulder Btn";
            break;

        case "potion":
            title_text = "POTION";
            keyboard_text = "Keyboard: H";
            gamepad_text = "Gamepad: Up Directional";
            break;

        case "rune":
            title_text = "COINS AND RUNES";
            keyboard_text = "Coins buy supplies & upgrades";
            gamepad_text = "Runes upgrade gear";
            break;

        default:
            title_text = "";
            keyboard_text = "";
            gamepad_text = "";
            control_mode = "none";
            break;
    }
};