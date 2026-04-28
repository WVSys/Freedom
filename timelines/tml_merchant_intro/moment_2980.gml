show_attack_controls = false;
show_block_controls = false;
show_potion_controls = true;
show_rune_controls = false;

set_tutorial_focus("potion");
if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("If you're badly hurt, use a potion.");
    }
}