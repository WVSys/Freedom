show_merchant_upgrade = false;
show_merchant_repair = true;
set_tutorial_focus("repair");

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("But be careful, your equipment can break. If that happens, I can repair it for you.");
    }
}