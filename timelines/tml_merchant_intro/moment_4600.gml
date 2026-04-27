show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = false;

global.dialogue_active = false;
global.tutorial_paused = false;
global.intro_merchant_seen = true;

if (instance_exists(zone_id))
{
    with (zone_id)
    {
        tutorial_timeline_running = false;
    }
}

timeline_running = false;
timeline_speed = 0;

show_debug_message("Merchant intro timeline finished. Player unlocked.");

instance_destroy();