show_merchant_repair = false;
show_merchant_save = true;
set_tutorial_focus("save");

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("If you need to rest, save your progress.");
    }
}