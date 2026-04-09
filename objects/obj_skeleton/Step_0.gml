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
        sprite_index = spr_skeleton_attack;
        enemy_attack();
        break;
		
    case EnemyState.TURN:
        sprite_index = spr_skeleton_turn;
        enemy_turn();
        break;

    case EnemyState.HURT:
        state_hurt();
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
if (state != EnemyState.TURN && state != EnemyState.ATTACK) {
    if (x != old_x) {
        sprite_index = spr_skeleton_walking;
        image_speed = 1;
    } else {
        sprite_index = spr_skeleton_idle;
        image_speed = 1;
        image_index = 0;
    }
}