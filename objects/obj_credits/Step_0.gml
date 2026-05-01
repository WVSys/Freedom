if (!finished)
{
    y_offset -= scroll_speed;

    // When fully scrolled past
    if (y_offset < -array_length(credits_text) * 40)
    {
        finished = true;
        alarm[0] = room_speed * 1; // short delay before menu
    }
}