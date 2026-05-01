if (highlight_mode == "none") {
    exit;
}

var a = 0.45 + 0.25 * sin(pulse);

// reset defaults
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --------------------
// Guard meter highlight
// --------------------
if (highlight_mode == "guard") {
    var x1 = 24;
    var y1 = 58;
    var x2 = 224;
    var y2 = 84;

    draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_rectangle(x1 + 6, y1 + 26, x2 + 6, y2 + 36, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    //draw_text(x2 + 18, y1 - 2, "Guard meter");
}

// --------------------
// Coins highlight
// --------------------
if (highlight_mode == "coins") {
    var cx = 34;
    var cy = 122;
    var radius = 28;

    draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_circle(cx, cy, radius, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    //draw_text(cx + 36, cy - 8, "Coins");
}

// --------------------
// Runes highlight
// --------------------
if (highlight_mode == "runes") {
    var x1 = 24;
    var y1 = 145;
    var x2 = 230;
    var y2 = 178;

    draw_set_alpha(a);
    draw_set_color(c_aqua);
    draw_rectangle(x1 + 775, y1 - 95, x2 + 800, y2 - 30, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    
}

// --------------------
// Potions highlight
// --------------------
if (highlight_mode == "potions") {
    var x1 = 24;
    var y1 = 190;
    var x2 = 150;
    var y2 = 220;

    draw_set_alpha(a);
    draw_set_color(c_lime);
    draw_rectangle(x1 + 875, y1 - 45, x2 + 850, y2 - 30, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    //draw_text(x2 + 18, y1 + 2, "HP Potions");
}

// --------------------
// Health highlight
// --------------------
if (highlight_mode == "health") {
    var x1 = 24;
    var y1 = 24;
    var x2 = 224;
    var y2 = 50;

    draw_set_alpha(a);
    draw_set_color(c_red);
    draw_rectangle(x1 - 6, y1 - 6, x2 + 6, y2 + 6, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(x2 + 18, y1 - 2, "Health");
}

// --------------------
// Upgrade highlight
// --------------------
if (highlight_mode == "upgrade") {
    var box_x = 300;
    var box_y = 60;

    var rx = box_x + 220;
    var ry = box_y + 50;

    var x1 = rx - 55;
    var y1 = ry + 90;
    var x2 = rx + 65;
    var y2 = ry + 110;

    draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_rectangle(x1, y1, x2, y2, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    //draw_text(x2 + 10, y1, "Upgrade");
}

// --------------------
// Repair highlight
// --------------------
if (highlight_mode == "repair") {
    var box_x = 300;
    var box_y = 60;

    var rx = box_x + 220;
    var ry = box_y + 50;

    var x1 = rx - 55;
    var y1 = ry + 115;
    var x2 = rx + 65;
    var y2 = ry + 135;

    draw_set_alpha(a);
    draw_set_color(c_yellow);
    draw_rectangle(x1, y1, x2, y2, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    //draw_text(x2 + 10, y1, "Repair");
}

draw_set_alpha(1);
draw_set_color(c_white);