if (elite)
{
    // Yellow outline / aura behind sprite.
    var t = elite_outline_thickness;

    draw_sprite_ext(sprite_index, image_index, x - t, y,     image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x + t, y,     image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x,     y - t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x,     y + t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);

    draw_sprite_ext(sprite_index, image_index, x - t, y - t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x + t, y - t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x - t, y + t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);
    draw_sprite_ext(sprite_index, image_index, x + t, y + t, image_xscale, image_yscale, image_angle, elite_outline_color, image_alpha);

    // Red shader on the actual sprite.
    shader_set(shd_elite_red);
    shader_set_uniform_f(shader_get_uniform(shd_elite_red, "u_red_amount"), elite_red_amount);

    draw_self();

    shader_reset();
}
else
{
    draw_self();
}

if (global.debug)
{	
	draw_set_font(1);
	draw_set_color(c_white);
	draw_set_alpha(1);


	draw_text(x - 40, y - 200, "x1: " + string(attack_hitbox_x1));
	draw_text(x - 40, y - 180,  "y1: " + string(attack_hitbox_y1));
	draw_text(x - 40, y - 160,  "x2: " + string(attack_hitbox_x2));
	draw_text(x - 40, y - 140,  "y2: " + string(attack_hitbox_y2));
	draw_text(x - 40, y - 120,  "th: " + string(attack_hitbox_thickness));
	
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
// HP bar settings
var bar_width = 40;
var bar_height = 6;
var hp_ratio = hp / hp_max;

//above the character
var bx = x - (bar_width / 2) + hp_bar_xoffset;
var by = y - sprite_height / 2 + hp_bar_yoffset;

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