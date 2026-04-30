// Inherit the parent event
event_inherited();


// ===============================
// Camera draw bounds
// ===============================

var cam = view_camera[0];

var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

// Extra margin keeps the beam from looking like it ends exactly at screen edge
var beam_draw_margin = 64;

var view_left   = cam_x - beam_draw_margin;
var view_right  = cam_x + cam_w + beam_draw_margin;
var view_top    = cam_y - beam_draw_margin;
var view_bottom = cam_y + cam_h + beam_draw_margin;


// ===============================
// Debug boss collision box / eye origin
// ===============================

if (global.debug) {
    draw_set_alpha(0.35);
    draw_set_color(c_lime);
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
    draw_set_alpha(1);

    if (variable_instance_exists(id, "beam_eye_x")) {
        var eye_debug_x = x + (beam_eye_x * facing);
        var eye_debug_y = y + beam_eye_y;

        draw_set_color(c_yellow);
        draw_circle(eye_debug_x, eye_debug_y, 5, false);
        draw_set_color(c_white);
    }
}


// ===============================
// Draw eye beam windup / active beam
// ===============================

if (variable_instance_exists(id, "beam_active") && beam_active) {
    var sx = x + (beam_eye_x * facing);
    var sy = y + beam_eye_y;

    var ex = sx + lengthdir_x(beam_range, beam_angle);
    var ey = sy + lengthdir_y(beam_range, beam_angle);

    // Clamp visual endpoint to camera bounds only
    var draw_ex = clamp(ex, view_left, view_right);
    var draw_ey = clamp(ey, view_top, view_bottom);

    if (!beam_has_fired) {
        // Warning aim line
        draw_set_alpha(0.35);
        draw_set_color(c_red);
        draw_line_width(sx, sy, draw_ex, draw_ey, 3);
        draw_set_alpha(1);
    } else {
        // Active beam visual
        draw_set_alpha(0.85);
        draw_set_color(c_lime);

        // Cap visual width to reduce offscreen wedge artifacts
        var visual_beam_width = min(beam_thickness * 2, 24);

        draw_line_width(sx, sy, draw_ex, draw_ey, visual_beam_width);

        draw_set_color(c_white);
        draw_line_width(sx, sy, draw_ex, draw_ey, 3);

        draw_set_alpha(1);
    }

    draw_set_color(c_white);
}


// ===============================
// Final draw-state cleanup
// ===============================

draw_set_alpha(1);
draw_set_color(c_white);