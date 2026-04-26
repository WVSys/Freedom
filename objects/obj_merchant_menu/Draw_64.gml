var box_x = 300;
var box_y = 60;
var box_w = 420;
var box_h = 300;

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

draw_text(box_x + 16, box_y + 12, "Merchant");
draw_text(box_x + 280, box_y + 12, "Coins: " + string(global.coins));

for (var i = 0; i < array_length(categories); i++)
{
    var yy = box_y + 45 + i * 24;

    if (menu_mode == "category" && i == category_index)
    {
        draw_text(box_x + 10, yy, ">");
    }

    draw_text(box_x + 30, yy, categories[i]);
}

var item_name = categories[category_index];
var rx = box_x + 220;
var ry = box_y + 50;

if (item_name == "Save")
{
    draw_text(rx, ry, "Save Progress");
    draw_text(rx, ry + 24, "Store current\nstats and gear");
}
else if (item_name == "HP Potion")
{
    draw_text(rx, ry, "HP Potion");
    draw_text(rx, ry + 24, "Cost: 25 coins");
}
else
{
    draw_text(rx, ry, item_name);
    draw_text(rx, ry + 24, "Lv " + string(get_item_level(item_name)));
    draw_text(rx, ry + 48, "Dur " + string(get_item_durability(item_name)) + "/" + string(get_item_max_durability(item_name)));

    for (var a = 0; a < array_length(actions); a++)
    {
        var ayy = ry + 90 + a * 24;

        if (menu_mode == "action" && a == action_index)
        {
            draw_text(rx - 20, ayy, ">");
        }

        draw_text(rx, ayy, actions[a]);
    }

    draw_text(rx, ry + 160, "Upgrade: "
        + string(get_upgrade_cost_coins(item_name)) + "c, "
        + string(get_upgrade_cost_runes(item_name)) + " runes");

    draw_text(rx, ry + 184, "Repair: " + string(get_repair_cost(item_name)) + "c");
}

if (message_timer > 0)
{
    draw_text(box_x + 16, box_y + box_h - 24, message);
}