base_y = y;          // original position
float_timer = 0;     // controls the motion
float_speed = 0.05;  // how fast it moves
float_height = 6;    // how high it floats

if (global.helmet_collected)
{
    instance_destroy();
    exit;
}