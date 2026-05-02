// closes merchant menu
global.merchant_menu_open = false;

if (instance_exists(obj_merchant_menu))
{
    with (obj_merchant_menu)
    {
        instance_destroy();
    }
}

show_merchant_repair = false;
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
        merchant_say("Coins buy supplies and upgrades. Runes strengthen your gear.");
    }
}