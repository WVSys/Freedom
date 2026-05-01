merchant_id = noone;
zone_id = noone;

show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = false;
show_merchant_upgrade = false;
show_merchant_repair = false;

timeline_running = false;
timeline_index = -1;
timeline_position = 0;
timeline_speed = 0;

start_intro = function()
{
    timeline_running = false;
    timeline_index = tml_merchant_intro;
    timeline_position = 0;
    timeline_speed = 1;
    timeline_running = true;

    show_debug_message("RUNNER START INTRO");
    show_debug_message("timeline_index: " + string(timeline_index));
    show_debug_message("timeline_position: " + string(timeline_position));
    show_debug_message("timeline_speed: " + string(timeline_speed));
    show_debug_message("timeline_running: " + string(timeline_running));
};

show_debug_message("RUNNER CREATE");

set_tutorial_focus = function(_mode) {
    var pad;
    var h;

    if (_mode == "none") {
        with (obj_tutorial_gamepad) {
            instance_destroy();
        }

        with (obj_tutorial_highlight) {
            instance_destroy();
        }

        return;
    }

    if (instance_exists(obj_tutorial_gamepad)) {
        pad = instance_find(obj_tutorial_gamepad, 0);
    } else {
        pad = instance_create_layer(704, 768, "Instances", obj_tutorial_gamepad);
    }

    if (instance_exists(obj_tutorial_highlight)) {
        h = instance_find(obj_tutorial_highlight, 0);
    } else {
        h = instance_create_layer(0, 0, "Instances", obj_tutorial_highlight);
    }

    switch (_mode) {
        case "attack":
            pad.set_control("attack");
            h.highlight_mode = "none";
            break;

        case "guard":
            pad.set_control("block");
            h.highlight_mode = "guard";
            break;

        case "potion":
            pad.set_control("potion");
            h.highlight_mode = "potions";
            break;

        case "coins":
            pad.set_control("rune");
            h.highlight_mode = "coins";
            break;

        case "runes":
            pad.set_control("rune");
            h.highlight_mode = "runes";
            break;
		
		case "upgrade":
			pad.set_control("upgrade");
			h.highlight_mode = "upgrade";
			break;
			
		case "repair":
			pad.set_control("repair");
			h.highlight_mode = "repair";
    }
};