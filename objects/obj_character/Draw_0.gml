//Chat GPT provided implementation to tune Hitboxes. Tuned by dev.
// Draw sprite first
draw_self();

// Draw modular armor overlays after the base character
draw_equipment_overlays();


if (global.debug)
{
    // Optional: character collision box
    draw_set_alpha(0.35);
    draw_set_color(c_lime);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_alpha(1);

    // Draw arc preview lines
    for (var i = 0; i < 5; i++)
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
    draw_set_alpha(1);
	
	if (global.debug && (combat_state == CombatState.GUARD || debug_tune_shield))
	{
	    var sx = x + (shield_x1 * facing);
	    var sy = y + shield_y1;
	    var ex = x + (shield_x2 * facing);
	    var ey = y + shield_y2;

	    draw_set_alpha(0.35);
	    draw_set_color(c_aqua);
	    draw_line_width(sx, sy, ex, ey, shield_thickness * 2);

	    draw_set_alpha(1);
	    draw_set_color(c_blue);
	    draw_circle(sx, sy, 4, false);

	    draw_set_color(c_fuchsia);
	    draw_circle(ex, ey, 4, false);
	}
	
	// Air attack tuning preview
    if (combat_state == CombatState.AIR_ATTACK || debug_no_gravity)
    {
        for (var i = 0; i < 5; i++)
        {
            var start_x = x + (air_arc_x1[i] * facing);
            var start_y = y + air_arc_y1[i];
            var end_x   = x + (air_arc_x2[i] * facing);
            var end_y   = y + air_arc_y2[i];

            // highlight selected segment
            if (i == debug_arc_index)
            {
                draw_set_alpha(0.45);
                draw_set_color(c_aqua);
            }
            else
            {
                draw_set_alpha(0.18);
                draw_set_color(c_yellow);
            }

            // thick hit area
            draw_line_width(
                start_x,
                start_y,
                end_x,
                end_y,
                air_arc_thickness[i] * 2
            );

            // center line
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_line_width(start_x, start_y, end_x, end_y, 1);

            // endpoints
            draw_set_color(c_blue);
            draw_circle(start_x, start_y, 3, false);

            draw_set_color(c_fuchsia);
            draw_circle(end_x, end_y, 3, false);
        }

        draw_set_alpha(1);
        draw_set_color(c_white);
	
	}
}