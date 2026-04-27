draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var line_sep = 16;

var text_w = min(string_width(text), max_width);
var text_h = string_height_ext(text, line_sep, max_width);

var box_w = text_w + padding * 2;
var box_h = text_h + padding * 2;

var box_x1 = x - box_w / 2;
var box_y1 = y - box_h-20;
var box_x2 = box_x1 + box_w;
var box_y2 = box_y1 + box_h;

draw_set_color(c_white);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, false);

draw_set_color(c_black);
draw_roundrect(box_x1, box_y1, box_x2, box_y2, true);

draw_set_color(c_black);
draw_text_ext(box_x1 + padding, box_y1 + padding, text, line_sep, max_width);