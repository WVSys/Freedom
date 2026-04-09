function enemy_chase() {
    var dist = point_distance(x, y, obj_character.x, obj_character.y);

    if (dist > chase_range) {
        state = EnemyState.IDLE;
        hsp = 0;
        exit;
    }

    if (dist <= attack_range) {
        state = EnemyState.ATTACK;
        hsp = 0;
        exit;
    }

    var dx = obj_character.x - x;
    var new_facing = sign(dx);

    if (new_facing == 0) {
        hsp = 0;
        exit;
    }

    // start turn only once
    if (new_facing != facing && !is_turning) {
        is_turning = true;
        hsp = 0;
        sprite_index = spr_skeleton_turn;
        image_index = 0;
        image_speed = 1;
        facing = new_facing;
        image_xscale = facing;
        exit;
    }

    // wait for turn animation to finish
    if (is_turning) {
        hsp = 0;

        if (image_index >= image_number - 1) {
            is_turning = false;
            sprite_index = spr_skeleton_walking;
            image_index = 0;
            image_speed = 1;
        }

        exit;
    }

    // normal walking
    sprite_index = spr_skeleton_walking;
    image_xscale = facing;
    hsp = facing * move_speed;
}