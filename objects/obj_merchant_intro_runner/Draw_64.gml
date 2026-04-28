exit;
var gui_w = display_get_gui_width();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// -------------------------
// Tutorial text panels
// -------------------------

if (show_attack_controls)
{
    draw_set_alpha(0.80);
    draw_set_color(c_black);
    draw_rectangle(gui_w / 2 - 220, 70, gui_w / 2 + 220, 180, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(gui_w / 2, 100, "ATTACK");

    draw_set_color(c_yellow);
    draw_text(gui_w / 2, 135, "Keyboard: F");
    draw_text(gui_w / 2, 160, "Gamepad: X");
}

if (show_block_controls)
{
    draw_set_alpha(0.80);
    draw_set_color(c_black);
    draw_rectangle(gui_w / 2 - 220, 70, gui_w / 2 + 220, 180, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(gui_w / 2, 100, "BLOCK");

    draw_set_color(c_yellow);
    draw_text(gui_w / 2, 135, "Keyboard: R");
    draw_text(gui_w / 2, 160, "Gamepad: Left Shoulder");
}

if (show_potion_controls)
{
    draw_set_alpha(0.80);
    draw_set_color(c_black);
    draw_rectangle(gui_w / 2 - 220, 70, gui_w / 2 + 220, 180, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(gui_w / 2, 100, "POTION");

    draw_set_color(c_yellow);
    draw_text(gui_w / 2, 135, "Keyboard: H");
    draw_text(gui_w / 2, 160, "Up Directional Pad");
}

if (show_rune_controls)
{
    draw_set_alpha(0.80);
    draw_set_color(c_black);
    draw_rectangle(gui_w / 2 - 260, 70, gui_w / 2 + 260, 200, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(gui_w / 2, 100, "COINS AND RUNES");

    draw_set_color(c_yellow);
    draw_text(gui_w / 2, 135, "Coins buy supplies and upgrades");
    draw_text(gui_w / 2, 160, "Runes are used to upgrade gear");
    draw_text(gui_w / 2, 185, "Match rune type to equipment type");
}

// -------------------------
// Gamepad visual
// -------------------------

var any_controls_showing =
    show_attack_controls ||
    show_block_controls ||
    show_potion_controls ||
    show_rune_controls;

if (any_controls_showing)
{
    var pad_x = gui_w / 2;
    var pad_y = 300;

    // controller body
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_roundrect(pad_x - 180, pad_y - 70, pad_x + 180, pad_y + 80, false);

    draw_set_alpha(1);
    draw_set_color(c_gray);
    draw_roundrect(pad_x - 165, pad_y - 55, pad_x + 165, pad_y + 65, false);

    // left stick / movement area
    draw_set_color(c_dkgray);
    draw_circle(pad_x - 95, pad_y + 5, 24, false);
    draw_set_color(c_white);
    draw_text(pad_x - 95, pad_y + 5, "L");

    // face buttons positions
    var bx = pad_x + 95;
    var by = pad_y + 5;

    // X / attack - left button
    if (highlight_attack)
    {
        draw_set_color(c_yellow);
    }
    else
    {
        draw_set_color(c_dkgray);
    }
    draw_circle(bx - 30, by, 16, false);
    draw_set_color(c_white);
    draw_text(bx - 30, by, "X");

    // B / block - right button
    if (highlight_block)
    {
        draw_set_color(c_yellow);
    }
    else
    {
        draw_set_color(c_dkgray);
    }
    draw_circle(bx + 30, by, 16, false);
    draw_set_color(c_white);
    draw_text(bx + 30, by, "B");

    // Y / potion - top button
    if (highlight_potion)
    {
        draw_set_color(c_yellow);
    }
    else
    {
        draw_set_color(c_dkgray);
    }
    draw_circle(bx, by - 30, 16, false);
    draw_set_color(c_white);
    draw_text(bx, by - 30, "Y");

    // A / generic confirm / lower button
    draw_set_color(c_dkgray);
    draw_circle(bx, by + 30, 16, false);
    draw_set_color(c_white);
    draw_text(bx, by + 30, "A");

    // rune/coins callout
    if (highlight_rune)
    {
        draw_set_color(c_yellow);
        draw_rectangle(pad_x - 135, pad_y - 35, pad_x - 55, pad_y + 45, true);
        draw_set_color(c_white);
        draw_text(pad_x - 95, pad_y + 50, "Runes");
    }
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);