hsp = random_range(-2, 2);
vsp = random_range(-4, -2);
grav = 0.3;
landed = false;

value = 1;

// Default type in case enemy does not set it
rune_type = "none";

image_speed = 1;

function set_rune_sprite()
{
    switch (rune_type)
    {
        
        case "sword":
            sprite_index = spr_sword_rune;
            break;

        case "shield":
            sprite_index = spr_shield_rune;
            break;

        case "armor":
            sprite_index = spr_armor_rune;
            break;

    }
}

function pickup_effect()
{
    switch (rune_type)
    {
        case "sword":
            obj_character.sword_runes += value;
            break;

        case "shield":
            obj_character.shield_runes += value;
            break;

        case "armor":
            obj_character.armor_runes += value;
            break;
    }
}