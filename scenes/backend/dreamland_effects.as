
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


namespace priv
{
	entity cloud;
}

void remove_dreamland_effects()
{
	remove_entity(priv::cloud);
}

[start]
void dreamland_clouds()
{
	const float speed = 0.3;

	priv::cloud = add_entity("dreamland", "cloud");
	set_anchor(priv::cloud, anchor::bottom);
	set_parallax(priv::cloud, 2);
	set_color(priv::cloud, 255, 255, 255, 100);
	set_scale(priv::cloud, vec(4, 4));
	set_depth(priv::cloud, -100);
	
	// First set
	set_position(priv::cloud, focus::get() - vec(random(-4, 4), 2));
	
	do
	{
		set_position(priv::cloud, get_position(priv::cloud) + vec(0, get_delta()*speed));
		
		if (get_position(priv::cloud).y >= focus::get().y + 10)
			set_position(priv::cloud, focus::get() - vec(random(-4, 4), 2));
	} while(yield() && priv::cloud.is_valid());
}

void unicorn_disappear(entity pUnicorn)
{
	scoped_entity hearts = add_entity("heartsburst");
	set_position(hearts, get_position(pUnicorn));
	
	fx::sound("FX_away");
	remove_entity(pUnicorn);
	animation::start(hearts);
	animation::play_wait(hearts);
}

entity mc_hat;

[start]
void flower_hat() {
  
  if(has_flag("Flower")) {
    
    mc_hat = add_entity("dreamland", "purpleflower");
    set_position(mc_hat, get_position(get_player()) + vec(0, -.9));
    //set_z(mc_hat, .9);
    add_child(get_player(), mc_hat);
    
  }
  
}

