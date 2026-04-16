if (other.invincible_timer > 0) exit;

var blocked = false;

if (other.is_blocking) {
    if (other.image_xscale == 1 && x > other.x) blocked = true;
    if (other.image_xscale == -1 && x < other.x) blocked = true;
}

// if hitbox connects with player, player takes damage
if (other != owner) {
    other.take_damage(damage);
}


if (blocked) {
    show_debug_message("BLOCKED");
} else {
    other.hp = clamp(other.hp - damage, 0, other.hp_max);
    other.invincible_timer = 12;
    show_debug_message("HIT");
}

instance_destroy();