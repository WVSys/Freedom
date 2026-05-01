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

global.gauntlets_collected = true;
instance_destroy();