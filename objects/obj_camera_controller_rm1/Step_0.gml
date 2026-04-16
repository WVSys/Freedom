var view_w = camera_get_view_width(cam);
var view_h = camera_get_view_height(cam);

var target_x = obj_character.x - view_w / 2;

if (obj_character.hspeed > 0) {
    target_x += look_ahead;
}
else if (obj_character.hspeed < 0) {
    target_x -= look_ahead;
}


/// Vertical look
var look_up_amount = 250;
var vertical_look = 0;

if (keyboard_check(vk_up)) {
    vertical_look = -look_up_amount;
}
 // controller right stick vertical
var ry = gamepad_axis_value(0, gp_axisrv);
if (ry < -0.5) vertical_look = -look_up_amount;

var target_y = obj_character.y - view_h / 2 + vertical_look;


var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

cam_x = lerp(cam_x, target_x, smooth);
cam_y = lerp(cam_y, target_y, smooth);

cam_x = clamp(cam_x, 0, room_width - view_w);
cam_y = clamp(cam_y, 0, room_height - view_h);

camera_set_view_pos(cam, cam_x, cam_y);