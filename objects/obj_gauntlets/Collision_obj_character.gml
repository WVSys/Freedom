with (other)
{
    if (!gauntlets)
    {
        gauntlets = true;
        gauntlets_level = 1;

        refresh_equipment_stats(false);
        gauntlets_durability = gauntlets_durability_max;
    }
}
audio_play_sound(armor_find,1, false);
global.gauntlets_collected = true;
instance_destroy();