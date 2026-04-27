player_was_near = player_near;
player_near = false;

if (instance_exists(obj_character))
{
    if (place_meeting(x, y, obj_character))
    {
        player_near = true;
        obj_character.interact_target = id;

        // Runs only on the first frame the player enters the zone
        if (!player_was_near)
        {
            if (instance_exists(merchant_id))
            {
                with (merchant_id)
                {
                    merchant_say("Hey there!");
                }
            }
        }
    }
    else
    {
        if (obj_character.interact_target == id)
        {
            obj_character.interact_target = noone;
        }
    }
}
else
{
    show_debug_message("obj_character does not exist");
}