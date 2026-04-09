enum EnemyState {
    IDLE,
    CHASE,
    ATTACK,
	TURN,
    HURT,
    DEAD
}

state = EnemyState.IDLE;

hsp = 0;
vsp = 0;
chase_range = 300;
attack_range = 150;
hp = 3;
target = obj_character;
attack_cooldown = 0;
attack_cooldown_max = 25;
attack_damage = 5;

move_speed = 3;
jump_speed = -10;
grav = 0.30;
max_fall = 35;

deadzone = 0.2;
ground_buffer = 0;
ground_buffer_max = 4;

was_on_ground = false;
landing_timer = 0;
landing_time = 4;

facing = 1; // 1 = right, -1 = left
is_turning = false;

attack_hitbox_sprite = spr_hitbox_sword;
attack_hitbox_offset_x = 100;
attack_hitbox_offset_y = -16;
attack_hitbox_life = 4;
attack_active = false;