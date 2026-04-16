var bar_x = 20;
var bar_y = 20;
var bar_width = 200;
var bar_height = 16;

// Background (empty bar)
draw_set_color(c_black);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

// HP fill
var hp_ratio = hp / hp_max;
draw_set_color(c_red);
draw_rectangle(
    bar_x,
    bar_y,
    bar_x + (bar_width * hp_ratio),
    bar_y + bar_height,
    false
);

// Optional border
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);


if (global.debug)
{
    /*draw_set_alpha(1);
	draw_set_color(c_white);

	var i = debug_arc_index;

	draw_text(20, 40, "Editing segment: " + string(i + 1));

	draw_set_color(c_lime);
	draw_text(20, 70,  "arc_x1[" + string(i) + "] = " + string(arc_x1[i]) + ";");
	draw_text(20, 90,  "arc_y1[" + string(i) + "] = " + string(arc_y1[i]) + ";");
	draw_text(20, 110, "arc_x2[" + string(i) + "] = " + string(arc_x2[i]) + ";");
	draw_text(20, 130, "arc_y2[" + string(i) + "] = " + string(arc_y2[i]) + ";");
	draw_text(20, 150, "arc_thickness[" + string(i) + "] = " + string(arc_thickness[i]) + ";");

	draw_set_color(c_white);
	draw_set_alpha(1);
	
	draw_set_alpha(1);
	draw_set_color(c_blue);
	draw_circle(shield_x1, shield_y1, 4, false);

	draw_set_color(c_fuchsia);
	//draw_circle(shield_x2, shield_y2, 4, false);

	draw_set_color(c_white);
	draw_text(20, 180, "SHIELD");
	draw_text(20, 200, "shield_x1 = " + string(shield_x1));
	draw_text(20, 220, "shield_y1 = " + string(shield_y1));
	draw_text(20, 240, "shield_x2 = " + string(shield_x2));
	draw_text(20, 260, "shield_y2 = " + string(shield_y2));
	draw_text(20, 280, "shield_thickness = " + string(shield_thickness));

	draw_set_alpha(1);
	draw_set_color(c_white);*/
	var i = debug_arc_index;
    draw_text(20, 40, "AIR ATTACK SEGMENT: " + string(i + 1));
    draw_text(20, 70,  "air_arc_x1[" + string(i) + "] = " + string(air_arc_x1[i]) + ";");
    draw_text(20, 90,  "air_arc_y1[" + string(i) + "] = " + string(air_arc_y1[i]) + ";");
    draw_text(20, 110, "air_arc_x2[" + string(i) + "] = " + string(air_arc_x2[i]) + ";");
    draw_text(20, 130, "air_arc_y2[" + string(i) + "] = " + string(air_arc_y2[i]) + ";");
    draw_text(20, 150, "air_arc_thickness[" + string(i) + "] = " + string(air_arc_thickness[i]) + ";");
}