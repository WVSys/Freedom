with (other)
{
    if (!chestplate)
    {
        chestplate = true;
        chestplate_level = 1;

        refresh_equipment_stats(false);
        chestplate_durability = chestplate_durability_max;

        show_debug_message("Picked up Chestplate!");
    }
}
audio_play_sound(armor_find,1, false);

global.chestplate_collected = true;

instance_destroy();