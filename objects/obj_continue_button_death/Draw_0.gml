draw_self();

if (focused)
{
    draw_set_alpha(1);
    draw_set_color(c_white);

    draw_rectangle(
        bbox_left - 6,
        bbox_top - 6,
        bbox_right + 6,
        bbox_bottom + 6,
        true
    );

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(x, bbox_bottom + 24, "Press Enter / A");

    draw_set_alpha(1);
}