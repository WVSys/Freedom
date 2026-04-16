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
    draw_set_alpha(1);
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
}