menu_mode = "category";
category_index = 0;
action_index = 0;
can_interact = true; // for tutorial

categories = [];
array_push(categories, "Save");

if (obj_character.helmet)     array_push(categories, "Helmet");
if (obj_character.chestplate) array_push(categories, "Chestplate");
if (obj_character.greaves)    array_push(categories, "Greaves");
if (obj_character.gauntlets)  array_push(categories, "Gauntlets");
if (obj_character.sword)      array_push(categories, "Sword");
if (obj_character.shield)     array_push(categories, "Shield");

array_push(categories, "HP Potion");

actions = ["Upgrade", "Repair"];

stick_deadzone = 0.5;
stick_ready_y = true;
stick_ready_x = true;

message = "";
message_timer = 0;

function menu_get_item_display_stats(item_name) {
    var level = get_item_level(item_name);
    var durability = get_item_durability(item_name);
    var durability_max = get_item_max_durability(item_name);

    var attack = 0;
    var effective_attack = 0;
    var guard_max = 0;
    var guard_regen = 0;

    switch (item_name) {
        case "Sword":
            attack = obj_character.sword_attack_damage_base
                + (obj_character.sword_level * obj_character.sword_attack_damage_per_level);

            if (durability_max <= 0) {
                durability_max = obj_character.sword_durability_base
                    + (obj_character.sword_level * obj_character.sword_durability_per_level);
            }


            var durability_percent = 0;
            if (durability_max > 0) {
                durability_percent = clamp(durability / durability_max, 0, 1);
            }

            var damage_modifier = lerp(
                obj_character.sword_min_damage_modifier,
                1,
                durability_percent
            );

            effective_attack = max(1, round(attack * damage_modifier));
            break;

        case "Shield":
            guard_max = obj_character.shield_guard_meter_base
                + (obj_character.shield_level * obj_character.shield_guard_meter_per_level);

            guard_regen = obj_character.shield_guard_regen_base
                + (obj_character.shield_level * obj_character.shield_guard_regen_per_level);

            if (durability_max <= 0) {
                durability_max = obj_character.shield_durability_base
                    + (obj_character.shield_level * obj_character.shield_durability_per_level);
            }

            break;

        case "Helmet":
            if (durability_max <= 0) {
                durability_max = obj_character.helmet_level * obj_character.helmet_durability_per_level;
            }
            break;

        case "Chestplate":
            if (durability_max <= 0) {
                durability_max = obj_character.chestplate_level * obj_character.chestplate_durability_per_level;
            }
            break;

        case "Greaves":
            if (durability_max <= 0) {
                durability_max = obj_character.greaves_level * obj_character.greaves_durability_per_level;
            }
            break;

        case "Gauntlets":
            if (durability_max <= 0) {
                durability_max = obj_character.gauntlets_level * obj_character.gauntlets_durability_per_level;
            }
            break;
    }

    durability = clamp(durability, 0, durability_max);

    return {
        level: level,
        durability: durability,
        durability_max: durability_max,
        attack: attack,
        effective_attack: effective_attack,
        guard_max: guard_max,
        guard_regen: guard_regen
    };
}