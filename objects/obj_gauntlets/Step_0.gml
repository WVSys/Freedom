float_timer += float_speed;

//  up/down motion
y = base_y + sin(float_timer) * float_height;

// glow effect
image_alpha = 0.8 + sin(float_timer * 2) * 0.2;