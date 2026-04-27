if (global.game_paused)
{
    image_speed = 0;
    exit;
}
else
{
    image_speed = 1;
}
can_interact = false;

function merchant_say(_text)
{
    if (instance_exists(speech_bubble))
    {
        instance_destroy(speech_bubble);
    }

    speech_bubble = instance_create_layer(
        x,
        y - 48,
        "Instances",
        obj_speech_bubble
    );

    speech_bubble.owner = id;
    speech_bubble.text = _text;
}