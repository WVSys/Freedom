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

// enemy unstuck
last_free_x = x;
last_free_y = y;

snd_death = noone;
snd_attack = noone;
snd_hurt = noone;

elite = false;
elite_red_amount = 0.25;
elite_outline_color = c_yellow;
elite_outline_thickness = 4;

hsp = 0;
vsp = 0;
target = obj_character;
enemy_blocker_object = object_index;
move_speed = 2;
grav = 0.30;
max_fall = 35;

sprite_scale = 1;
sprite_facing = 1;

image_xscale = sprite_scale * sprite_facing;
image_yscale = sprite_scale;

chase_range = 300;
attack_range = 150;

attack_cooldown = 25;
attack_cooldown_max = 30;
attack_damage = 5;
attack_active = false;

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

rune_drop_x_offset = 0;
rune_drop_y_offset = 0;
rune_value = 1;
rune_sword_chance = 20;
rune_shield_chance = 25;
rune_armor_chance = 30;

// optional animation hooks
spr_idle = noone;
spr_walk = noone;
spr_attack = noone;
spr_turn = noone;
spr_hurt = noone;
spr_death = noone;

attack_active = false;

attack_hitbox_x1 = 0;
attack_hitbox_y1 = 0;
attack_hitbox_x2 = 32;
attack_hitbox_y2 = 0;
attack_hitbox_life = 3;
attack_hitbox_thickness = 12;

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
    sprite_index = spr_hurt;
    image_index = 0;
    image_speed = 1;

    show_debug_message("Enemy recoil triggered");
}

function enemy_drop_coins()
{
    if (!coins_dropped)
    {
        coins_dropped = true;

        var coin_count = irandom_range(coin_drop_min, coin_drop_max);

        for (var i = 0; i < coin_count; i++)
        {
            var c = instance_create_layer(x, y-25, "Instances", obj_coin);
            c.value = coin_value;
            c.hsp = random_range(-2.5, 2.5);
            c.vsp = random_range(-6, -1);
        }
    }
}

function enemy_enter_dead_state()
{
    hp = 0;
    state = EnemyState.DEAD;
	
	if (snd_death != noone) {
        audio_play_sound(snd_death, 1, false);
    }
	
    hsp = 0;
    vsp = 0;
    recoil_timer = 0;

    if (spr_death != noone)
    {
        sprite_index = spr_death;
        image_index = 0;
        image_speed = 0.25;
    }
}

function take_damage(amount)
{
    if (state == EnemyState.DEAD) return;

    hp = clamp(hp - amount, 0, hp_max);
	
	 if (hp > 0 && snd_hurt != noone) {
        audio_play_sound(snd_hurt, 10, false);
    }

    if (hp <= 0)
    {
        enemy_enter_dead_state();
        exit;
    }

    if (state != EnemyState.HURT)
    {
        var dir = sign(x - obj_character.x);
        if (dir == 0) dir = -facing;

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

function state_dead()
{
	show_debug_message("PARENT state_dead");

    hsp = 0;
    vsp = 0;

    if (image_index >= image_number - 1)
    {
        instance_destroy();
    }
}