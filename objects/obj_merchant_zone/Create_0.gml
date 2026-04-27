merchant_id = noone;

player_near = false;
player_was_near = false;

// Link this zone to the nearest merchant
if (instance_exists(obj_merchant))
{
    merchant_id = instance_nearest(x, y, obj_merchant);
}
else
{
    show_debug_message("No obj_merchant found for merchant zone");
}

activate = function()
{
    global.merchant_menu_open = true;

    if (!instance_exists(obj_merchant_menu))
    {
        instance_create_layer(0, 0, "Instances", obj_merchant_menu);
    }
};