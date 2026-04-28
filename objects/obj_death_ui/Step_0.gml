if (!active) exit;

// 🔥 NEW: lock UI to camera center
var cam = view_camera[0];
x = camera_get_view_x(cam) + camera_get_view_width(cam) / 2;
y = camera_get_view_y(cam) + camera_get_view_height(cam) / 2;

// Fade in
image_alpha = min(image_alpha + fade_speed, 1);

// Create continue button once fully visible
if (image_alpha >= 1 && !continue_created)
{
    continue_created = true;

    var btn = instance_create_depth(x, y + 100, -10001, obj_continue_button_death);
    btn.focused = true;
    btn.active = true;
    btn.visible = true;
    btn.image_alpha = 0;
    btn.fade_speed = 0.05;
}