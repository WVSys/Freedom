show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = false;
instance_destroy(obj_tutorial_gamepad);
instance_destroy(obj_tutorial_highlight);
if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("There's a lone skeleton ahead. Practice on that before chasing legends.");
    }
}