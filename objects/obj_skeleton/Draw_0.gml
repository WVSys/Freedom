draw_self();

if (global.debug)
{
    var start_x = x + (attack_hitbox_x1 * facing);
    var start_y = y + attack_hitbox_y1;
    var end_x   = x + (attack_hitbox_x2 * facing);
    var end_y   = y + attack_hitbox_y2;

    // TUNING PREVIEW hit area
    draw_set_alpha(0.25);
    draw_set_color(c_yellow);

    draw_line_width(
        start_x,
        start_y,
        end_x,
        end_y,
        attack_hitbox_thickness * 2
    );

    // Center line
    draw_set_alpha(0.8);
    draw_set_color(c_orange);

    draw_line_width(
        start_x,
        start_y,
        end_x,
        end_y,
        1
    );

    // Start point
    draw_set_color(c_blue);
    draw_circle(start_x, start_y, 3, false);

    // End point
    draw_set_color(c_yellow);
    draw_circle(end_x, end_y, 3, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
}