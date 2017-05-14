[start]
void start()
{
	set_position(get_player(), vec(17.5, 6.5));
}


[start]
void create_flower()
{
	entity flower = add_entity("dreamland", "redflower");
	set_position(flower, vec(4, 3));
	animation::start(flower);
}

array<entity> phloophs(5);

[start]
void running_phlooph()
{
	entity phlooph = add_entity("little phlooph");
}

[start]
void create_phloophs()
{
	vec center(4, 3);
	for (uint i = 0; i < 5; i++)
	{
		phloophs[i] = add_entity("little phlooph");
		set_position(phloophs[i], vec(0, 1).rotate((360/5)*i) + center);
		animation::start(phloophs[i]);
	}
	
}

