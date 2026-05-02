// Inherit the parent event
event_inherited();

image_xscale =2.0;
image_yscale = 2.0;

spr_idle = spr_golem_idle;
spr_walk = spr_golem_walk;
spr_attack = spr_golem_atk;
spr_hurt = spr_golem_damage;
spr_death = spr_golem_death;

sprite_scale = 2;
sprite_facing = -1;

hp = 250;
hp_max = 200;
move_speed = 1;
attack_damage = 15;

coin_drop_min = 3;
coin_drop_max = 6;
coin_value = 2;

enemy_blocker_object = obj_enemy;

attack_hitbox_x1 = 53;
attack_hitbox_y1 = -12;
attack_hitbox_x2 = 183;
attack_hitbox_y2 = -10;
attack_hitbox_life = 2;
attack_hitbox_thickness = 16;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

snd_death = golem_death;
snd_attack = golem_attack;
snd_hurt = noone;