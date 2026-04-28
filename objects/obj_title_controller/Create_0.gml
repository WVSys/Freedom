save_file = "save.json";

has_continue = file_exists(save_file);

menu_index = 0; // 0 = Start, 1 = Continue
confirm_overwrite = false;

with (obj_start)
{
    focused = true;
}

if (has_continue)
{
    if (!instance_exists(obj_continue))
    {
        var btn = instance_create_depth(850, 670, -10001, obj_continue);
        btn.active = true;
        btn.visible = true;
        btn.focused = false;
        btn.image_alpha = 1;
        btn.image_xscale = 0.1610;
        btn.image_yscale = 0.1799;
    }
}

stick_deadzone = 0.5;
stick_ready_y = true;