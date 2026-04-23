function enemy_chase() {
    if (!instance_exists(obj_character)) {
        state = EnemyState.IDLE;
        hsp = 0;
        exit;
    }

    var target = instance_nearest(x, y, obj_character);
    var dist = point_distance(x, y, target.x, target.y);

    if (dist > chase_range) {
        state = EnemyState.IDLE;
        hsp = 0;
        exit;
    }

    if (dist <= attack_range) {
        state = EnemyState.ATTACK;
        hsp = 0;
        attack_active = false;
        exit;
    }

    var dx = target.x - x;
    facing = sign(dx);

    if (facing == 0) {
        hsp = 0;
        exit;
    }

    image_xscale = facing * sprite_scale * sprite_facing;
    image_yscale = sprite_scale;

    if (spr_walk != noone) {
        sprite_index = spr_walk;
        image_speed = 1;
    }

    hsp = facing * move_speed;
}