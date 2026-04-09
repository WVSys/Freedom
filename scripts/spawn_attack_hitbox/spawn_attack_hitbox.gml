function spawn_attack_hitbox(owner, offset_x, offset_y, damage, life, hitbox_sprite)
{
    var hb = instance_create_layer(
        owner.x + (offset_x * owner.facing),
        owner.y + offset_y,
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
    hb.image_xscale = owner.facing;

    return hb;
}