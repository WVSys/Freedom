global.menu_input_lock = true;
// OPEN MENU FIRST
global.merchant_menu_open = true;

// THEN create it
if (!instance_exists(obj_merchant_menu))
{
    var menu = instance_create_layer(0, 0, "Instances", obj_merchant_menu);
    menu.active = true;
    menu.visible = true;


    menu.menu_mode = "category";
	
	// sets menu option to gauntlets for tutorial progression
    for (var i = 0; i < array_length(menu.categories); i++)
    {
        if (menu.categories[i] == "Gauntlets")
        {
            menu.category_index = i;
            break;
        }
    }

    menu.menu_mode = "action";
    menu.action_index = 0; // Upgrade
}
show_rune_controls = false;
show_merchant_options = true;
set_tutorial_focus("upgrade");

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Here in my shop, you can upgrade your equipment with me. Armor reduces damage taken and your sword deals more damage.");
    }
}