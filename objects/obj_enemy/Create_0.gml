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

move_speed = 2;
jump_speed = -10;
grav = 0.30;
max_fall = 35;

chase_range = 300;
attack_range = 150;

attack_cooldown = 25;
attack_cooldown_max = 30;
attack_damage = 5;

ground_buffer = 0;
ground_buffer_max = 4;

was_on_ground = false;
landing_timer = 0;
landing_time = 4;

facing = 1;
is_turning = false;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

bones_burst = false;

coins_dropped = false;
coin_drop_min = 1;
coin_drop_max = 3;
coin_value = 1;

target = obj_character;

// child-specific sprite hooks
spr_idle = noone;
spr_walk = noone;
spr_attack = noone;
spr_turn = noone;
spr_hurt = noone;
spr_death = noone;

// child-specific burst object hook
death_burst_object = noone;

// optional enemy blocker object
enemy_blocker_object = object_index;

function enemy_drop_coins()
{
    if (!coins_dropped)
    {
        coins_dropped = true;

        var coin_count = irandom_range(coin_drop_min, coin_drop_max);

        for (var i = 0; i < coin_count; i++)
        {
            var c = instance_create_layer(x, y, "Instances", obj_coin);
            c.value = coin_value;
            c.hsp = random_range(-2.5, 2.5);
            c.vsp = random_range(-5, -2);
        }
    }
}

function enemy_enter_dead_state()
{
    hp = 0;
    state = EnemyState.DEAD;
    hsp = 0;
    vsp = 0;
    recoil_timer = 0;
    attack_active = false;

    if (spr_death != noone)
    {
        sprite_index = spr_death;
        image_index = 0;
        image_speed = 0.25;
    }
}

function enemy_take_damage(amount)
{
    if (state == EnemyState.DEAD) return;

    hp = clamp(hp - amount, 0, hp_max);

    if (hp <= 0)
    {
        enemy_enter_dead_state();
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

        if (spr_hurt != noone)
        {
            sprite_index = spr_hurt;
            image_index = 0;
            image_speed = 1;
        }
    }
}

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

    attack_active = false;
    attack_cooldown = attack_cooldown_max;

    state = EnemyState.HURT;

    if (spr_hurt != noone)
    {
        sprite_index = spr_hurt;
        image_index = 0;
        image_speed = 1;
    }
}

function state_dead()
{
    hsp = 0;
}