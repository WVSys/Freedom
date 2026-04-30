var box_x = 300;
var box_y = 60;
var box_w = 500;
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
    draw_text(rx, ry + 24, "Cost: 5 coins");
}
else
{
    draw_text(rx, ry, item_name);
    draw_text(rx, ry + 24, "Lv " + string(get_item_level(item_name)));
	
    var stats = menu_get_item_display_stats(item_name);

    draw_text(
        rx,
        ry + 48,
        "Dur " + string(stats.durability) + "/" + string(stats.durability_max)
    );

    if (item_name == "Sword")
    {
        draw_text(
            rx,
            ry + 66,
            "Atk " + string(stats.effective_attack) + "/" + string(stats.attack)
        );
    }

    if (item_name == "Shield")
    {
        draw_text(
            rx,
            ry + 66,
            "Guard " + string(stats.guard_max)
        );

        draw_text(
            rx,
            ry + 84,
            "Regen " + string(stats.guard_regen)
        );
    }

    var action_y_start = ry + 90;

    if (item_name == "Sword") action_y_start = ry + 110;
    if (item_name == "Shield") action_y_start = ry + 130;

    for (var a = 0; a < array_length(actions); a++)
    {
        var ayy = action_y_start + a * 24;

        if (menu_mode == "action" && a == action_index)
        {
            draw_text(rx - 20, ayy, ">");
        }

        draw_text(rx, ayy, actions[a]);
    }

    draw_text(rx, ry + 170, "Upgrade: "
        + string(get_upgrade_cost_coins(item_name)) + "coins, "
        + string(get_upgrade_cost_runes(item_name)) + " runes");

    draw_text(rx, ry + 184, "Repair: " + string(get_repair_cost(item_name)) + "coins");
}

if (message_timer > 0)
{
    draw_text(box_x + 16, box_y + box_h - 24, message);
}