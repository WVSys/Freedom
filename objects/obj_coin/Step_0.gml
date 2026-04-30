if (!landed)
{
    vsp += grav;

    if (!place_meeting(x, y + vsp, obj_wall))
    {
        y += vsp;
    }
    else
    {
        while (!place_meeting(x, y + sign(vsp), obj_wall))
        {
            y += sign(vsp);
        }

        vsp = 0;
        hsp = 0;
        landed = true;
    }

    if (!place_meeting(x + hsp, y, obj_wall))
    {
        x += hsp;
    }
    else
    {
        hsp = 0;
    }
}
else
{
    // optional: idle sparkle / bob / wait
}

if (place_meeting(x, y, obj_character))
{
    global.coins += value;
	audio_play_sound(coin_pickup,1, false);
    instance_destroy();
}