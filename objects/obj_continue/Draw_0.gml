draw_set_alpha(image_alpha);
draw_self();

if (focused)
{
   draw_rectangle(
    bbox_left - 4,
    bbox_top - 4,
    bbox_right + 4,
    bbox_bottom + 4,
    true
	);
}
draw_set_alpha(1);