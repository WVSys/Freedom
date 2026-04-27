if (!confirm_overwrite) exit;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(
    gui_w * 0.5,
    gui_h * 0.45,
    "Starting over will overwrite your old save."
);

draw_text(
    gui_w * 0.5,
    gui_h * 0.55,
    "Press Enter / A to confirm. Press Esc / B to cancel."
);

draw_set_halign(fa_left);
draw_set_valign(fa_top);