life--;

// Convert local offsets to world positions
var start_x = x + x1;
var start_y = y + y1;
var end_x   = x + x2;
var end_y   = y + y2;

// Main line
var hit = collision_line(
    start_x,
    start_y,
    end_x,
    end_y,
    target_object,
    false,
    true
);

// Extra lines for thickness
if (hit == noone) {
    hit = collision_line(
        start_x,
        start_y - thickness,
        end_x,
        end_y - thickness,
        target_object,
        false,
        true
    );
}

if (hit == noone) {
    hit = collision_line(
        start_x,
        start_y + thickness,
        end_x,
        end_y + thickness,
        target_object,
        false,
        true
    );
}

if (hit != noone) {
    hit.take_damage(damage);
    instance_destroy();
    exit;
}

if (life <= 0) {
    instance_destroy();
}