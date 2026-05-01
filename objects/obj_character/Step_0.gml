if (global.game_paused)
{
    image_speed = 0;
    exit;
}
else
{
	image_speed = 1;
}
if (move_state == MoveState.HURT) {
    state_hurt();
    exit;
}
if (global.dialogue_active)
{
    hsp = 0;
    vsp = 0;

    move_state = MoveState.IDLE;
    combat_state = CombatState.NONE;

    sprite_index = spr_idle_stand1;
    image_speed = 1;

    exit;
}
if (is_dead)
{
    hsp = 0;

    var on_ground_dead = place_meeting(x, y + 1, obj_wall);

    // Let dead body fall until it hits the ground
    if (!on_ground_dead)
    {
        vsp += grav;
        if (vsp > max_fall) vsp = max_fall;

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
    }
    else
    {
        vsp = 0;

        // Once grounded, show death UI
        if (!instance_exists(obj_death_ui))
        {
            var dui = instance_create_depth(0, 0, -100000, obj_death_ui);
            dui.active = true;
            dui.visible = true;
            dui.image_alpha = 0;
            dui.continue_created = false;

            global.death_screen_active = true;
        }
    }

    exit;
}

if (speech_cooldown > 0)
{
    speech_cooldown--;
}

if (global.merchant_menu_open)
{
    hsp = 0;
    vsp = 0;
	sprite_index = spr_idle_stand1;
    image_speed = 1;
    exit;
}

if (!is_dead)
{
    var dt = delta_time / 1000000; // converts microseconds to seconds

    if (!is_blocking && guard_meter < guard_meter_max)
    {
        guard_meter = min(
            guard_meter + guard_regen_per_second * dt,
            guard_meter_max
        );
    }

    if (guard_broken && guard_meter >= guard_recover_threshold)
    {
        guard_broken = false;
    }
}

var move_x = 0;

// keyboard movement
if (keyboard_check(vk_left))  move_x -= 1;
if (keyboard_check(vk_right)) move_x += 1;

var jump_pressed = keyboard_check_pressed(vk_space);
var attack_pressed = keyboard_check_pressed(ord("G"));
var guard_held = keyboard_check(ord("F"));

// controller
if (gamepad_is_connected(0))
{
    var gx = gamepad_axis_value(0, gp_axislh);
    if (abs(gx) > deadzone) move_x = gx;

    var near_merchant_zone = (
    instance_exists(interact_target)
    && interact_target.object_index == obj_merchant_zone
	);

    // A = jump, unless near merchant zone
    if (!near_merchant_zone && gamepad_button_check_pressed(0, gp_face1))
    {
        jump_pressed = true;
    }

    // X = attack
    if (gamepad_button_check_pressed(0, gp_face3))
    {
        attack_pressed = true;
    }

    // left shoulder for guard
    if (gamepad_button_check(0, gp_shoulderl))
    {
        guard_held = true;
    }
}

// guard availability
var tried_to_guard = guard_held;
if (guard_broken || guard_meter <= 0)
{
    guard_held = false;
	 if (tried_to_guard && speech_cooldown <= 0)
    {
        say("I can't block yet.");
        speech_cooldown = 60;
    }
}

// face direction
if (move_x > 0) facing = 1;
if (move_x < 0) facing = -1;

image_xscale = facing;

// grounded check
var on_ground = place_meeting(x, y + 1, obj_wall);

// prevent late air attack too close to the floor
var min_air_attack_clearance = 90;
var can_start_air_attack = !place_meeting(x, y + min_air_attack_clearance, obj_wall);

// jump
if (jump_pressed && on_ground && combat_state != CombatState.GUARD)
{
    vsp = jump_speed;
}

// gravity
if (global.debug && debug_no_gravity)
{
    vsp = 0;
}
else
{
    if (!on_ground || vsp < 0)
    {
        vsp += grav;
        if (vsp > max_fall) vsp = max_fall;
    }
    else
    {
        vsp = 0;
    }
}

// block start / hold
if (guard_held && on_ground && combat_state != CombatState.ATTACK1 && combat_state != CombatState.AIR_ATTACK)
{
    combat_state = CombatState.GUARD;
    is_blocking = true;

    spawn_attack_hitbox(
        id,
        noone,
        shield_x1,
        shield_y1,
        shield_x2,
        shield_y2,
        guard_damage_cost,
        get_effective_sword_damage(),
        shield_thickness,
        "guard"
    );
}
else if (combat_state == CombatState.GUARD)
{
    combat_state = CombatState.NONE;
    is_blocking = false;
}
else
{
    is_blocking = false;
}

// attack start
if (combat_state == CombatState.NONE && attack_pressed)
{
    if (on_ground)
    {
		damage_sword(sword_durability_loss_per_ground_attack);
		
		audio_play_sound(sword_slash,1,false);
		
        combat_state = CombatState.ATTACK1;
        attack_active = false;
        attack_spawned_frame = -1;

        sprite_index = spr_first_attack;
        image_index = 0;
        image_speed = 1;
    }
    else if (!air_attack_used && can_start_air_attack)
    {
		damage_sword(sword_durability_loss_per_ground_attack);
		
		audio_play_sound(sword_slash,1,false);
		
        combat_state = CombatState.AIR_ATTACK;
        air_attack_active = false;
        air_attack_hits_done = 0;
        air_attack_hit_cooldown = 0;
        air_attack_last_target = noone;

        sprite_index = spr_jump_attack;
        image_index = 0;
        image_speed = 1;

        // push player out if the attack state starts in a slight overlap
        if (place_meeting(x, y, obj_wall))
        {
            var fixed = false;

            // try upward first
            repeat (8)
            {
                if (!place_meeting(x, y - 1, obj_wall))
                {
                    y -= 1;
                    fixed = true;
                    break;
                }
                y -= 1;
            }

            // if still overlapping, try opposite of facing
            if (place_meeting(x, y, obj_wall))
            {
                repeat (8)
                {
                    if (!place_meeting(x - facing, y, obj_wall))
                    {
                        x -= facing;
                        fixed = true;
                        break;
                    }
                    x -= facing;
                }
            }

            // final cleanup
            while (place_meeting(x, y, obj_wall))
            {
                y -= 1;
            }
        }
    }
}

// horizontal movement
if (combat_state == CombatState.GUARD || combat_state == CombatState.ATTACK1) {
    hsp = 0;
} else {
    hsp = move_x * move_speed;
}

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

// extra cleanup in case of tiny overlap after vertical resolution
if (vsp >= 0 && place_meeting(x, y, obj_wall))
{
    while (place_meeting(x, y, obj_wall))
    {
        y -= 1;
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
    var f = floor(image_index);

    if (f != attack_spawned_frame)
    {
        var i = -1;

        if (f == 0) i = 0;
        if (f == 1) i = 1;
        if (f == 2) i = 2;
		if (f == 3) i = 3;
		if (f == 4) i = 4;

        if (i != -1)
        {
            spawn_attack_hitbox(
                id,
                obj_enemy,
                arc_x1[i],
                arc_y1[i],
                arc_x2[i],
                arc_y2[i],
                get_effective_sword_damage(),
                attack_hitbox_life,
                arc_thickness[i]
            );

            attack_spawned_frame = f;
        }
    }

    if (image_index >= image_number - 1)
    {
        combat_state = CombatState.NONE;
        attack_active = false;
        attack_spawned_frame = -1;
    }
}
else if (combat_state == CombatState.AIR_ATTACK)
{
    // Cancel immediately on landing
    if (on_ground)
    {
        combat_state = CombatState.NONE;
        air_attack_active = false;
        air_attack_hit_cooldown = 0;
        air_attack_last_target = noone;
        air_attack_spawned_frame = -1;

        move_state = MoveState.LAND;
        image_index = 0;
        image_speed = 1;
    }
    else
    {
        var f = floor(image_index);

        // Optional active window flag
        air_attack_active = (f >= 1 && f <= 3);

        if (air_attack_hit_cooldown > 0)
        {
            air_attack_hit_cooldown -= 1;
        }

        // Spawn one hitbox segment per animation frame
        if (f != air_attack_spawned_frame)
        {
            var i = -1;

            if (f == 1) i = 0;
            if (f == 2) i = 1;
            if (f == 3) i = 2;
            if (f == 4) i = 3;
            if (f == 5) i = 4;

            if (i != -1)
            {
                spawn_attack_hitbox(
                    id,
                    obj_skeleton_old,
                    air_arc_x1[i],
                    air_arc_y1[i],
                    air_arc_x2[i],
                    air_arc_y2[i],
                    get_effective_sword_damage(),
                    attack_hitbox_life,
                    air_arc_thickness[i]
                );

                air_attack_spawned_frame = f;
            }
        }

        if (image_index >= image_number - 1)
        {
            combat_state = CombatState.NONE;
            air_attack_active = false;
            air_attack_hit_cooldown = 0;
            air_attack_last_target = noone;
            air_attack_spawned_frame = -1;
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
        
        case CombatState.GUARD:
            sprite_index = spr_guard;
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
		
		case MoveState.DEAD:
		    sprite_index = spr_character_dead;
		break;
    }
}

// Use HP potion
if (keyboard_check_pressed(ord("H")) 
|| gamepad_button_check_pressed(0, gp_padu))
{
    if (hp_potions > 0 && !heal_active && hp < hp_max)
    {
        hp_potions -= 1;

        heal_active = true;
        heal_amount_remaining = 20; // total HP restored over time
        heal_tick_timer = 0;
    }
}

// Heal over time
if (heal_active)
{
    heal_tick_timer += 1;

    if (heal_tick_timer >= heal_tick_rate)
    {
        heal_tick_timer = 0;

        if (hp < hp_max && heal_amount_remaining > 0)
        {
            hp += heal_per_tick;
            heal_amount_remaining -= heal_per_tick;

            if (hp > hp_max)
            {
                hp = hp_max;
            }
        }

        if (heal_amount_remaining <= 0 || hp >= hp_max)
        {
            heal_active = false;
            heal_amount_remaining = 0;
        }
    }
}

// Cooldown timer
if (approach_say_cooldown > 0)
{
    approach_say_cooldown--;

    if (approach_say_cooldown <= 0)
    {
        can_say_approach_line = true;
    }
}

// Detect collision marker
var marker = instance_place(x, y, obj_talk_marker);

if (marker != noone && can_say_approach_line)
{
    var phrase = approach_phrases[irandom(array_length(approach_phrases) - 1)];

    say(phrase);

    can_say_approach_line = false;
    approach_say_cooldown = 180;
}

// Press T to toggle shield tuning mode
if (global.debug && keyboard_check_pressed(ord("T"))) {
    debug_tune_shield = !debug_tune_shield;
}

if (global.debug && debug_tune_shield)
{
    if (keyboard_check_pressed(ord("J"))) shield_x1 -= 1;
    if (keyboard_check_pressed(ord("L"))) shield_x1 += 1;
    if (keyboard_check_pressed(ord("I"))) shield_y1 -= 1;
    if (keyboard_check_pressed(ord("K"))) shield_y1 += 1;

    if (keyboard_check_pressed(ord("A"))) shield_x2 -= 1;
    if (keyboard_check_pressed(ord("D"))) shield_x2 += 1;
    if (keyboard_check_pressed(ord("W"))) shield_y2 -= 1;
    if (keyboard_check_pressed(ord("S"))) shield_y2 += 1;

    if (keyboard_check_pressed(ord("Q"))) shield_thickness -= 1;
    if (keyboard_check_pressed(ord("E"))) shield_thickness += 1;

    shield_thickness = max(1, shield_thickness);
}

if (global.debug && debug_no_gravity)
{
    if (keyboard_check_pressed(ord("1"))) debug_arc_index = 0;
    if (keyboard_check_pressed(ord("2"))) debug_arc_index = 1;
    if (keyboard_check_pressed(ord("3"))) debug_arc_index = 2;
    if (keyboard_check_pressed(ord("4"))) debug_arc_index = 3;
    if (keyboard_check_pressed(ord("5"))) debug_arc_index = 4;

    var i = debug_arc_index;

    if (keyboard_check_pressed(ord("J"))) air_arc_x1[i] -= 1;
    if (keyboard_check_pressed(ord("L"))) air_arc_x1[i] += 1;

    if (keyboard_check_pressed(ord("I"))) air_arc_y1[i] -= 1;
    if (keyboard_check_pressed(ord("K"))) air_arc_y1[i] += 1;

    if (keyboard_check_pressed(ord("A"))) air_arc_x2[i] -= 1;
    if (keyboard_check_pressed(ord("D"))) air_arc_x2[i] += 1;

    if (keyboard_check_pressed(ord("W"))) air_arc_y2[i] -= 1;
    if (keyboard_check_pressed(ord("S"))) air_arc_y2[i] += 1;

    if (keyboard_check_pressed(ord("Q"))) air_arc_thickness[i] -= 1;
    if (keyboard_check_pressed(ord("E"))) air_arc_thickness[i] += 1;

    air_arc_thickness[i] = max(1, air_arc_thickness[i]);
}

if (global.debug)
{
    if (keyboard_check_pressed(ord("1"))) debug_arc_index = 0;
    if (keyboard_check_pressed(ord("2"))) debug_arc_index = 1;
    if (keyboard_check_pressed(ord("3"))) debug_arc_index = 2;
    if (keyboard_check_pressed(ord("4"))) debug_arc_index = 3;
	if (keyboard_check_pressed(ord("5"))) debug_arc_index = 4;

    var i = debug_arc_index;

    if (keyboard_check_pressed(ord("J"))) arc_x1[i] -= 1;
    if (keyboard_check_pressed(ord("L"))) arc_x1[i] += 1;

    if (keyboard_check_pressed(ord("I"))) arc_y1[i] -= 1;
    if (keyboard_check_pressed(ord("K"))) arc_y1[i] += 1;

    if (keyboard_check_pressed(ord("A"))) arc_x2[i] -= 1;
    if (keyboard_check_pressed(ord("D"))) arc_x2[i] += 1;

    if (keyboard_check_pressed(ord("W"))) arc_y2[i] -= 1;
    if (keyboard_check_pressed(ord("S"))) arc_y2[i] += 1;

    if (keyboard_check_pressed(ord("Q"))) arc_thickness[i] -= 1;
    if (keyboard_check_pressed(ord("E"))) arc_thickness[i] += 1;

    arc_thickness[i] = max(1, arc_thickness[i]);

    show_debug_message(
        "arc[" + string(i) + "] = " +
        "x1:" + string(arc_x1[i]) + " " +
        "y1:" + string(arc_y1[i]) + " " +
        "x2:" + string(arc_x2[i]) + " " +
        "y2:" + string(arc_y2[i]) + " " +
        "thick:" + string(arc_thickness[i])
    );
}

if (global.debug && keyboard_check_pressed(ord("Y")))
{
    debug_no_gravity = !debug_no_gravity;
}

if (instance_exists(interact_target))
{
    if (keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_face1))
    {
        interact_target.activate();
    }
}

interact_target = noone;
