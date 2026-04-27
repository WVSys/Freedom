// Inherit the parent event
event_inherited();

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

rune_drop_y_offset = -50;