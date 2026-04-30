// Random ambience system
if (array_length(random_ambience_sounds) > 0) {
    random_ambience_timer--;

    if (random_ambience_timer <= 0) {
        var _sound = random_ambience_sounds[irandom(array_length(random_ambience_sounds) - 1)];
        var _inst = audio_play_sound(_sound, 1, false);

        audio_sound_gain(_inst, random_ambience_volume, 0);

        random_ambience_timer = irandom_range(
            random_ambience_min_time,
            random_ambience_max_time
        );
    }
}