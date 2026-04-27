can_interact = false;
saved_message_timer = 0;
speech_bubble = noone;

merchant_say = function(_text)
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
};