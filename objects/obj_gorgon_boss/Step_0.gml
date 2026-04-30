
if (variable_instance_exists(id, "beam_active")) {
    if (beam_active && (state == EnemyState.HURT || state == EnemyState.DEAD)) {
        beam_active = false;
        beam_has_fired = false;
        beam_timer = 0;
        beam_cooldown = beam_cooldown_max;

        attack_active = false;

        // Clear saved beam draw points if you use them
        if (variable_instance_exists(id, "beam_points_valid")) {
            beam_points_valid = false;
            beam_start_x = 0;
            beam_start_y = 0;
            beam_end_x = 0;
            beam_end_y = 0;
        }

        // Destroy any active beam hitboxes owned by this boss
        with (obj_attack_hitbox) {
            if (owner == other.id) {
                instance_destroy();
            }
        }
    }
}


if (!beam_active) {
    event_inherited();
}


if (global.game_paused || global.tutorial_pause) exit;
if (state == EnemyState.DEAD || state == EnemyState.HURT) exit;
if (!instance_exists(obj_character)) exit;
// If beam is NOT active, let parent enemy behavior run
if (!beam_active) {
    event_inherited();
}

if (global.game_paused || global.tutorial_pause) exit;

if (state == EnemyState.DEAD || state == EnemyState.HURT) exit;

if (!instance_exists(obj_character)) exit;

var player = instance_nearest(x, y, obj_character);
var dist = point_distance(x, y, player.x, player.y);

// ===============================
// Eye Beam Cooldown
// ===============================

if (beam_cooldown > 0) {
    beam_cooldown--;
}

// ===============================
// Start Eye Beam Attack
// ===============================

if (!beam_active && beam_cooldown <= 0 && dist > attack_range && dist < beam_range) {
    beam_active = true;
    beam_has_fired = false;
    beam_timer = beam_windup;

    hsp = 0;

    state = EnemyState.ATTACK;
	audio_play_sound(boss_beam_buildup,1,false);
    facing = (player.x < x) ? -1 : 1;
    image_xscale = facing * sprite_scale * sprite_facing;

    var eye_world_x = x + (beam_eye_x * facing);
    var eye_world_y = y + beam_eye_y;

    beam_angle = point_direction(
        eye_world_x,
        eye_world_y,
        player.x,
        player.y
    );

    // Use attack animation for beam windup
    sprite_index = spr_gorgon_boss_special;
    image_index = 0;
    image_speed = 0.5;
}


// ===============================
// Handle Eye Beam Attack
// ===============================

if (beam_active) {
    // Keep boss still while using beam
    hsp = 0;

    beam_timer--;
	if (beam_has_fired) {
		stagger_locked = true;
		audio_stop_sound(boss_beam_buildup);
		audio_play_sound(boss_beam,1,false);	
		beam_particle_timer--;

    if (beam_particle_timer <= 0) {
        beam_particle_timer = beam_particle_spawn_rate;
		
		var particle_face_offset = -25;

        var eye_px = x + ((beam_eye_x + particle_face_offset) * facing);
        var eye_py = y + beam_eye_y - 10;
		

        // Perpendicular direction across the beam width
        var perp_angle = beam_angle + 90;

        for (var i = 0; i < 6; i++) {
            // Spread particles across the beam thickness
            var side_offset = random_range(-beam_thickness, beam_thickness);

            var spawn_x = eye_px + lengthdir_x(side_offset, perp_angle);
            var spawn_y = eye_py + lengthdir_y(side_offset, perp_angle);

            var p = instance_create_layer(
                spawn_x,
                spawn_y,
                "Instances",
                obj_eye_beam_particle
            );

            var p_angle = beam_angle + random_range(-beam_particle_spread, beam_particle_spread);
            var p_speed = random_range(beam_particle_speed_min, beam_particle_speed_max);

            p.hsp = lengthdir_x(p_speed, p_angle);
            p.vsp = lengthdir_y(p_speed, p_angle);

            p.particle_color = c_lime;
            p.particle_size = random_range(3, 7);

            p.life = random_range(room_speed * 0.12, room_speed * 0.28);
            p.life_max = p.life;
        }
    }
}
    // Fire once after windup finishes
    if (!beam_has_fired && beam_timer <= 0) {
        // These world coordinates should match your Draw event exactly
        var start_world_x = x + (beam_eye_x * facing);
        var start_world_y = y + beam_eye_y;

        var end_world_x = start_world_x + lengthdir_x(beam_range, beam_angle);
        var end_world_y = start_world_y + lengthdir_y(beam_range, beam_angle);
		

        // Create hitbox directly instead of using spawn_attack_hitbox()
        var hb = instance_create_layer(x, y, "Instances", obj_attack_hitbox);

        hb.owner = id;
        hb.target_object = obj_character;

        // Store hitbox points relative to boss position
        hb.x1 = start_world_x - x;
        hb.y1 = start_world_y - y;

        hb.x2 = end_world_x - x;
        hb.y2 = end_world_y - y;

        hb.damage = beam_damage;
        hb.lifetime = beam_fire_time;
        hb.thickness = beam_thickness;
        hb.hitbox_type = "damage";

        beam_has_fired = true;
        beam_timer = beam_fire_time;
    }

    // End beam attack after active frames are over
    if (beam_has_fired && beam_timer <= 0) {
        beam_active = false;
        beam_cooldown = beam_cooldown_max;
		
		stagger_locked = false;
        attack_active = false;
        state = EnemyState.CHASE;
    }
}