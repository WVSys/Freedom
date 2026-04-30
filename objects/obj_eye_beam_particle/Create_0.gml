// Particle movement
hsp = 0;
vsp = 0;

// Particle appearance
particle_size = random_range(2, 5);
particle_alpha = 1;
particle_color = c_lime;

// Particle lifetime
life = room_speed * 0.25;
life_max = life;

// Optional glow trail
trail_length = random_range(4, 10);