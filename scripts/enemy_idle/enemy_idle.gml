function enemy_idle(){
	var dist = point_distance(x, y, obj_character.x, obj_character.y);

    if (dist <= chase_range) {
        state = EnemyState.CHASE;
    }
}