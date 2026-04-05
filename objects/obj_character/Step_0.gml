var move_x = 0;

// keyboard movement
if (keyboard_check(vk_left))  move_x -= 1;
if (keyboard_check(vk_right)) move_x += 1;

var jump_pressed = keyboard_check_pressed(vk_space);
var attack_pressed = false;

// controller
if (gamepad_is_connected(0))
{
    var gx = gamepad_axis_value(0, gp_axislh);
    if (abs(gx) > deadzone) move_x = gx;

    // A = jump
    if (gamepad_button_check_pressed(0, gp_face1)) jump_pressed = true;

    // X = attack
    if (gamepad_button_check_pressed(0, gp_face3)) attack_pressed = true;
}

// face direction
if (move_x > 0) image_xscale = 1;
if (move_x < 0) image_xscale = -1;

// grounded check
var on_ground = place_meeting(x, y + 1, obj_wall);

// prevent late air attack too close to the floor
var min_air_attack_clearance = 90;
var can_start_air_attack = !place_meeting(x, y + min_air_attack_clearance, obj_wall);

// jump
if (jump_pressed && on_ground)
{
    vsp = jump_speed;
}

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

// attack start
if (combat_state == CombatState.NONE && attack_pressed)
{
    if (on_ground)
    {
        combat_state = CombatState.ATTACK1;
        sprite_index = spr_first_attack;
        image_index = 0;
        image_speed = 1;
    }
    else if (!air_attack_used && can_start_air_attack)
    {
        combat_state = CombatState.AIR_ATTACK;
        //air_attack_used = true;
        air_attack_active = false;
        air_attack_hits_done = 0;
        air_attack_hit_cooldown = 0;
        air_attack_last_target = noone;

        sprite_index = spr_jump_attack;
        image_index = 0;
        image_speed = 1;
    }
}

// horizontal movement
hsp = move_x * move_speed;

if (!place_meeting(x + hsp, y, obj_wall))
{
    x += hsp;
}
else
{
    while (!place_meeting(x + sign(hsp), y, obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
}

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

if (on_ground)
{
    air_attack_used = false;
}

// only update movement states if not attacking
if (combat_state == CombatState.NONE)
{
    if (on_ground && !was_on_ground && vsp >= 0)
    {
        move_state = MoveState.LAND;
        image_index = 0;
        image_speed = 1;
    }
    else if (move_state != MoveState.LAND)
    {
        if (!on_ground)
        {
            if (vsp < -0.1)
                move_state = MoveState.JUMP;
            else if (vsp > 1)
                move_state = MoveState.FALL;
        }
        else
        {
            if (abs(move_x) > 0)
                move_state = MoveState.RUN;
            else
                move_state = MoveState.IDLE;
        }
    }
}

// combat update
if (combat_state == CombatState.ATTACK1)
{
    if (image_index >= image_number - 1)
    {
        combat_state = CombatState.NONE;
    }
}
else if (combat_state == CombatState.AIR_ATTACK)
{
    // best fix: cancel immediately on landing
    if (on_ground)
    {
        combat_state = CombatState.NONE;
        air_attack_active = false;
        air_attack_hit_cooldown = 0;
        air_attack_last_target = noone;

        move_state = MoveState.LAND;
        image_index = 0;
        image_speed = 1;
    }
    else
    {
        // active frames
        air_attack_active = (image_index >= 2 && image_index <= 5);

        if (air_attack_hit_cooldown > 0)
        {
            air_attack_hit_cooldown -= 1;
        }

        if (image_index >= image_number - 1)
        {
            combat_state = CombatState.NONE;
            air_attack_active = false;
            air_attack_hit_cooldown = 0;
            air_attack_last_target = noone;
        }
    }
}

was_on_ground = on_ground;

// animation
if (combat_state != CombatState.NONE)
{
    switch (combat_state)
    {
        case CombatState.ATTACK1:
            sprite_index = spr_first_attack;
        break;

        case CombatState.AIR_ATTACK:
            sprite_index = spr_jump_attack;
        break;
    }
}
else
{
    switch (move_state)
    {
        case MoveState.IDLE:
            sprite_index = spr_idle_stand1;
        break;

        case MoveState.RUN:
            sprite_index = spr_walking;
        break;

        case MoveState.JUMP:
            sprite_index = spr_jump;
        break;

        case MoveState.FALL:
            sprite_index = spr_falling_down;
        break;

        case MoveState.LAND:
            sprite_index = spr_landing;
            if (image_index >= image_number - 1)
            {
                if (abs(move_x) > 0) move_state = MoveState.RUN;
                else move_state = MoveState.IDLE;
            }
        break;
    }
}