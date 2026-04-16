function spawn_attack_hitbox(owner, offset_x, offset_y, damage, life, hitbox_sprite)
{
    var hb = instance_create_layer(
        owner.x,
        owner.y,
        "Instances",
        obj_enemy_hitbox
    );

    hb.owner = owner;
    hb.damage = damage;
    hb.facing = owner.facing;
    hb.life = life;

    hb.sprite_index = hitbox_sprite;
    hb.image_index = 0;
    hb.image_speed = 0;

	// sword hitbox (adjust the numbers here)
    var sword_length = 40;
    var sword_height = 25;

    // 🔥 SCALE THE HITBOX
    hb.image_xscale = (sword_length / sprite_get_width(hitbox_sprite)) * owner.facing;
    hb.image_yscale = sword_height / sprite_get_height(hitbox_sprite);

    // 🔥 POSITION ALONG THE SWORD
	var left_extend = 40; // how much to extend left side
    var total_offset = offset_x + (sword_length / 2) - left_extend;
	

    hb.x = owner.x + (total_offset * owner.facing);
    hb.y = owner.y + offset_y;
	
	// 🔥 ROTATION (applied on creation)
	if (owner.facing == 1) {
	    hb.image_angle = 0;
	} else {
	    hb.image_angle = 195;
	}

    return hb;
}