show_debug_message("TIMELINE MOMENT 0 FIRED");

if (instance_exists(merchant_id))
{
    with (merchant_id)
    {
        merchant_say("Whoa, lass. That way lies danger.");
    }
}
else
{
    show_debug_message("Runner merchant_id missing.");
}