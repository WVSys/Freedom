if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
{
    option = 1 - option; // toggle between 0 and 1
}

if (keyboard_check_pressed(vk_enter))
if (option == 0)
{
    // Reset ending state so it doesn't instantly retrigger
    global.ending_started = false;
    global.death_screen_active = false;

    // Respawn from checkpoint
    global.respawn_from_checkpoint = true;
	with (obj_character) {
		ending_lock = false;	
	}
    load_checkpoint();

    room_goto(Forest);
}
	else
	{
	    game_end();
}