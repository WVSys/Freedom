function enemy_turn() {
    hsp = 0;
    sprite_index = spr_skeleton_turn;
    image_speed = 1;

    if (image_index >= image_number - 1) {
        facing = turn_to;
        image_xscale = facing;
        image_index = 0;
        state = EnemyState.CHASE;
    }
}