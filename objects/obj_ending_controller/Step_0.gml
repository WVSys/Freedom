// if boss is gone, trigger ending
if (!global.ending_started && !instance_exists(obj_gorgon_boss))
{
    global.ending_started = true;

    if (instance_exists(obj_character))
    {
        with (obj_character)
        {
            start_ending_sequence();
        }
    }
}