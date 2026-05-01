var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(cx, cy - 60, "The End");

if (option == 0)
{
    draw_text(cx, cy, "> Restart");
    draw_text(cx, cy + 40, "Quit");
}
else
{
    draw_text(cx, cy, "Restart");
    draw_text(cx, cy + 40, "> Quit");
}