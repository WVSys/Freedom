player_was_near = player_near;
player_near = false;

/*if (instance_exists(obj_character))
{
    if (place_meeting(x, y, obj_character))
    {
        player_near = true;
        obj_character.interact_target = id;

        // Runs only on the first frame the player enters the merchant zone
        if (!player_was_near)
        {
            if (instance_exists(merchant_id))
            {
                // First time only: auto-start exposition/tutorial dialogue
                if (!global.intro_merchant_seen && !global.dialogue_active)
                {
                    var dc = instance_find(obj_dialogue_controller, 0);

                    if (dc != noone)
                    {
                        dc.start_dialogue(merchant_id.intro_dialogue, "merchant_intro");
                    }
                    else
                    {
                        show_debug_message("obj_dialogue_controller does not exist");
                    }
                }
                // After intro has already happened, merchant can greet normally
                else if (global.intro_merchant_seen && !global.dialogue_active)
                {
                    with (merchant_id)
                    {
                        merchant_say("Hey there! You find anything interesting?");
                    }
                }
            }
            else
            {
                show_debug_message("merchant_id does not exist");
            }
        }

        // Normal merchant interaction ONLY after intro has been seen
        if (global.intro_merchant_seen && !global.dialogue_active && !global.merchant_menu_open)
        {
            var interact_pressed = keyboard_check_pressed(ord("E"));

            if (gamepad_is_connected(0))
            {
                interact_pressed = interact_pressed || gamepad_button_check_pressed(0, gp_face1);
            }

            if (interact_pressed)
            {
                global.merchant_menu_open = true;

                // Put your existing merchant menu opening code here.
                // Example if your merchant has an open function:
                //
                // if (instance_exists(merchant_id))
                // {
                //     with (merchant_id)
                //     {
                //         open_merchant_menu();
                //     }
                // }
            }
        }
    }
    else
    {
        if (obj_character.interact_target == id)
        {
            obj_character.interact_target = noone;
        }
    }
}
else
{
    show_debug_message("obj_character does not exist");
}

if (!global.intro_merchant_seen && !global.dialogue_active && !tutorial_timeline_running)
{
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

    global.dialogue_active = true;
    global.tutorial_paused = true;

    tutorial_timeline_running = true;

    var runner = instance_create_depth(x, y, -100000, obj_merchant_intro_runner);
    runner.merchant_id = merchant_id;
    runner.zone_id = id;

    show_debug_message("Merchant intro runner started.");
*/
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

    if (first_contact)
    {
        if (instance_exists(merchant_id))
        {
            if (!global.intro_merchant_seen && !global.dialogue_active && !tutorial_timeline_running)
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
}
else
{
    if (obj_character.interact_target == id)
    {
        obj_character.interact_target = noone;
    }
}