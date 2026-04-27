if (!global.game_paused)
{
    exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.65);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_text(gui_w / 2, gui_h / 2 - 120, "PAUSED");

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

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);