start_xscale = 1;

pieces = [
        spr_skeleton_destruction,
        spr_skeleton_skull,
        spr_skeleton_hip,
        spr_skeleton_sword,
		spr_skeleton_hip,
		spr_skeleton_shield,
		spr_ribcage_destruction
    ];

count = array_length(pieces);

px = array_create(count);
py = array_create(count);
phsp = array_create(count);
pvsp = array_create(count);
pgrav = array_create(count);
pang = array_create(count);
prot = array_create(count);
planded = array_create(count);

for (var i = 0; i < count; i++)
{
    px[i] = x;
    py[i] = y;

    phsp[i] = random_range(-3, 3) * start_xscale;
    pvsp[i] = random_range(-5, -2);
    pgrav[i] = 0.3;

    pang[i] = random(360);
    prot[i] = random_range(-8, 8);

    planded[i] = false;
}