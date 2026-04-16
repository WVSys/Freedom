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