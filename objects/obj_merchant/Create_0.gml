can_interact = false;
saved_message_timer = 0;
speech_bubble = noone;

intro_dialogue = [
    [id, "Whoa, lass. That way lies danger."],
    [id, "There are monsters down that way."],
    [obj_character, "I know."],
    [obj_character, "I'm looking for them."],
    [id, "Looking for them?"],
    [id, "You're either brave, mad, or carrying a death wish."],
    [obj_character, "Maybe all three."],
    [id, "Hmph."],
    [id, "I heard there may even be a gorgon nesting past the old ruins."],
    [obj_character, "Good."],
    [id, "Good?"],
    [obj_character, "That's what I'm looking for."],
    [id, "You're hunting a gorgon?"],
    [obj_character, "It turned my father to stone."],
    [obj_character, "I want payback."],
    [id, "..."],
    [id, "Then I won't waste breath trying to stop you."],
    [id, "But I will ask you this."],
    [id, "Do you know how to handle that blade and shield?"],
    [obj_character, "I've watched my father practice."],
    [id, "Sometimes that's not enough."],
    [id, "Listen close."],
    [id, "Attack when you see an opening."],
    [id, "Keyboard: F.\nGamepad: X."],
    [id, "Block before the hit lands."],
    [id, "Keyboard: R.\nGamepad: Left Shoulder button"],
    [id, "Blocking drains your guard. If it breaks, you're exposed."],
    [id, "If you're badly hurt, use a potion."],
    [id, "Keyboard: Q.\nGamepad: UP directional button."],
    [id, "Monsters may drop coins and runes."],
	[id, "Bring them to me and I can help you enchant them, for a fee of course."],
    [id, "Coins buy supplies. Runes strengthen your gear."],
    [id, "There's a lone skeleton ahead. Practice on that before chasing legends."],
    [obj_character, "And after that?"],
    [id, "After that, you decide whether vengeance is worth dying for."],
    [obj_character, "It is."],
    [id, "Then go on, lass. But don't make your father watch you join him too soon."]
];

show_current_line = function()
{
    var line = dialogue_lines[dialogue_index];

    var speaker_ref = line[0];
    text = line[1];

    var speaker_instance = noone;

    if (instance_exists(speaker_ref))
    {
        speaker_instance = speaker_ref;
    }
    else
    {
        speaker_instance = instance_find(speaker_ref, 0);
    }

    if (speaker_instance != noone)
    {
        with (speaker_instance)
        {
            if (object_index == obj_merchant)
            {
                merchant_say(other.text);
            }
            else
            {
                say(other.text);
            }
        }
    }
};

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