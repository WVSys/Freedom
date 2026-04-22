enum EnemiesState {
    IDLE,
    CHASE,
    ATTACK,
    TURN,
    HURT,
    DEAD
}

state = EnemiesState.IDLE;

hp = 100;
hp_max = 100;

hsp = 0;
vsp = 0;

move_speed = 2;
grav = 0.30;
max_fall = 35;

chase_range = 300;
attack_range = 150;

attack_cooldown = 25;
attack_cooldown_max = 30;
attack_damage = 5;

ground_buffer = 0;
ground_buffer_max = 4;

facing = 1;
is_turning = false;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

coins_dropped = false;
coin_drop_min = 1;
coin_drop_max = 3;
coin_value = 1;

// optional animation hooks
spr_idle_anim = noone;
spr_walk_anim = noone;
spr_attack_anim = noone;
spr_turn_anim = noone;
spr_hurt_anim = noone;
spr_death_anim = noone;

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
    state = EnemiesState.DEAD;
    hsp = 0;
    vsp = 0;
    recoil_timer = 0;

    if (spr_death_anim != noone)
    {
        sprite_index = spr_death_anim;
        image_index = 0;
        image_speed = 0.25;
    }
}

function enemy_take_damage(amount)
{
    if (state == EnemiesState.DEAD) return;

    hp = clamp(hp - amount, 0, hp_max);

    if (hp <= 0)
    {
        enemy_enter_dead_state();
        exit;
    }

    if (state != EnemiesState.HURT)
    {
        var dir = sign(x - obj_character.x);
        if (dir == 0) dir = -facing;

        hsp = dir * 1.5;
        recoil_timer = 20;
        state = EnemiesState.HURT;

        if (spr_hurt_anim != noone)
        {
            sprite_index = spr_hurt_anim;
            image_index = 0;
            image_speed = 1;
        }
    }
}