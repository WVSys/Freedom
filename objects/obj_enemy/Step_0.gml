if (state == EnemiesState.DEAD)
{
    enemy_drop_coins();

    if (!bones_burst && image_index >= 3)
    {
        bones_burst = true;

        if (death_burst_object != noone)
        {
            var burst = instance_create_layer(x, y, "Instances", death_burst_object);
            burst.start_xscale = image_xscale;
        }

        instance_destroy();
    }

    exit;
}

if (state == EnemiesState.HURT)
{
    recoil_timer--;

    if (!place_meeting(x + hsp, y, obj_wall))
    {
        var hurt_blocker = instance_place(x + hsp, y, enemy_blocker_object);
        if (hurt_blocker == noone || hurt_blocker == id || hurt_blocker.state == EnemiesState.DEAD)
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
        hsp = 0;
    }

    hsp *= 0.65;

    if (spr_hurt != noone)
    {
        sprite_index = spr_hurt;
    }

    if (recoil_timer <= 0)
    {
        recoil_timer = 0;
        hsp = 0;
        attack_active = false;
        state = EnemiesState.CHASE;

        if (spr_walk != noone)
        {
            sprite_index = spr_walk;
            image_index = 0;
            image_speed = 1;
        }
    }

    exit;
}

var old_x = x;

var on_ground = place_meeting(x, y + 1, obj_wall);

if (!on_ground || vsp < 0)
{
    vsp += grav;
    if (vsp > max_fall) vsp = max_fall;
}
else
{
    vsp = 0;
}

if (attack_cooldown > 0) attack_cooldown--;

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
}

var touching_ground = place_meeting(x, y + 1, obj_wall);

if (touching_ground)
{
    ground_buffer = ground_buffer_max;
}
else if (ground_buffer > 0)
{
    ground_buffer -= 1;
}

on_ground = (ground_buffer > 0);

// child will define these
switch (state)
{
    case EnemiesState.IDLE:
        enemy_idle();
        break;

    case EnemiesState.CHASE:
        enemy_chase();
        break;

    case EnemiesState.ATTACK:
        if (spr_attack != noone) sprite_index = spr_attack;
        enemy_attack();
        break;

    case EnemiesState.TURN:
        if (spr_turn != noone) sprite_index = spr_turn;
        enemy_turn();
        break;

    case EnemiesState.HURT:
        if (spr_hurt != noone) sprite_index = spr_hurt;
        break;

    case EnemiesState.DEAD:
        state_dead();
        break;
}

if (hsp > move_speed) hsp = move_speed;
if (hsp < -move_speed) hsp = -move_speed;

var move_step = hsp;

if (move_step != 0)
{
    var blocked = false;

    if (place_meeting(x + move_step, y, obj_wall))
    {
        blocked = true;
    }

    var enemy_blocker = instance_place(x + move_step, y, enemy_blocker_object);
    if (enemy_blocker != noone && enemy_blocker != id && enemy_blocker.state != EnemiesState.DEAD)
    {
        blocked = true;
    }

    if (!blocked)
    {
        x += move_step;
    }
    else
    {
        while (abs(move_step) > 0)
        {
            move_step -= sign(move_step);

            blocked = false;

            if (place_meeting(x + move_step, y, obj_wall))
            {
                blocked = true;
            }

            enemy_blocker = instance_place(x + move_step, y, enemy_blocker_object);
            if (enemy_blocker != noone && enemy_blocker != id && enemy_blocker.state != EnemiesState.DEAD)
            {
                blocked = true;
            }

            if (!blocked)
            {
                x += move_step;
                break;
            }
        }

        hsp = 0;
    }
}

var overlap = instance_place(x, y, enemy_blocker_object);
if (overlap != noone && overlap != id && overlap.state != EnemiesState.DEAD)
{
    var push_dir = sign(x - overlap.x);
    if (push_dir == 0) push_dir = choose(-1, 1);

    repeat (12)
    {
        var test_overlap = instance_place(x, y, enemy_blocker_object);
        if (test_overlap == noone || test_overlap == id) break;

        if (!place_meeting(x + push_dir, y, obj_wall))
        {
            x += push_dir;
        }
        else
        {
            break;
        }
    }
}

if (state != EnemiesState.TURN
&& state != EnemiesState.ATTACK
&& state != EnemiesState.HURT
&& state != EnemiesState.DEAD)
{
    if (x != old_x)
    {
        if (spr_walk != noone) sprite_index = spr_walk;
        image_speed = 1;
    }
    else
    {
        if (spr_idle != noone) sprite_index = spr_idle;
        image_speed = 1;
        image_index = 0;
    }
}