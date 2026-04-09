
if(global.debug)
{
	draw_set_alpha(0.25);
	draw_set_color(c_yellow);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

	draw_set_alpha(1);
	draw_set_color(c_orange);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

	draw_set_color(c_red);
	draw_line(x - 2, y, x + 2, y);
	draw_line(x, y - 2, x, y + 2);
}