// Coins

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1); // optional, uses default font

draw_text(950, 32, ": " + string(global.coins));

draw_sprite_ext(
    spr_coin, // sprite
    0,              // frame
    925,         // x
    34,         // y
    1,            // x scale
    1,            // y scale
    0,              // rotation
    c_white,        // color
    1               // alpha
);