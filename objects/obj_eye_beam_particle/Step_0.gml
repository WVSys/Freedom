// move particle
x += hsp;
y += vsp;

// fade out
life--;

if (life_max > 0) {
    particle_alpha = life / life_max;
}

// shrink slightly
particle_size = max(0, particle_size - 0.05);

// destroy when finished
if (life <= 0 || particle_size <= 0) {
    instance_destroy();
}