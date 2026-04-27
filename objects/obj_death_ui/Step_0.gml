if (!active) exit;

image_alpha = min(image_alpha + fade_speed, 1);

if (image_alpha >= 1 && !continue_created)
{
    continue_created = true;

    var btn = instance_create_depth(x, y+100, -10001, obj_continue_button_death);
	btn.focused = true;
	btn.active = true;
	btn.visible = true;
	btn.image_alpha = 0;
	btn.fade_speed = 0.05;
}