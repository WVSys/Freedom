function spawn_rune(_x, _y, _type, _value)
{
    var rune = instance_create_layer(_x, _y, "Instances", obj_rune);

    rune.rune_type = _type;
    rune.value = _value;

    rune.set_rune_sprite();

    return rune;
}