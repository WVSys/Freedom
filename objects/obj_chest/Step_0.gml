
if (!opened && place_meeting(x, y, obj_character))
{
    opened = true;
	audio_play_sound(chest_opening, 1, false);
    // start open animation properly
    sprite_index = spr_open;
    image_index = 0;
    image_speed = 1;

    // ---- DROP COINS ----
    var coin_amount = irandom_range(50, 100);

    repeat (coin_amount)
    {
        var c = instance_create_layer(x, y, "Instances", obj_coin);
        c.hsp = random_range(-2, 2);
        c.vsp = random_range(-12, -7);
    }

    // ---- DROP RUNES ----
    var armor_amt  = irandom_range(5, 10);
    var shield_amt = irandom_range(5, 10);
    var sword_amt  = irandom_range(5, 10);

    // Armor runes
    repeat (armor_amt)
    {
        var r = instance_create_layer(x, y, "Instances", obj_rune);
        r.rune_type = "armor";
        r.set_rune_sprite();
    }

    // Shield runes
    repeat (shield_amt)
    {
        var r = instance_create_layer(x, y, "Instances", obj_rune);
        r.rune_type = "shield";
        r.set_rune_sprite();
    }

    // Sword runes
    repeat (sword_amt)
    {
        var r = instance_create_layer(x, y, "Instances", obj_rune);
        r.rune_type = "sword";
        r.set_rune_sprite();
    }
}


if (opened && sprite_index == spr_open)
{
    if (image_index >= image_number - 1)
    {
        image_index = image_number - 1;
        image_speed = 0;
    }
}