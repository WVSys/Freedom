function spawn_attack_hitbox(owner, target_object, x1, y1, x2, y2, damage, life, thickness)
{
    var hb = instance_create_layer(
        owner.x,
        owner.y,
        "Instances",
        obj_attack_hitbox
    );

    hb.owner = owner;
    hb.target_object = target_object;

    hb.damage = damage;
    hb.life = life;
    hb.thickness = thickness;

    // Mirror horizontal offsets based on owner facing
    hb.x1 = x1 * owner.facing;
    hb.y1 = y1;
    hb.x2 = x2 * owner.facing;
    hb.y2 = y2;

    return hb;
}