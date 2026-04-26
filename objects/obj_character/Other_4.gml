with (obj_player_spawn)
{
    if (spawn_id == global.next_spawn)
    {
        other.x = x;
        other.y = y;
    }
}

if (global.respawn_from_checkpoint)
{
    load_checkpoint();

    var sp = instance_find(obj_respawn_spawn, 0);

    if (sp != noone)
    {
        x = sp.x;
        y = sp.y;
    }

    hp = clamp(global.saved_hp, 0, hp_max);
    guard_meter = clamp(global.saved_guard, 0, guard_meter_max);

    helmet = global.saved_helmet;
    chestplate = global.saved_chestplate;
    greaves = global.saved_greaves;
    gauntlets = global.saved_gauntlets;
    sword = global.saved_sword;
    shield = global.saved_shield;

    helmet_level = global.saved_helmet_level;
    chestplate_level = global.saved_chestplate_level;
    greaves_level = global.saved_greaves_level;
    gauntlets_level = global.saved_gauntlets_level;
    sword_level = global.saved_sword_level;
    shield_level = global.saved_shield_level;

    helmet_durability = global.saved_helmet_durability;
    chestplate_durability = global.saved_chestplate_durability;
    greaves_durability = global.saved_greaves_durability;
    gauntlets_durability = global.saved_gauntlets_durability;
    sword_durability = global.saved_sword_durability;
    shield_durability = global.saved_shield_durability;

    helmet_durability_max = global.saved_helmet_durability_max;
    chestplate_durability_max = global.saved_chestplate_durability_max;
    greaves_durability_max = global.saved_greaves_durability_max;
    gauntlets_durability_max = global.saved_gauntlets_durability_max;
    sword_durability_max = global.saved_sword_durability_max;
    shield_durability_max = global.saved_shield_durability_max;

    global.coins = global.saved_coins;
    armor_runes = global.saved_armor_runes;
    shield_runes = global.saved_shield_runes;
    sword_runes = global.saved_sword_runes;
    hp_potions = global.saved_hp_potions;

    is_dead = false;
    invincible = false;

    combat_state = CombatState.NONE;
    move_state = MoveState.IDLE;

    hsp = 0;
    vsp = 0;

    attack_active = false;
    air_attack_used = false;
    air_attack_active = false;
    air_attack_hits_done = 0;
    air_attack_hit_cooldown = 0;
    air_attack_last_target = noone;
    air_attack_spawned_frame = -1;

    is_blocking = false;
    interact_target = noone;

    sprite_index = spr_idle_stand1;
    image_index = 0;
    image_speed = 1;

    global.respawn_from_checkpoint = false;
}