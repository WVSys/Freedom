
if (global.debug)
{	depth = -100000;
    var start_x = x + x1;
    var start_y = y + y1;
    var end_x   = x + x2;
    var end_y   = y + y2;

    draw_set_alpha(0.45);

    if (hitbox_type == "damage")
    {
        draw_set_color(c_red);
    }
    else if (hitbox_type == "guard")
    {
        draw_set_color(c_aqua);
    }
    else
    {
        draw_set_color(c_lime);
    }

    draw_line_width(
        start_x,
        start_y,
        end_x,
        end_y,
        thickness * 2
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_line_width(start_x, start_y, end_x, end_y, 1);

    draw_set_color(c_blue);
    draw_circle(start_x, start_y, 4, false);

    draw_set_color(c_fuchsia);
    draw_circle(end_x, end_y, 4, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
}