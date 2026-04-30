// Inherit the parent event
event_inherited();

hp = 100;
hp_max = 100;
hsp = 0;
vsp = 0;
chase_range = 300;
attack_range = 140;
target = obj_character;
attack_cooldown = 25;
attack_cooldown_max = 30;
attack_damage = 5;

move_speed = 2;
jump_speed = -10;
grav = 0.30;
max_fall = 35;

deadzone = 0.2;
ground_buffer = 0;
ground_buffer_max = 4;

was_on_ground = false;
landing_timer = 0;
landing_time = 4;

hitbox_type = "damage";

facing = 1; // 1 = right, -1 = left
is_turning = false;

attack_hitbox_x1 = 64;
attack_hitbox_y1 = -14;
attack_hitbox_x2 = 114;
attack_hitbox_y2 = -29;
attack_hitbox_thickness = 3;
attack_active = false;
attack_hitbox_life = 2;

recoil_timer = 0;
recoil_speed = 2.5;
recoil_duration = 35;

bones_burst = false;

coins_dropped = false;
coin_drop_min = 1;
coin_drop_max = 3;
coin_value = 1;

snd_death = skeleton_death;
snd_attack = noone;
snd_hurt = noone;

spr_idle = spr_skeleton_idle;
spr_walk = spr_skeleton_walking;
spr_attack = spr_skeleton_attack;
spr_hurt = spr_skeleton_damage;
spr_death = spr_skeleton_death;

function state_dead()
{
	show_debug_message("SKELETON state_dead");
    show_debug_message("image_index=" + string(image_index) + " image_number=" + string(image_number));
    hsp = 0;
    vsp = 0;

    if (!bones_burst && image_index >= 2)
    {
        bones_burst = true;

        var burst = instance_create_layer(x, y, "Instances", obj_bone_burst);
        burst.start_xscale = image_xscale;
    }

    if (image_index >= image_number - 1)
    {
        instance_destroy();
    }
}