if (control_mode == "none") {
    exit;
}

var gui_w = display_get_gui_width();

var cx = gui_w / 2;
var cy = 300;
var a = 0.45 + 0.25 * sin(pulse);

// Text panel
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//draw_set_alpha(0.80);
draw_set_color(c_black);
draw_roundrect(cx - 150, 70, cx + 150, 190, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_text(cx, 100, title_text);

draw_set_color(c_yellow);
draw_text(cx, 135, keyboard_text);
draw_text(cx, 165, gamepad_text);

// Buttons only
var bx = cx;
var by = cy;

// X / Square - attack
if (control_mode == "attack") {
	draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_circle(bx+15, by - 62, 10, false);
    draw_set_color(c_white);
}


// Right Shoulder button / Circle - block
if (control_mode == "block") {
	draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_circle(bx-90, by - 95, 15, false);
    draw_set_color(c_white);
}

// Directional up - potion
if (control_mode == "potion") {
	draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_circle(bx-59, by - 38, 10, false);
    draw_set_color(c_white);
}

// rune / coins callout
if (control_mode == "rune") {
    draw_set_color(c_yellow);
    draw_rectangle(cx + 385, cy - 245, cx + 485, cy -157, true);

    draw_set_color(c_white);
	draw_text(cx + 325, cy-230, "Armor Runes");
	draw_text(cx + 325, cy-205, "Sword Runes");
	draw_text(cx + 325, cy-175, "Shield Runes");
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);