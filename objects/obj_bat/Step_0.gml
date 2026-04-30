
// pause handling
if (global.game_paused || global.tutorial_pause)
{
    image_speed = 0;
    exit;
}
else
{
    image_speed = 1;
}

// --------------------------
// PATH BACK-AND-FORTH
// --------------------------
// Handle reversing
if (path_index != -1)
{
    if (path_position >= 0.99)
    {
        path_speed = -path_speed_value;
    }
    else if (path_position <= 0.01)
    {
        path_speed = path_speed_value;
    }
}

// ALWAYS face movement direction (this is the important part)
if (path_speed > 0)
{
    image_xscale = -1;
}
else if (path_speed < 0)
{
    image_xscale = 1;
}
// --------------------------
// DAMAGE PLAYER ON CONTACT
// --------------------------
if (hit_cooldown > 0)
{
    hit_cooldown--;
}

if (hit_cooldown <= 0 && place_meeting(x, y, obj_character))
{
    with (obj_character)
    {
        if (!is_dead)
        {
            hp -= 1;
        }
    }

    hit_cooldown = 30;
}

if (state == EnemyState.DEAD)
{
    enemy_drop_coins();

    drop_rune(
        x+rune_drop_x_offset,
        y+rune_drop_y_offset,
        rune_value,
        rune_sword_chance,
        rune_shield_chance,
        rune_armor_chance
    );

    state_dead();
    exit;
}
