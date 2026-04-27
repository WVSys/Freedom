if (is_dead)
{
    image_speed = 0;
    image_index = image_number - 1;

    global.death_screen_active = true;

    if (!death_ui_created)
    {
        death_ui_created = true;

        var dui = instance_create_depth(x, y - 120, -100000, obj_death_ui);
        dui.active = true;
        dui.visible = true;
        dui.image_alpha = 0;
        dui.continue_created = false;

        show_debug_message("DEATH UI CREATED ONCE");
    }

    exit;
}