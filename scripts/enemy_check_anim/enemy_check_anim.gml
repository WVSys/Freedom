function enemy_check_anim(){
	if (state == EnemyState.TURN) exit;
    if (state == EnemyState.ATTACK) exit;

    sprite_index = spr_skeleton_walking;

    if (x != xprevious) {
        image_speed = 1;
    } else {
        image_speed = 0;
        image_index = 0;
    }
}