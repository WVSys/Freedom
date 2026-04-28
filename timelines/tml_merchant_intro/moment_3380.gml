show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = true;

set_tutorial_focus("coins");
set_tutorial_focus("runes");
if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Monsters may drop coins and runes. Bring the runes to me and I can help you.");
    }
}