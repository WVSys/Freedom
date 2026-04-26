player_near = false;

if (instance_exists(obj_character))
{
    if (place_meeting(x, y, obj_character))
    {
        player_near = true;
        obj_character.interact_target = id;
        //show_debug_message("PLAYER IS NEAR MERCHANT");
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