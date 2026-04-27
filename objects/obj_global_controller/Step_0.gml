if(keyboard_check_pressed(ord("P"))) global.debug = !global.debug

if (keyboard_check_pressed(vk_f11)) {
	window_enable_borderless_fullscreen(true);
    window_set_fullscreen(!window_get_fullscreen());
}




