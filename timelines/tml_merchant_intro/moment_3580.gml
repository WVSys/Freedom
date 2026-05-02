global.menu_input_lock = true;

// opens menu 
global.merchant_menu_open = true;

// creates menu
if (!instance_exists(obj_merchant_menu))
{
    var menu = instance_create_layer(0, 0, "Instances", obj_merchant_menu);
    menu.active = true;
    menu.visible = true;

    menu.menu_mode = "category";

    // sets menu option to sword for tutorial progression
    for (var i = 0; i < array_length(menu.categories); i++)
    {
        if (menu.categories[i] == "Sword")
        {
            menu.category_index = i;
            break;
        }
    }

    menu.menu_mode = "action";
    menu.action_index = 0; // Upgrade
}

// force menu into a non-interactive tutorial state
if (instance_exists(obj_merchant_menu))
{
    with (obj_merchant_menu)
    {
        can_interact = false;
    }
}

show_rune_controls = false;
show_merchant_upgrade = true;
set_tutorial_focus("upgrade");

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Upgrade equipment here. Armor reduces damage and your sword deals more.");
    }
}