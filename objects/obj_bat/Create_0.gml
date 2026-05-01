// Inherit the parent event
event_inherited();

image_xscale =1;
image_yscale =1;
grav = 0;

spr_idle = noone;
spr_walk = spr_bat
spr_attack = noone;
spr_hurt =noone;
spr_death = noone;

sprite_scale = 2;
sprite_facing = -1;

hp = 5;
hp_max = 5;
move_speed = 3;
attack_damage = 2;
chase_range = 50;
attack_range = 100;

coin_drop_min = 2;
coin_drop_max = 3;
coin_value = 1;
coin_drop_yoffset = -50;

enemy_blocker_object = obj_enemy;

attack_hitbox_x1 = 0;
attack_hitbox_y1 = 0;
attack_hitbox_x2 = 0;
attack_hitbox_y2 = 0;
attack_hitbox_life = 2;
attack_hitbox_thickness = 10;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

rune_drop_x_offset = 0;
rune_drop_y_offset = -75;
rune_value = 1;
rune_sword_chance = 20;
rune_shield_chance = 5;
rune_armor_chance = 5;

path_speed_value = 3;
path_start(bat_path, path_speed_value, path_action_stop, false);
hit_cooldown = 0;