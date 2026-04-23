
if (state == EnemyState.DEAD)
{
    if (!coins_dropped)
    {
        coins_dropped = true;

        var coin_count = irandom_range(coin_drop_min, coin_drop_max);

        for (var i = 0; i < coin_count; i++)
        {
            var c = instance_create_layer(x, y, "Instances", obj_coin);
            c.value = coin_value;
            c.hsp = random_range(-2.5, 2.5);
            c.vsp = random_range(-5, -2);
        }
    }

    if (!bones_burst && image_index >= 3)
    {
        bones_burst = true;

        var burst = instance_create_layer(x, y, "Instances", obj_bone_burst);
        burst.start_xscale = image_xscale;

        instance_destroy();
    }

    exit;
}

if (state == EnemyState.HURT)
{
    recoil_timer--;

    // small shove backward
    if (!place_meeting(x + hsp, y, obj_wall))
    {
        var hurt_blocker = instance_place(x + hsp, y, obj_skeleton_old);
        if (hurt_blocker == noone || hurt_blocker == id || hurt_blocker.state == EnemyState.DEAD)
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

    // keep recoil sprite active
    sprite_index = spr_skeleton_damage;

    if (recoil_timer <= 0)
    {
        recoil_timer = 0;
        hsp = 0;

        attack_active = false; // safety reset

        state = EnemyState.CHASE;
        sprite_index = spr_skeleton_walking;
        image_index = 0;
        image_speed = 1;
    }

    exit;
}

var old_x = x;

var on_ground = place_meeting(x, y + 1, obj_wall);

// gravity
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

// vertical movement
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

// refresh grounded state after moving
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

// state logic
switch (state)
{
    case EnemyState.IDLE:
        enemy_idle();
        break;

    case EnemyState.CHASE:
        enemy_chase();
        break;

    case EnemyState.ATTACK:
        sprite_index = spr_skeleton_attack;
        enemy_attack();
        break;
/*
    case EnemyState.TURN:
        sprite_index = spr_skeleton_turn;
        enemy_turn();
        break;
*/
    case EnemyState.HURT:
        sprite_index = spr_skeleton_damage;
        break;

    case EnemyState.DEAD:
        state_dead();
        break;
}

// clamp movement
if (hsp > move_speed) hsp = move_speed;
if (hsp < -move_speed) hsp = -move_speed;

// horizontal movement against walls + skeletons
var move_step = hsp;

if (move_step != 0)
{
    var blocked = false;

    if (place_meeting(x + move_step, y, obj_wall))
    {
        blocked = true;
    }

    var skel_blocker = instance_place(x + move_step, y, obj_skeleton_old);
    if (skel_blocker != noone && skel_blocker != id && skel_blocker.state != EnemyState.DEAD)
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

            skel_blocker = instance_place(x + move_step, y, obj_skeleton_old);
            if (skel_blocker != noone && skel_blocker != id && skel_blocker.state != EnemyState.DEAD)
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

// cleanup any existing overlap from previous frames
var overlap = instance_place(x, y, obj_skeleton_old);
if (overlap != noone && overlap != id && overlap.state != EnemyState.DEAD)
{
    var push_dir = sign(x - overlap.x);
    if (push_dir == 0) push_dir = choose(-1, 1);

    repeat (12)
    {
        var test_overlap = instance_place(x, y, obj_skeleton_old);
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

// AFTER movement
if (state != EnemyState.ATTACK
&& state != EnemyState.HURT
&& state != EnemyState.DEAD)
{
    if (x != old_x)
    {
        sprite_index = spr_skeleton_walking;
        image_speed = 1;
    }
    else
    {
        sprite_index = spr_skeleton_idle;
        image_speed = 1;
        image_index = 0;
    }
}

/*
// DEBUG: live hitbox tuning
if (keyboard_check_pressed(ord("J"))) attack_hitbox_x1 -= 1;
if (keyboard_check_pressed(ord("L"))) attack_hitbox_x1 += 1;

if (keyboard_check_pressed(ord("I"))) attack_hitbox_y1 -= 1;
if (keyboard_check_pressed(ord("K"))) attack_hitbox_y1 += 1;

if (keyboard_check_pressed(ord("A"))) attack_hitbox_x2 -= 1;
if (keyboard_check_pressed(ord("D"))) attack_hitbox_x2 += 1;

if (keyboard_check_pressed(ord("W"))) attack_hitbox_y2 -= 1;
if (keyboard_check_pressed(ord("S"))) attack_hitbox_y2 += 1;

if (keyboard_check_pressed(ord("Q"))) attack_hitbox_thickness -= 1;
if (keyboard_check_pressed(ord("E"))) attack_hitbox_thickness += 1;

attack_hitbox_thickness = max(1, attack_hitbox_thickness);
*/