function enemy_attack() {
    hsp = 0;

    if (!instance_exists(obj_character)) {
        state = EnemyState.IDLE;
        attack_active = false;
        exit;
    }

    var dist = point_distance(x, y, obj_character.x, obj_character.y);

    // Face the player
    if (obj_character.x < x) {
        facing = -1;
    } else {
        facing = 1;
    }

    image_xscale = facing;

    // Player moved away, go back to chasing
    if (dist > attack_range) {
        state = EnemyState.CHASE;
        attack_active = false;
        exit;
    }

    // Spawn one hitbox during the attack animation
    if (!attack_active && image_index >= 2) {
        spawn_attack_hitbox(
            id,
            attack_hitbox_offset_x,
            attack_hitbox_offset_y,
            attack_damage,
            attack_hitbox_life,
            attack_hitbox_sprite
        );

        attack_cooldown = attack_cooldown_max;
        attack_active = true;
    }

    // End attack only when animation finishes
    if (image_index >= image_number - 1) {
        state = EnemyState.CHASE;
        attack_active = false;
    }
}