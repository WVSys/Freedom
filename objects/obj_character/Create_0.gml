enum MoveState {
    IDLE,
    RUN,
    JUMP,
    FALL,
    LAND,
    DEAD
}

enum CombatState {
    NONE,
    ATTACK1,
	AIR_ATTACK,
	GUARD,
}

mask_index = spr_idle_stand1;
is_dead = false;
hp = 100;
hp_max = 100;

main_damage = 10;

guard_meter_max = 15;
guard_meter = guard_meter_max;
guard_damage_cost = 25;
guard_broken = false;
guard_regen_per_second = 1;
guard_recover_threshold = guard_meter_max * 0.25; // can guard again at 25%
is_blocking = false;

speech_cooldown = 0;

helmet = false;
chestplate = false;
greaves = false;
gauntlets = false;
sword = true;
shield = true;

helmet_level = 0;
chestplate_level = 0;
greaves_level = 0;
gauntlets_level = 0;
sword_level = 0;
shield_level = 0;

helmet_durability = 0;
chestplate_durability = 0;
greaves_durability = 0;
gauntlets_durability = 0;
sword_durability = 0;
shield_durability = 0;

helmet_durability_max = 0;
chestplate_durability_max = 0;
greaves_durability_max = 0;
gauntlets_durability_max = 0;
sword_durability_max = 0;
shield_durability_max = 0;

hp_potions = 0;
armor_runes = 0;
shield_runes = 0;
sword_runes = 0;

interact_target = noone;

move_state = MoveState.IDLE;
combat_state = CombatState.NONE;

invincible_timer = 2;
move_x = 0;

hsp = 0;
vsp = 0;

move_speed = 4;
jump_speed = -10;
grav = 0.25;
max_fall = 35;

deadzone = 0.2;
ground_buffer = 0;
ground_buffer_max = 4;

was_on_ground = false;
landing_timer = 0;
landing_time = 4;

air_attack_used = false;
air_attack_active = false;
air_attack_hits_done = 0;
air_attack_max_hits = 3;
air_attack_hit_cooldown = 0;
air_attack_last_target = noone;

invincible = false;

facing = 1;

attack_active = false;
attack_spawned_frame = -1;
attack_damage = 8;
attack_hitbox_life = 2;

attack_hitbox_x1 = 12;
attack_hitbox_y1 = -8;
attack_hitbox_x2 = 70;
attack_hitbox_y2 = 6;
attack_hitbox_thickness = 8;

//tuning arc hitbox
debug_arc_index = 1;

// Arc segment 0: high slash
arc_x1[0] = 7;
arc_y1[0] = -45;
arc_x2[0] = 46;
arc_y2[0] = -33;
arc_thickness[0] = 2;

// Arc segment 1: middle slash
arc_x1[1] = 46;
arc_y1[1] = -33;
arc_x2[1] = 79;
arc_y2[1] = -10;
arc_thickness[1] = 2;

// Arc segment 2: low slash
arc_x1[2] = 79;
arc_y1[2] = -10;
arc_x2[2] = 109;
arc_y2[2] = 20;
arc_thickness[2] = 2;

// Arc segment 3: low slash
arc_x1[3] = 109;
arc_y1[3] = 20;
arc_x2[3] = 105;
arc_y2[3] = 34;
arc_thickness[3] = 2;

// Arc segment 4: low slash
arc_x1[4] = 105;
arc_y1[4] = 34;
arc_x2[4] = 73;
arc_y2[4] = 48;
arc_thickness[4] = 2;

debug_tune_shield = false;
shield_x1 = -2;
shield_y1 = -19;
shield_x2 = -2;
shield_y2 = 30;
shield_thickness = 43;

air_attack_spawned_frame = -1;

air_arc_x1[0] = 26;
air_arc_y1[0] = -47;
air_arc_x2[0] = 46;
air_arc_y2[0] = -34;
air_arc_thickness[0] = 2;

air_arc_x1[1] = 48;
air_arc_y1[1] = -32;
air_arc_x2[1] = 66;
air_arc_y2[1] = -16;
air_arc_thickness[1] = 2;

air_arc_x1[2] = 68;
air_arc_y1[2] = -14;
air_arc_x2[2] = 98;
air_arc_y2[2] = 22;
air_arc_thickness[2] = 2;

air_arc_x1[3] = 96;
air_arc_y1[3] = 26;
air_arc_x2[3] = 73;
air_arc_y2[3] = 20;
air_arc_thickness[3] = 2;

air_arc_x1[4] = 70;
air_arc_y1[4] = 19;
air_arc_x2[4] = 45;
air_arc_y2[4] = 10;
air_arc_thickness[4] = 2;

debug_no_gravity = false;

function take_damage(amount)
{
    if (invincible || is_dead) return;
    hp = clamp(hp - amount, 0, hp_max);
    show_debug_message("HP: " + string(hp));

    if (hp <= 0)
    {
        hp = 0;
        is_dead = true;
        move_state = MoveState.DEAD;
        combat_state = CombatState.NONE;

        hsp = 0;
        vsp = 0;

        sprite_index = spr_character_dead;
        image_index = 0;
        image_speed = 1;

        exit;
    }

    invincible = true;
    alarm[0] = 20;
}

function say(_text)
{
    // Reuse existing bubble instead of stacking
    var existing = noone;

    with (obj_speech_bubble)
    {
        if (owner == other.id)
        {
            existing = id;
        }
    }

    if (existing != noone)
    {
        existing.text = _text;
        existing.lifetime = 180;
        return;
    }

    var bubble = instance_create_depth(x, y, -10000, obj_speech_bubble);
    bubble.owner = id;
    bubble.text = _text;
	
	bubble.x_offset = 0;
    bubble.y_offset = -95;
}