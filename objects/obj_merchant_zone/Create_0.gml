player_near = false;
player_was_near = false;

repeat_greeting_done = false;
player_was_inside = false;

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

activate = function() {
    if (global.intro_merchant_seen && !global.dialogue_active && !global.merchant_menu_open) {
        global.merchant_menu_open = true;

        if (!instance_exists(obj_merchant_menu)) {
            instance_create_layer(0, 0, "Instances", obj_merchant_menu);
        }
    }
};


