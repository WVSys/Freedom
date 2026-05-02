// Inherit the parent event
event_inherited();

image_xscale =1;
image_yscale =1;

beam_particle_spawn_rate = 2; // lower = more particles
beam_particle_timer = 0;

beam_particle_speed_min = 2;
beam_particle_speed_max = 5;

beam_particle_spread = 18;

beam_particle_count = 8;
beam_particle_spread = 14;
beam_particle_length_min = 8;
beam_particle_length_max = 22;

spr_idle = spr_gorgon_boss_idle;
spr_walk = spr_gorgon_boss_walk;
spr_attack = spr_gorgon_boss_attack3;
spr_hurt =spr_gorgon_boss_hurt;
spr_death = spr_gorgon_boss_death;

sprite_scale = 2;
sprite_facing = 1;

hp = 1000;
hp_max = 1000;
move_speed = 1;
attack_damage = 10;

coin_drop_min = 100;
coin_drop_max = 1000;
coin_value = 2;
coin_drop_yoffset = -50;

enemy_blocker_object = obj_enemy;

snd_death = Gorgon_death_scream;
snd_attack = noone;
snd_hurt = noone;

stagger_locked = false;

attack_hitbox_x1 = 10;
attack_hitbox_y1 = -30;
attack_hitbox_x2 = 113;
attack_hitbox_y2 = -44;
attack_hitbox_life = 2;
attack_hitbox_thickness = 18;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 10;
recoil_cooldown = 0;

rune_drop_x_offset = 0;
rune_drop_y_offset = -75;
rune_value = 1;
rune_sword_chance = 100;
rune_shield_chance = 0;
rune_armor_chance = 0;

beam_angle = 0;
// eye beam special attack
beam_cooldown = 180;
beam_cooldown_max = 180;

beam_windup = 45;
beam_fire_time = 18;
beam_timer = 0;

beam_active = false;
beam_has_fired = false;

beam_damage = 20;
beam_range = 900;
beam_thickness = 5;

// eye position relative to boss origin.
// tune these numbers in-game.
beam_eye_x = 45;
beam_eye_y = -120;