if (!global.game_paused)
{
    exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_text(gui_w / 2, gui_h / 2 - 120, "PAUSED");
draw_text(880, 70, "Armor Rune " );
draw_text(880, 95, "Sword Rune " );
draw_text(880, 125, "Shield Rune " );
draw_text(880, 165, "HP potion " );

depth = -10000;
draw_text(150, 40, string(obj_character.hp)+"/"+string(obj_character.hp_max));
draw_text(150, 105, string(obj_character.guard_meter)+"/"+string(obj_character.guard_meter_max));
draw_text(310, 105,"Guard Meter");
draw_text(350, 40,"Health Meter");
draw_text(850, 250,"Keyboard Controls:");
draw_text(850, 280,"Attack: G");
draw_text(850, 310,"Guard: F");
draw_text(850, 340,"HP potion: H");
draw_text(850, 370,"Jump: Spacebar");
draw_text(850, 400,"Movement: Left/Right arrows");
draw_text(850, 430,"Lookup: Up arrow");

var start_x = 100;
var start_y = 600;
var gap = 140;

var equip_x = start_x;

// SWORD
if (obj_character.sword)
{
    draw_text(equip_x, start_y, "Sword");

    draw_text(equip_x, start_y + 20,
        "Atk: " + string(obj_character.get_effective_sword_damage())
    );

    draw_text(equip_x, start_y + 40,
        "Dur: " + string(obj_character.sword_durability) + "/" + string(obj_character.sword_durability_max)
    );

    equip_x += gap;
}

// SHIELD
if (obj_character.shield)
{
    draw_text(equip_x, start_y, "Shield");

    draw_text(equip_x, start_y + 20,
        "Guard: " + string(obj_character.guard_meter) + "/" + string(obj_character.guard_meter_max)
    );

    draw_text(equip_x, start_y + 40,
        "Dur: " + string(obj_character.shield_durability) + "/" + string(obj_character.shield_durability_max)
    );

    equip_x += gap;
}

// HELMET
if (obj_character.helmet)
{
    draw_text(equip_x, start_y, "Helmet");

    draw_text(equip_x, start_y + 20,
        "Dur: " + string(obj_character.helmet_durability) + "/" + string(obj_character.helmet_durability_max)
    );

    equip_x += gap;
}

// CHESTPLATE
if (obj_character.chestplate)
{
    draw_text(equip_x, start_y, "Chestplate");

    draw_text(equip_x, start_y + 20,
        "Dur: " + string(obj_character.chestplate_durability) + "/" + string(obj_character.chestplate_durability_max)
    );

    equip_x += gap;
}

// GREAVES
if (obj_character.greaves)
{
    draw_text(equip_x, start_y, "Greaves");

    draw_text(equip_x, start_y + 20,
        "Dur: " + string(obj_character.greaves_durability) + "/" + string(obj_character.greaves_durability_max)
    );

    equip_x += gap;
}

// GAUNTLETS
if (obj_character.gauntlets)
{
    draw_text(equip_x, start_y, "Gauntlets");

    draw_text(equip_x, start_y + 20,
        "Dur: " + string(obj_character.gauntlets_durability) + "/" + string(obj_character.gauntlets_durability_max)
    );
}




for (var i = 0; i < array_length(pause_options); i++)
{
    var yy = gui_h / 2 - 40 + (i * 40);

    if (i == pause_index)
    {
        draw_set_color(c_yellow);
        draw_text(gui_w / 2, yy, "> " + pause_options[i] + " <");
    }
    else
    {
        draw_set_color(c_white);
        draw_text(gui_w / 2, yy, pause_options[i]);
    }
}

// --------------------
// Controller sprite
// --------------------
var cx = gui_w / 2 + controller_offset_x;
var cy = gui_h / 2 + controller_offset_y;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1);
draw_set_color(c_white);

draw_sprite_ext(spr_gamepad, 0, cx, cy, controller_scale_x, controller_scale_y, 0, c_white, 1);

// --------------------
// Button callouts
// --------------------
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(callout_names); i++)
{
    draw_set_color((debug_callout_move && i == debug_callout_index) ? c_lime : c_yellow);

    draw_arrow(
        cx + callout_label_x[i],
        cy + callout_label_y[i],
        cx + callout_target_x[i],
        cy + callout_target_y[i],
        8
    );

    draw_text(
        cx + callout_label_x[i],
        cy + callout_label_y[i],
        callout_names[i]
    );
}


draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);