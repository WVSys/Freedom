function audio_controller_get() {
    if (!instance_exists(obj_sound_controller)) {
        return instance_create_layer(0, 0, "Instances", obj_sound_controller);
    }

    return instance_find(obj_sound_controller, 0);
}

function track_play(_track, _sound) {
    var _controller = audio_controller_get();

    with (_controller) {
        if (_track == 1) {
            if (track1_current == _sound && track1_instance != noone && audio_is_playing(track1_instance)) {
                exit;
            }

            if (track1_instance != noone) {
                audio_stop_sound(track1_instance);
            }

            track1_current = _sound;
            track1_instance = audio_play_sound(_sound, 1, true);
            audio_sound_gain(track1_instance, track1_volume, 0);
        }

        if (_track == 2) {
            if (track2_current == _sound && track2_instance != noone && audio_is_playing(track2_instance)) {
                exit;
            }

            if (track2_instance != noone) {
                audio_stop_sound(track2_instance);
            }

            track2_current = _sound;
            track2_instance = audio_play_sound(_sound, 1, true);
            audio_sound_gain(track2_instance, track2_volume, 0);
        }

        if (_track == 3) {
            if (track3_current == _sound && track3_instance != noone && audio_is_playing(track3_instance)) {
                exit;
            }

            if (track3_instance != noone) {
                audio_stop_sound(track3_instance);
            }

            track3_current = _sound;
            track3_instance = audio_play_sound(_sound, 1, true);
            audio_sound_gain(track3_instance, track3_volume, 0);
        }
    }
}

function track_stop(_track) {
    if (!instance_exists(obj_sound_controller)) {
        return;
    }

    with (obj_sound_controller) {
        if (_track == 1) {
            if (track1_instance != noone) {
                audio_stop_sound(track1_instance);
            }

            track1_current = noone;
            track1_instance = noone;
        }

        if (_track == 2) {
            if (track2_instance != noone) {
                audio_stop_sound(track2_instance);
            }

            track2_current = noone;
            track2_instance = noone;
        }

        if (_track == 3) {
            if (track3_instance != noone) {
                audio_stop_sound(track3_instance);
            }

            track3_current = noone;
            track3_instance = noone;
        }
    }
}

function track_stop_all() {
    track_stop(1);
    track_stop(2);
    track_stop(3);
}

function track_set_volume(_track, _volume) {
    var _controller = audio_controller_get();
    var _vol = clamp(_volume, 0, 1);

    with (_controller) {
        if (_track == 1) {
            track1_volume = _vol;

            if (track1_instance != noone) {
                audio_sound_gain(track1_instance, track1_volume, 0);
            }
        }

        if (_track == 2) {
            track2_volume = _vol;

            if (track2_instance != noone) {
                audio_sound_gain(track2_instance, track2_volume, 0);
            }
        }

        if (_track == 3) {
            track3_volume = _vol;

            if (track3_instance != noone) {
                audio_sound_gain(track3_instance, track3_volume, 0);
            }
        }
    }
}

function random_ambience_set(_sounds) {
    var _controller = audio_controller_get();

    with (_controller) {
        random_ambience_sounds = _sounds;

        random_ambience_timer = irandom_range(
            random_ambience_min_time,
            random_ambience_max_time
        );
    }
}

function random_ambience_stop()
{
    if (!instance_exists(obj_sound_controller))
    {
        return;
    }

    with (obj_sound_controller)
    {
        // Stop any ambience sounds that are already playing
        for (var i = 0; i < array_length(random_ambience_instances); i++)
        {
            var _inst = random_ambience_instances[i];

            if (_inst != noone)
            {
                audio_stop_sound(_inst);
            }
        }

        // Clear active ambience handles
        random_ambience_instances = [];

        // Clear future ambience choices
        random_ambience_sounds = [];

        // Reset timer
        random_ambience_timer = room_speed * 5;
    }
}

function random_ambience_set_volume(_volume) {
    var _controller = audio_controller_get();

    with (_controller) {
        random_ambience_volume = clamp(_volume, 0, 1);
    }
}

function random_ambience_set_delay(_min_seconds, _max_seconds) {
    var _controller = audio_controller_get();

    with (_controller) {
        random_ambience_min_time = room_speed * _min_seconds;
        random_ambience_max_time = room_speed * _max_seconds;

        random_ambience_timer = irandom_range(
            random_ambience_min_time,
            random_ambience_max_time
        );
    }
}

function sfx_play(_sound) {
    var _controller = audio_controller_get();

    var _inst = audio_play_sound(_sound, 1, false);

    with (_controller) {
        audio_sound_gain(_inst, sfx_volume, 0);
    }

    return _inst;
}

function sfx_play_random(_sounds) {
    if (array_length(_sounds) <= 0) {
        return noone;
    }

    var _index = irandom(array_length(_sounds) - 1);
    return sfx_play(_sounds[_index]);
}

function sfx_set_volume(_volume) {
    var _controller = audio_controller_get();

    with (_controller) {
        sfx_volume = clamp(_volume, 0, 1);
    }
}

function room_audio_start() {
    track_stop_all();
    random_ambience_stop();
}

function room_audio_silent() {
    track_stop_all();
    random_ambience_stop();
}