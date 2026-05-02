// Inherit the parent event
event_inherited();

hp = 15;
hp_max = 15;
spr_idle = noone;
spr_walk = spr_green_slime;
spr_attack = noone;
spr_turn = noone;
spr_hurt = spr_green_slime_dead;
spr_death = spr_green_slime_dead;

attack_damage = 2;
attack_range = 95;

recoil_speed = 2.5;

coins_dropped = false;
coin_drop_min = 1;
coin_drop_max = 2;
coin_value = 1;
coin_drop_yoffset = -50;

rune_drop_y_offset = -50;

snd_death = slime_death;
snd_attack = noone;
snd_hurt = slime_hurt;