
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
	set_position(hearts , get_position(pUnicorn));
	
	remove_entity(pUnicorn);
	animation::start(hearts);
	animation::play_wait(hearts);
}

