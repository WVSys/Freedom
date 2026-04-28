active = false;

dialogue_lines = [];
dialogue_index = 0;

text = "";
on_finish_type = "";

line_timer = 0;

start_dialogue = function(_lines, _finish_type)
{
    active = true;
    dialogue_lines = _lines;
    dialogue_index = 0;
    on_finish_type = _finish_type;

    global.dialogue_active = true;

    show_current_line();
};

show_current_line = function()
{
    if (dialogue_index < 0 || dialogue_index >= array_length(dialogue_lines))
    {
        return;
    }

    var line = dialogue_lines[dialogue_index];

    var speaker_ref = line[0];
    text = line[1];

    var speaker_instance = noone;

    // Player line
    if (speaker_ref == obj_character)
    {
        speaker_instance = instance_find(obj_character, 0);
    }
    // Merchant object line
    else if (speaker_ref == obj_merchant)
    {
        speaker_instance = instance_find(obj_merchant, 0);
    }
    // Direct instance id, like merchant_id or id
    else if (instance_exists(speaker_ref))
    {
        speaker_instance = speaker_ref;
    }

    if (speaker_instance != noone)
    {
        with (speaker_instance)
        {
            if (object_index == obj_merchant)
            {
                merchant_say(other.text);
            }
            else if (object_index == obj_character)
            {
                say(other.text);
            }
        }
    }

    // Auto-read timing:
    // shorter lines stay at least 90 frames
    // longer lines stay longer based on text length
    line_timer = max(90, string_length(text) * 4);
};