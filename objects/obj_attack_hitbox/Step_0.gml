

// Convert local offsets to world positions
var start_x = x + x1;
var start_y = y + y1;
var end_x   = x + x2;
var end_y   = y + y2;

// Guard hitboxes do not attack anything.
// They only exist as blockers.
if (hitbox_type == "guard")
{
    life--;

    if (life <= 0) {
        instance_destroy();
    }

    exit;
}

// Enemy attack hitbox checks guard BEFORE character damage.
if (hitbox_type == "damage" && target_object == obj_character)
{
    var guard_hit = noone;
    var count = instance_number(obj_attack_hitbox);

    for (var i = 0; i < count; i++)
    {
        var g = instance_find(obj_attack_hitbox, i);

        if (g != id && g.hitbox_type == "guard")
        {
            var gx1 = g.x + g.x1;
            var gy1 = g.y + g.y1;
            var gx2 = g.x + g.x2;
            var gy2 = g.y + g.y2;

            // Build a fat rectangle around the guard line
            var pad = g.thickness;

            var g_left   = min(gx1, gx2) - pad;
            var g_right  = max(gx1, gx2) + pad;
            var g_top    = min(gy1, gy2) - pad;
            var g_bottom = max(gy1, gy2) + pad;

            // Sample points along enemy attack line
            var steps = 12;

            for (var s = 0; s <= steps; s++)
            {
                var t = s / steps;

                var px = lerp(start_x, end_x, t);
                var py = lerp(start_y, end_y, t);

                if (px >= g_left && px <= g_right &&
                    py >= g_top && py <= g_bottom)
                {
                    guard_hit = g;
                    break;
                }
            }

            if (guard_hit != noone)
            {
                break;
            }
        }
    }

    if (guard_hit != noone)
    {
        var blocker = guard_hit.owner;

        if (instance_exists(blocker))
        {
            var effective_guard_damage = blocker.get_effective_guard_damage(damage);

			blocker.damage_shield(damage);
			blocker.guard_meter -= effective_guard_damage;
			blocker.guard_meter = max(0, blocker.guard_meter);

			audio_play_sound(shield_block, 1, false);
			
			show_debug_message(
			    "BLOCKED. Raw damage: " + string(damage)
			    + " Effective guard damage: " + string(effective_guard_damage)
			    + " Guard meter: " + string(blocker.guard_meter)
			    + " Shield durability: " + string(blocker.shield_durability)
			);
        }
		if (blocker.guard_meter <= 0)
        {
            blocker.guard_meter = 0;
            blocker.guard_broken = true;
            blocker.is_blocking = false;
            blocker.combat_state = CombatState.NONE;

            show_debug_message("GUARD BROKEN");
        }

        if (instance_exists(owner))
        {
            owner.recoil_from_shield(blocker);
        }

        instance_destroy();
        exit;
    }
}
// Guard hitboxes do NOT attack.
// They only exist so enemy attack hitboxes can collide with them.
if (hitbox_type == "guard")
{
    if (life <= 0) {
        instance_destroy();
    }

    exit;
}

// check for character guard hitboxes first.
if (hitbox_type == "damage" && target_object == obj_character)
{
    var guard_hit = noone;
    var count = instance_number(obj_attack_hitbox);

    for (var i = 0; i < count; i++)
    {
        var g = instance_find(obj_attack_hitbox, i);

        if (g != id && g.hitbox_type == "guard")
        {
            var gx1 = g.x + g.x1;
            var gy1 = g.y + g.y1;
            var gx2 = g.x + g.x2;
            var gy2 = g.y + g.y2;

        
            var pad = g.thickness;

            var g_left   = min(gx1, gx2) - pad;
            var g_right  = max(gx1, gx2) + pad;
            var g_top    = min(gy1, gy2) - pad;
            var g_bottom = max(gy1, gy2) + pad;

            // Sample points along enemy attack line
            var steps = 12;

            for (var s = 0; s <= steps; s++)
            {
                var t = s / steps;

                var px = lerp(start_x, end_x, t);
                var py = lerp(start_y, end_y, t);

                if (px >= g_left && px <= g_right &&
                    py >= g_top && py <= g_bottom)
                {
                    guard_hit = g;
                    break;
                }
            }

            if (guard_hit != noone)
            {
                break;
            }
        }
    }

    if (guard_hit != noone)
    {
        var blocker = guard_hit.owner;

        if (instance_exists(blocker))
        {
            blocker.guard_meter -= damage;
            blocker.guard_meter = max(0, blocker.guard_meter);

            show_debug_message("BLOCKED. Guard meter: " + string(blocker.guard_meter));
        }

        if (instance_exists(owner))
        {
            owner.recoil_from_shield(blocker);
        }

        instance_destroy();
        exit;
    }
}

// Normal damage collision
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

if (hit != noone && hit != owner)
{
    show_debug_message("Hit detected");
    show_debug_message("Hitbox type: " + string(hitbox_type));
    show_debug_message("Hit object: " + object_get_name(hit.object_index));

    switch (hitbox_type)
    {
        case "damage":
            hit.take_damage(damage, owner);
        break;

        default:
            show_debug_message("Unknown hitbox type: " + string(hitbox_type));
        break;
    }

    instance_destroy();
    exit;
}

life--;

if (life <= 0) {
    instance_destroy();
}

