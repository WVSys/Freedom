function enemy_attack() {
    hsp = 0;

    // No player exists, stop attacking
    if (!instance_exists(obj_character)) {
        state = EnemyState.IDLE;
        attack_active = false;
        exit;
    }

    // Distance to player
    var dist = point_distance(x, y, obj_character.x, obj_character.y);

    // Face the player
    facing = (obj_character.x < x) ? -1 : 1;
    image_xscale = facing;

    // If player leaves attack range, chase again
    if (dist > attack_range) {
        state = EnemyState.CHASE;
        attack_active = false;
        exit;
    }

    // Spawn one hitbox during the attack animation
    if (!attack_active && image_index >= 2) {
        spawn_attack_hitbox(
            id,
            obj_character,
            attack_hitbox_x1,
            attack_hitbox_y1,
            attack_hitbox_x2,
            attack_hitbox_y2,
            attack_damage,
            attack_hitbox_life,
            attack_hitbox_thickness
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