// Draw sprite first
draw_self();
if(global.debug)
{
	draw_set_alpha(0.35);
	draw_set_color(c_lime);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_alpha(1);
}

// HP bar settings
var bar_width = 40;
var bar_height = 6;
var hp_ratio = hp / hp_max;

// Position above the character
var bx = x - bar_width / 2;
var by = y - sprite_height / 2 - 12;

// Background
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bar_width, by + bar_height, false);

// Missing HP
draw_set_color(c_grey);
draw_rectangle(bx + 1, by + 1, bx + bar_width - 1, by + bar_height - 1, false);

// Current HP
draw_set_color(c_red);
draw_rectangle(
    bx + 1,
    by + 1,
    bx + 1 + (bar_width - 2) * hp_ratio,
    by + bar_height - 1,
    false
);