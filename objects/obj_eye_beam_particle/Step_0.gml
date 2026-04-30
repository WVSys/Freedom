// Move particle
x += hsp;
y += vsp;

// Fade out
life--;

if (life_max > 0) {
    particle_alpha = life / life_max;
}

// Shrink slightly
particle_size = max(0, particle_size - 0.05);

// Destroy when finished
if (life <= 0 || particle_size <= 0) {
    instance_destroy();
}