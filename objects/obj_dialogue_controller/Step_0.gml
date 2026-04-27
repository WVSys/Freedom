if (!active)
{
    exit;
}

line_timer--;

if (line_timer <= 0)
{
    dialogue_index++;

    if (dialogue_index >= array_length(dialogue_lines))
    {
        active = false;
        global.dialogue_active = false;

        if (on_finish_type == "merchant_intro")
        {
            global.intro_merchant_seen = true;
        }

        exit;
    }

    show_current_line();
}