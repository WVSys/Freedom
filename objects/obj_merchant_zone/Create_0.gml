merchant_id = noone;

player_near = false;

activate = function()
{
    global.merchant_menu_open = true;

    if (!instance_exists(obj_merchant_menu))
    {
        instance_create_layer(0, 0, "Instances", obj_merchant_menu);
    }
};
