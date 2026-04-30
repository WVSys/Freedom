// Inherit the parent event
event_inherited();

// ===============================
// SIMPLE BAT FLYING AI OVERRIDE
// ===============================

// detect player
var player = instance_nearest(x, y, obj_character);

if (player != noone && !player.is_dead)
{
    var dist_x = abs(player.x - x);
    var dist_y = player.y - y;

    // -------------------------
    // PATROL MODE
    // -------------------------
    if (dist_x > 120 || dive_timer <= 0)
    {
        hsp = facing_dir * 2;

        // gentle hover motion
        y += sin(current_time / 200) * 0.5;

        // turn if near wall
        if (place_meeting(x + hsp, y, obj_wall))
        {
            facing_dir *= -1;
        }
    }

    // -------------------------
    // DIVE / PASS-BY MODE
    // -------------------------
    else
    {
        dive_timer = 60; // lock behavior briefly

        // move toward player X
        hsp = sign(player.x - x) * 3;

        // adjust height toward player (this is the key)
        if (y < player.y - 20) y += 1.5;
        if (y > player.y + 20) y -= 1.5;

        // pass through behavior (no sticking above player)
        if (abs(dist_x) < 30)
        {
            y -= 1.2; // rise after pass-through
        }
    }
}
else
{
    // fallback patrol if no player
    hsp = facing_dir * 2;

    if (place_meeting(x + hsp, y, obj_wall))
    {
        facing_dir *= -1;
    }
}

// cooldown timer
if (dive_timer > 0) dive_timer--;

// apply movement safely
if (!place_meeting(x + hsp, y, obj_wall))
{
    x += hsp;
}

// sprite direction
image_xscale = facing_dir;