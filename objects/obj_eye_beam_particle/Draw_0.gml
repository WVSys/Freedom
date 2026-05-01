draw_set_alpha(particle_alpha);
draw_set_color(particle_color);

// main particle
draw_circle(x, y, particle_size, false);

// small streak behind it
var speed_dir = point_direction(0, 0, hsp, vsp);
var tx = x - lengthdir_x(trail_length, speed_dir);
var ty = y - lengthdir_y(trail_length, speed_dir);

draw_line_width(x, y, tx, ty, max(1, particle_size));

draw_set_alpha(1);
draw_set_color(c_white);