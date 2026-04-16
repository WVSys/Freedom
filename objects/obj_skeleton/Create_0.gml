enum EnemyState {
    IDLE,
    CHASE,
    ATTACK,
	TURN,
    HURT,
    DEAD
}

state = EnemyState.IDLE;
hp = 100;
hp_max = 100;
hsp = 0;
vsp = 0;
chase_range = 300;
attack_range = 150;
target = obj_character;
attack_cooldown = 25;
attack_cooldown_max = 30;
attack_damage = 5;

move_speed = 2;
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

attack_hitbox_x1 = 64;
attack_hitbox_y1 = -14;
attack_hitbox_x2 = 114;
attack_hitbox_y2 = -29;
attack_hitbox_thickness = 3;
attack_active = false;
attack_hitbox_life = 2;

function take_damage(amount)
{
    hp = clamp(hp-amount, 0, hp_max);
    show_debug_message("Skeleton HP: " + string(hp));

    if (hp <= 0)
    {
        instance_destroy();
    }
}