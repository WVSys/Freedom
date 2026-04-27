function drop_rune(_x, _y, _value, _sword_chance, _shield_chance, _armor_chance)
{
    var roll = irandom(99);

    _sword_chance = clamp(_sword_chance, 0, 100);
    _shield_chance = clamp(_shield_chance, 0, 100);
    _armor_chance = clamp(_armor_chance, 0, 100);

    var total_sword = _sword_chance;
    var total_shield = total_sword + _shield_chance;
    var total_armor = total_shield + _armor_chance;

    if (total_armor > 100)
    {
        show_debug_message("Rune drop chances exceed 100.");
    }

    var rune_type_to_drop = "none";

    if (roll < total_sword)
    {
        rune_type_to_drop = "sword";
    }
    else if (roll < total_shield)
    {
        rune_type_to_drop = "shield";
    }
    else if (roll < total_armor)
    {
        rune_type_to_drop = "armor";
    }

    if (rune_type_to_drop != "none")
    {
        var rune = instance_create_layer(_x, _y, "Instances", obj_rune);

        rune.rune_type = rune_type_to_drop;
        rune.value = _value;
        rune.set_rune_sprite();

        return rune;
    }

    return noone;
}