enum MoveState {
    IDLE,
    RUN,
    JUMP,
    FALL,
	LAND
}

enum CombatState {
    NONE,
    ATTACK1,
	AIR_ATTACK,
	GUARD,
}
hp = 100
hp_max = 100;

move_state = MoveState.IDLE;
combat_state = CombatState.NONE;

is_blocking = false;
invincible_timer = 2;
move_x = 0;

hsp = 0;
vsp = 0;

move_speed = 4;
jump_speed = -10;
grav = 0.25;
max_fall = 35;

deadzone = 0.2;
ground_buffer = 0;
ground_buffer_max = 4;

was_on_ground = false;
landing_timer = 0;
landing_time = 4;

air_attack_used = false;
air_attack_active = false;
air_attack_hits_done = 0;
air_attack_max_hits = 3;
air_attack_hit_cooldown = 0;
air_attack_last_target = noone;

invincible = false;

function take_damage(amount)
{
    if (invincible) return;

    hp -= amount;
    show_debug_message("HP: " + string(hp));

    invincible = true;
    alarm[0] = 20;
}
