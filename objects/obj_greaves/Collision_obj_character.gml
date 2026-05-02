with (other)
{
    if (!greaves)
    {
        greaves = true;
        greaves_level = 1;

        refresh_equipment_stats(false);
        greaves_durability = greaves_durability_max;
    }
}
audio_play_sound(armor_find,1, false);
global.greaves_collected = true;
instance_destroy();