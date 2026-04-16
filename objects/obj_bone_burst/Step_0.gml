var all_landed = true;

for (var i = 0; i < count; i++)
{
    if (!planded[i])
    {
        all_landed = false;

        pvsp[i] += pgrav[i];

        // horizontal
        if (!place_meeting(px[i] + phsp[i], py[i], obj_wall))
        {
            px[i] += phsp[i];
        }
        else
        {
            phsp[i] *= -0.2;
        }

        // vertical
        if (place_meeting(px[i], py[i] + pvsp[i], obj_wall))
        {
            while (!place_meeting(px[i], py[i] + sign(pvsp[i]), obj_wall))
            {
                py[i] += sign(pvsp[i]);
            }

            pvsp[i] = 0;
            phsp[i] *= 0.35;

            if (abs(phsp[i]) < 0.15)
            {
                phsp[i] = 0;
                planded[i] = true;
            }
        }
        else
        {
            py[i] += pvsp[i];
        }

        pang[i] += prot[i];
        prot[i] *= 0.96;
    }
}

if (all_landed)
{
    // keep burst around as a corpse pile
    // or destroy after delay
    // alarm[0] = room_speed * 5;

    // optional: stop stepping once done
}