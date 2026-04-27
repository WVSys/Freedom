player_near = false;
player_was_near = false;

tutorial_timeline_running = false;

merchant_id = instance_nearest(x, y, obj_merchant);

if (merchant_id == noone)
{
    show_debug_message("merchant_id was not found in obj_merchant_zone Create");
}
else
{
    show_debug_message("merchant_id assigned in obj_merchant_zone");
}

activate = function()
{
    if (global.intro_merchant_seen && !global.dialogue_active && !global.merchant_menu_open)
    {
        global.merchant_menu_open = true;

        // Open/create your merchant menu here
        // instance_create_depth(0, 0, -100000, obj_merchant_menu);
    }
};