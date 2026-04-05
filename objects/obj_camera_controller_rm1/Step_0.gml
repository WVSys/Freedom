var view_w = camera_get_view_width(cam);
var view_h = camera_get_view_height(cam);

var target_x = obj_character.x - view_w / 2;

if (obj_character.hspeed > 0) {
    target_x += look_ahead;
}
else if (obj_character.hspeed < 0) {
    target_x -= look_ahead;
}

var target_y = obj_character.y - view_h / 2;

var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

cam_x = lerp(cam_x, target_x, smooth);
cam_y = lerp(cam_y, target_y, smooth);

cam_x = clamp(cam_x, 0, room_width - view_w);
cam_y = clamp(cam_y, 0, room_height - view_h);

camera_set_view_pos(cam, cam_x, cam_y);

/// Parallax
//var bg_sky  = layer_get_id("bg_sky");
var bg_2  = layer_get_id("bg_2");
var bg_9  = layer_get_id("bg_9");
var bg_4 = layer_get_id("bg_4");

// smaller number = farther away
//layer_x(bg_sky,  cam_x * 0.10);
//layer_x(bg_2,  cam_x * 0.50);
layer_x(bg_9,  cam_x * 0.10);
layer_x(bg_4, cam_x * 0.15);

// optional vertical parallax
//layer_y(bg_sky,  cam_y * 0.05);
//layer_y(bg_far,  cam_y * 0.10);
//layer_y(bg_mid,  cam_y * 0.20);
//layer_y(bg_near, cam_y * 0.35);