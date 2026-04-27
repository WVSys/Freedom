if (player_near && global.intro_merchant_seen && !global.merchant_menu_open && !global.dialogue_active)
{
    draw_set_color(c_white);
    draw_text(x - 20, y - 120, "Press E");
}
