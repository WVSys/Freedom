set_tutorial_focus("potion");
if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Potions are limited. Waste them, and you'll regret it.");
    }
}