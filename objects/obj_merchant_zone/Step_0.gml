player_was_near = player_near;
player_near = false;

if (!instance_exists(obj_character))
{
    exit;
}

var touching_player = place_meeting(x, y, obj_character);

if (touching_player)
{
    player_near = true;
    obj_character.interact_target = id;

    var first_contact = !player_was_near;

    // --------------------
    // First merchant intro
    // --------------------
    if (first_contact)
    {
        if (instance_exists(merchant_id))
        {
            if (!global.intro_merchant_seen 
            && !global.dialogue_active 
            && !tutorial_timeline_running)
            {
                show_debug_message("Player first contacted merchant zone.");

                // Stop player and face merchant
                with (obj_character)
                {
                    hsp = 0;
                    vsp = 0;

                    move_state = MoveState.IDLE;
                    combat_state = CombatState.NONE;

                    sprite_index = spr_idle_stand1;
                    image_index = 0;
                    image_speed = 1;

                    if (other.merchant_id.x < x)
                    {
                        image_xscale = -1;
                    }
                    else
                    {
                        image_xscale = 1;
                    }
                }

                // Lock gameplay
                global.dialogue_active = true;
                global.tutorial_paused = true;

                tutorial_timeline_running = true;

                // Create the timeline runner
                var runner = instance_create_depth(x, y, -100000, obj_merchant_intro_runner);
                runner.merchant_id = merchant_id;
                runner.zone_id = id;
                runner.start_intro();

                show_debug_message("Merchant intro runner started.");
            }
        }
    }

    // --------------------
    // Repeat greeting after intro
    // --------------------
    if (global.intro_merchant_seen 
    && !global.dialogue_active 
    && !repeat_greeting_done)
    {
        repeat_greeting_done = true;

        if (instance_exists(merchant_id))
        {
            with (merchant_id)
            {
                merchant_greet();
            }
        }
    }
}
else
{
    player_near = false;
    repeat_greeting_done = false;

    if (instance_exists(obj_character))
    {
        if (obj_character.interact_target == id)
        {
            obj_character.interact_target = noone;
        }
    }
}