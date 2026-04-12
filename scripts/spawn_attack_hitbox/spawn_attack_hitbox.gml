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

    // 🔥 DEFINE SWORD SIZE HERE
    var sword_length = 40;
    var sword_height = 8;

    // 🔥 SCALE THE HITBOX
    hb.image_xscale = (sword_length / sprite_get_width(hitbox_sprite)) * owner.facing;
    hb.image_yscale = sword_height / sprite_get_height(hitbox_sprite);

    // 🔥 POSITION ALONG THE SWORD
    var total_offset = offset_x + (sword_length / 2);

    hb.x = owner.x + (total_offset * owner.facing);
    hb.y = owner.y + offset_y;

    return hb;
}