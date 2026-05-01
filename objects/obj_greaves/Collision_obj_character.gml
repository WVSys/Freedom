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

global.greaves_collected = true;
instance_destroy();