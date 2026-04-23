function enemy_attack() {
    hsp = 0;

    if (!instance_exists(obj_character)) {
        state = EnemyState.IDLE;
        attack_active = false;
        exit;
    }

    var target = instance_nearest(x, y, obj_character);
    var dist = point_distance(x, y, target.x, target.y);

    facing = (target.x < x) ? -1 : 1;
    image_xscale = facing * sprite_scale * sprite_facing;
    image_yscale = sprite_scale;

    if (dist > attack_range) {
        state = EnemyState.CHASE;
        attack_active = false;
        exit;
    }

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

    if (image_index >= image_number - 1) {
        state = EnemyState.CHASE;
        attack_active = false;
    }
}