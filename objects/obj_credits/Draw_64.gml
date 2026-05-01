draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

var cx = display_get_gui_width() * 0.5;

for (var i = 0; i < array_length(credits_text); i++)
{
    var yy = y_offset + (i * 40);
    draw_text(cx, yy, credits_text[i]);
}