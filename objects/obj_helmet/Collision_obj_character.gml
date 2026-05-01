with (other)
{
    if (!helmet)
    {
        helmet = true;
        helmet_level = 1;

        refresh_equipment_stats(false);
        helmet_durability = helmet_durability_max;
    }
}

global.helmet_collected = true;
instance_destroy();