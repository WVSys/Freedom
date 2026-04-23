if (state == EnemyState.DEAD)
{
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
        x += hsp;
    }
    else
    {
        hsp = 0;
    }

    hsp *= 0.65;

    // keep recoil sprite active
    sprite_index = spr_hurt;

   if (recoil_timer <= 0)
	{
	    recoil_timer = 0;
	    hsp = 0;

	    attack_active = false; // safety reset

	    state = EnemyState.CHASE;
	    sprite_index = spr_walk;
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
switch (state) {
    case EnemyState.IDLE:
        enemy_idle();
        break;

    case EnemyState.CHASE:
        enemy_chase();
        break;

    case EnemyState.ATTACK:
        sprite_index = spr_attack;
        enemy_attack();
        break;
		
    case EnemyState.TURN:
        sprite_index = spr_turn;
        enemy_turn();
        break;

    case EnemyState.HURT:
        //state_hurt();
		sprite_index = spr_hurt;
        break;

    case EnemyState.DEAD:
        state_dead();
        break;
}

// horizontal movement
if (place_meeting(x + hsp, y, obj_wall)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x += sign(hsp);
    }
    hsp = 0;
}

x += hsp;

// AFTER movement
if (state != EnemyState.TURN 
&& state != EnemyState.ATTACK 
&& state != EnemyState.HURT
&& state != EnemyState.DEAD)
{
    if (x != old_x) {
        sprite_index = spr_walk;
        image_speed = 1;
    } else {
        sprite_index = spr_idle;
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

attack_hitbox_thickness = max(1, attack_hitbox_thickness);*/