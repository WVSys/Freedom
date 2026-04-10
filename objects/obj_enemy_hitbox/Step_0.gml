life--;

var left   = x + x1;
var right  = x + x2;
var top    = y + y1;
var bottom = y + y2;

with (obj_character) {
    if (bbox_right > left &&
        bbox_left  < right &&
        bbox_bottom > top &&
        bbox_top    < bottom)
    {
        take_damage(other.damage);
    }
}


if (life <= 0) {
    instance_destroy();
}