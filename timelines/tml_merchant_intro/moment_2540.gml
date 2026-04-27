show_attack_controls = false;
show_block_controls = true;
show_potion_controls = false;
show_rune_controls = false;

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("If an enemy raises its weapon, block before the hit lands.");
    }
}