if (!instance_exists(owner))
{
    instance_destroy();
    exit;
}

// Follow the merchant
x = owner.x;
y = owner.y - 48;

// Count down
lifetime--;

if (lifetime <= 0)
{
    instance_destroy();
}