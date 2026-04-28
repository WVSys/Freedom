// Inherit the parent event
event_inherited();

image_xscale =1;
image_yscale =1;

spr_idle = spr_gorgon_boss_idle;
spr_walk = spr_gorgon_boss_walk;
spr_attack = spr_gorgon_boss_attack3;
spr_hurt =spr_gorgon_boss_hurt;
spr_death = spr_gorgon_boss_death;

sprite_scale = 2;
sprite_facing = 1;

hp = 100;
hp_max = 100;
move_speed = 1;
attack_damage = 10;

coin_drop_min = 100;
coin_drop_max = 1000;
coin_value = 2;
coin_drop_yoffset = -50;

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

rune_drop_x_offset = 0;
rune_drop_y_offset = -75;
rune_value = 1;
rune_sword_chance = 100;
rune_shield_chance = 0;
rune_armor_chance = 0;
