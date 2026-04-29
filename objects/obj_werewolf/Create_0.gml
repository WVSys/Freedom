// Inherit the parent event
event_inherited();

image_xscale =1;
image_yscale =1;

spr_idle = spr_werewolf_idle;
spr_walk = spr_werewolf_walk;
spr_attack = spr_werewolf_attack2;
spr_hurt =spr_werewolf_hurt;
spr_death = spr_werewolf_dead;

elite = true;
elite_red_amount = 0.25;
elite_outline_color = c_yellow;
elite_outline_thickness = 4;

sprite_scale = 2;
sprite_facing = 1;

hp = 150;
hp_max = 150;
move_speed = 2;
attack_damage = 15;

coin_drop_min = 5;
coin_drop_max = 10;
coin_value = 1;
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
rune_sword_chance = 50;
rune_shield_chance = 20;
rune_armor_chance = 25;
