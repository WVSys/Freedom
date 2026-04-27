if (!instance_exists(owner))
{
    instance_destroy();
    exit;
}

// Follow the owner
x = owner.x + x_offset;
y = owner.y + y_offset;

// Count down
lifetime--;

if (lifetime <= 0)
{
    instance_destroy();
}