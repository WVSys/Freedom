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
sword_durability = 20;
shield_durability = 25;

helmet_durability_max = 0;
chestplate_durability_max = 0;
greaves_durability_max = 0;
gauntlets_durability_max = 0;
sword_durability_max = 20;
shield_durability_max = 25;

hp_potions = 0;
heal_active = false;
heal_amount_remaining = 0;
heal_tick_timer = 0;

heal_per_tick = 1;
heal_tick_rate = 10; // frames between each heal tick

armor_runes = 0;
shield_runes = 0;
sword_runes = 0;

interact_target = noone;
death_ui_created = false;

move_state = MoveState.IDLE;
combat_state = CombatState.NONE;

invincible_timer = 2;
move_x = 0;

can_say_approach_line = true;
approach_say_cooldown = 0;

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

function take_damage(amount) {
    if (invincible || is_dead) return;

    // Armor only loses durability. No defense scaling yet.
    damage_armor(1);

    hp = clamp(hp - amount, 0, hp_max);

    show_debug_message("HP: " + string(hp));

    if (hp <= 0) {
        hp = 0;
        is_dead = true;
		
		audio_play_sound(character_death, 10, false);
		
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

approach_phrases = [
    "I will avenge you, Father!",
    "I will make them pay!",
    "I'm so sorry, Father.",
    ".......Father, give me strength",
    "I will not rest until they pay!"
];


// ===============================
// Equipment scaling configuration
// ===============================

// Sword
sword_attack_damage_base = 8;
sword_attack_damage_per_level = 2;
sword_durability_base = 20;
sword_durability_per_level = 10;
sword_min_damage_modifier = 0.40; // 0 durability = 40% damage
sword_durability_loss_per_ground_attack = 1;
sword_durability_loss_per_air_attack = 2;

// Shield
shield_guard_meter_base = 15;
shield_guard_meter_per_level = 5;
shield_guard_regen_base = 1;
shield_guard_regen_per_level = 0.25;

shield_durability_base = 25;
shield_durability_per_level = 10;

shield_best_guard_damage_modifier = 0.80; // 100% durability = 20% less guard damage
shield_worst_guard_damage_modifier = 1.10; // 0% durability = 10% more guard damage

shield_durability_loss_multiplier = 1;

// Armor durability scaling only
helmet_durability_per_level = 10;
chestplate_durability_per_level = 12;
greaves_durability_per_level = 9;
gauntlets_durability_per_level = 8;


// Returns 0.0 to 1.0 durability percent.
function get_durability_percent(_current, _max) {
    if (_max <= 0) return 0;
    return clamp(_current / _max, 0, 1);
}


// Recalculate derived equipment stats.
// _refill = true after upgrades/load/start.
// _refill = false when refreshing maxes without repairing.
function refresh_equipment_stats(_refill) {
    // Sword base scaling
    attack_damage = sword_attack_damage_base + (sword_level * sword_attack_damage_per_level);
    sword_durability_max = sword_durability_base + (sword_level * sword_durability_per_level);

    // Shield base scaling
    guard_meter_max = shield_guard_meter_base + (shield_level * shield_guard_meter_per_level);
    guard_regen_per_second = shield_guard_regen_base + (shield_level * shield_guard_regen_per_level);
    guard_recover_threshold = guard_meter_max * 0.25;

    shield_durability_max = shield_durability_base + (shield_level * shield_durability_per_level);

    // Armor durability only
    helmet_durability_max = helmet_level * helmet_durability_per_level;
    chestplate_durability_max = chestplate_level * chestplate_durability_per_level;
    greaves_durability_max = greaves_level * greaves_durability_per_level;
    gauntlets_durability_max = gauntlets_level * gauntlets_durability_per_level;

    if (_refill) {
        sword_durability = sword_durability_max;
        shield_durability = shield_durability_max;

        helmet_durability = helmet_durability_max;
        chestplate_durability = chestplate_durability_max;
        greaves_durability = greaves_durability_max;
        gauntlets_durability = gauntlets_durability_max;

        guard_meter = guard_meter_max;
    } else {
        sword_durability = clamp(sword_durability, 0, sword_durability_max);
        shield_durability = clamp(shield_durability, 0, shield_durability_max);

        helmet_durability = clamp(helmet_durability, 0, helmet_durability_max);
        chestplate_durability = clamp(chestplate_durability, 0, chestplate_durability_max);
        greaves_durability = clamp(greaves_durability, 0, greaves_durability_max);
        gauntlets_durability = clamp(gauntlets_durability, 0, gauntlets_durability_max);

        guard_meter = clamp(guard_meter, 0, guard_meter_max);
    }
}


// Sword still works at 0 durability.
// It just drops to 40% effectiveness.
function get_effective_sword_damage() {
    var durability_percent = get_durability_percent(sword_durability, sword_durability_max);

    var damage_modifier = lerp(
        sword_min_damage_modifier,
        1,
        durability_percent
    );

    return max(1, round(attack_damage * damage_modifier));
}


// Shield still works at 0 durability.
// Full durability gives 20% guard damage reduction.
// Zero durability gives 10% extra guard damage taken.
function get_effective_guard_damage(_incoming_damage) {
    var durability_percent = get_durability_percent(shield_durability, shield_durability_max);

    var guard_damage_modifier = lerp(
        shield_worst_guard_damage_modifier,
        shield_best_guard_damage_modifier,
        durability_percent
    );

    return max(1, ceil(_incoming_damage * guard_damage_modifier));
}


function damage_sword(_amount) {
    if (!sword) return;

    sword_durability = max(0, sword_durability - _amount);
}


function damage_shield(_amount) {
    if (!shield) return;

    var durability_loss = max(1, ceil(_amount * shield_durability_loss_multiplier));
    shield_durability = max(0, shield_durability - durability_loss);
}


// Armor does not reduce damage yet.
// It only wears down when the player takes damage.
function damage_armor(_amount) {
    var pieces = [];

    if (helmet_durability > 0) array_push(pieces, "Helmet");
    if (chestplate_durability > 0) array_push(pieces, "Chestplate");
    if (greaves_durability > 0) array_push(pieces, "Greaves");
    if (gauntlets_durability > 0) array_push(pieces, "Gauntlets");

    if (array_length(pieces) <= 0) return;

    var piece = pieces[irandom(array_length(pieces) - 1)];
    var wear = max(1, _amount);

    switch (piece) {
        case "Helmet":
            helmet_durability = max(0, helmet_durability - wear);
            break;

        case "Chestplate":
            chestplate_durability = max(0, chestplate_durability - wear);
            break;

        case "Greaves":
            greaves_durability = max(0, greaves_durability - wear);
            break;

        case "Gauntlets":
            gauntlets_durability = max(0, gauntlets_durability - wear);
            break;
    }
}


// Initialize base equipment stats.
// This fixes sword/shield starting with max durability of 0.
refresh_equipment_stats(true);