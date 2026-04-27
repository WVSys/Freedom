merchant_id = noone;
zone_id = noone;

show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = false;

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