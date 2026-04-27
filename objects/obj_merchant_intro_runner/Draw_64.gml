var gui_w = display_get_gui_width();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (show_attack_controls)
{
    draw_set_alpha(0.80);
    draw_set_color(c_black);
    draw_rectangle(gui_w / 2 - 220, 70, gui_w / 2 + 220, 180, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text(gui_w / 2, 100, "ATTACK");

    draw_set_color(c_yellow);
    draw_text(gui_w / 2, 135, "Keyboard: Left Mouse Button");
    draw_text(gui_w / 2, 160, "Gamepad: X / Square");
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
    draw_text(gui_w / 2, 135, "Keyboard: Right Mouse Button");
    draw_text(gui_w / 2, 160, "Gamepad: B / Circle");
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
    draw_text(gui_w / 2, 135, "Keyboard: Q");
    draw_text(gui_w / 2, 160, "Gamepad: Y / Triangle");
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
    draw_text(gui_w / 2, 135, "Coins buy supplies");
    draw_text(gui_w / 2, 160, "Runes upgrade gear");
    draw_text(gui_w / 2, 185, "Match rune type to equipment type");
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);