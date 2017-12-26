
enum flower_type {
  red,
  blue,
  orange,
  purple,
}

void create_flower(vec pPosition, flower_type t)
{
	entity flower;
    switch(t)
	{
		case flower_type::red:
			flower = add_entity("dreamland", "redflower");
			break;
		case flower_type::blue:
			flower = add_entity("dreamland", "blueflower");
			break;
		case flower_type::orange:
			flower = add_entity("dreamland", "orangeflower");
			break;
		case flower_type::purple:
			flower = add_entity("dreamland", "purpleflower");
			break;
	}
	set_position(flower, pPosition);
	animation::start(flower);
}

void create_flower_patch(vec pPosition, vec pSize, int color_width = 1, flower_type start_color = flower_type::red)
{
	for (float x = 0; x < pSize.x; x += 1)
	{
		for (float y = 0; y < pSize.y; y += 1)
		{
			if ((x + y)%2 == 0)
			{
				const vec position(vec(x, y)/2 + pPosition);
				const flower_type type = flower_type((floor(x/color_width) + float(start_color))%4);
				create_flower(position, type);
			}
		}
	}
}