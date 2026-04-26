var bar_x = 80;
var bar_y = 35;
var bar_width = 180;
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

// Scaled sprite on top
var hicon_x = bar_x + bar_width / 2;
var hicon_y = bar_y + bar_height / 2;

draw_sprite_ext(
    spr_hp_bar, // sprite
    0,              // frame
    hicon_x,         // x
    hicon_y,         // y
    0.2,            // x scale
    0.2,            // y scale
    0,              // rotation
    c_white,        // color
    1               // alpha
);

//--------------------------------------------------------------------------

var gbar_x = 100;
var gbar_y = 100;
var gbar_width = 122;
var gbar_height = 11;

// Background (empty bar)
draw_set_color(c_black);
draw_rectangle(gbar_x, gbar_y, gbar_x + gbar_width, gbar_y + gbar_height, false);

//fill
var guard_ratio = guard_meter / guard_meter_max;
draw_set_color(c_green);
draw_rectangle(
    gbar_x,
    gbar_y,
    gbar_x + (gbar_width * guard_ratio),
    gbar_y + gbar_height,
    false
);

// Optional border
draw_set_color(c_dkgray);
draw_rectangle(gbar_x, gbar_y, gbar_x + gbar_width, gbar_y + gbar_height, true);

// Scaled sprite on top
var gicon_x = gbar_x + gbar_width / 2;
var gicon_y = gbar_y + gbar_height / 2;

draw_sprite_ext(
    spr_guard_meter, // sprite
    0,              // frame
    gicon_x,         // x
    gicon_y,         // y
    0.15,            // x scale
    0.15,            // y scale
    0,              // rotation
    c_white,        // color
    1               // alpha
);

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
	draw_text(20, 280, "shield_thickness = " + string(shield_thickness));*/

	draw_set_alpha(1);
	draw_set_color(c_white);
	var i = debug_arc_index;
    draw_text(800, 40, "AIR ATTACK SEGMENT: " + string(i + 1));
    draw_text(800, 70,  "air_arc_x1[" + string(i) + "] = " + string(air_arc_x1[i]) + ";");
    draw_text(800, 90,  "air_arc_y1[" + string(i) + "] = " + string(air_arc_y1[i]) + ";");
    draw_text(800, 110, "air_arc_x2[" + string(i) + "] = " + string(air_arc_x2[i]) + ";");
    draw_text(800, 130, "air_arc_y2[" + string(i) + "] = " + string(air_arc_y2[i]) + ";");
    draw_text(800, 150, "air_arc_thickness[" + string(i) + "] = " + string(air_arc_thickness[i]) + ";");
	draw_text(800, 300,"Merchant menu open: "+string(global.merchant_menu_open));
}