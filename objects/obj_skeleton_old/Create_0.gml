event_inherited();

state = EnemyState.IDLE;
hp = 100;
hp_max = 100;
hsp = 2;
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

hitbox_type = "damage";

facing = 1; // 1 = right, -1 = left
is_turning = false;

attack_hitbox_x1 = 64;
attack_hitbox_y1 = -14;
attack_hitbox_x2 = 114;
attack_hitbox_y2 = -29;
attack_hitbox_thickness = 3;
attack_active = false;
attack_hitbox_life = 2;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

bones_burst = false;

coins_dropped = false;
coin_drop_min = 1;
coin_drop_max = 3;
coin_value = 1;

function recoil_from_shield(blocker)
{
    if (state == EnemyState.HURT) return;

    var dir = sign(x - blocker.x);

    if (dir == 0)
    {
        dir = blocker.facing;
    }

    hsp = dir * recoil_speed;
    recoil_timer = recoil_duration;

    // IMPORTANT: recoil interrupts attack, so reset attack flags
    attack_active = false;
    attack_cooldown = attack_cooldown_max;

    state = EnemyState.HURT;
    sprite_index = spr_skeleton_damage;
    image_index = 0;
    image_speed = 1;

    show_debug_message("Skeleton recoil triggered");
}

function take_damage(amount)
{
    if (state == EnemyState.DEAD) return;

    hp = clamp(hp-amount,0 , hp_max);
    show_debug_message("Skeleton HP: " + string(hp));

    if (hp <= 0)
    {
        hp = 0;
        state = EnemyState.DEAD;
        hsp = 0;
        vsp = 0;
        recoil_timer = 0;
        attack_active = false;

        sprite_index = spr_skeleton_death;
        image_index = 0;
        image_speed = 0.25;

        exit;
    }

    if (state != EnemyState.HURT)
    {
        var dir = sign(x - obj_character.x);

        if (dir == 0)
        {
            dir = -facing;
        }

        hsp = dir * 1.5;
        recoil_timer = 20;

        state = EnemyState.HURT;
        sprite_index = spr_skeleton_damage;
        image_index = 0;
        image_speed = 1;
    }
}

function state_dead()
{
    hsp = 0;
}


