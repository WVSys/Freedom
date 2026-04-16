// Draw sprite first
draw_self();

if (global.debug)
{
    // Optional: character collision box
    draw_set_alpha(0.35);
    draw_set_color(c_lime);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_alpha(1);
/*
    // Draw arc preview lines
    for (var i = 0; i < 3; i++)
    {
        var start_x = x + (arc_x1[i] * facing);
        var start_y = y + arc_y1[i];
        var end_x   = x + (arc_x2[i] * facing);
        var end_y   = y + arc_y2[i];

        if (i == debug_arc_index)
        {
            draw_set_alpha(0.45);
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_alpha(0.18);
            draw_set_color(c_yellow);
        }

        // Thick hit area
        draw_line_width(
            start_x,
            start_y,
            end_x,
            end_y,
            arc_thickness[i] * 2
        );

        // Center line
        draw_set_alpha(1);
        draw_set_color(c_red);
        draw_line_width(start_x, start_y, end_x, end_y, 1);

        // Start point
        draw_set_color(c_blue);
        draw_circle(start_x, start_y, 3, false);

        // End point
        draw_set_color(c_yellow);
        draw_circle(end_x, end_y, 3, false);
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_set_color(c_white);
    draw_set_alpha(1);*/
}