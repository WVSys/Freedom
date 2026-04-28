show_attack_controls = true;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = false;

set_tutorial_focus("attack");
if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Attack when you see an opening.");
    }
}
