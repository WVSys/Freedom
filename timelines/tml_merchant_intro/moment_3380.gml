show_attack_controls = false;
show_block_controls = false;
show_potion_controls = false;
show_rune_controls = true;

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Monsters may drop coins and runes.");
    }
}