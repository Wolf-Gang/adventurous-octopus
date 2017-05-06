[start]
void dreamland_clouds()
{
	const float speed = 0.3;

	entity cloud = add_entity("dreamland", "cloud");
	set_anchor(cloud, anchor::bottom);
	set_parallax(cloud, 2);
	set_color(cloud, 255, 255, 255, 100);
	set_scale(cloud, vec(4, 4));
	set_depth(cloud, -100);
	
	// First set
	set_position(cloud, focus::get() - vec(random(-4, 4), 2));
	
	do
	{
		set_position(cloud, get_position(cloud) + vec(0, get_delta()*speed));
		
		if (get_position(cloud).y >= focus::get().y + 10)
			set_position(cloud, focus::get() - vec(random(-4, 4), 2));
	} while(yield());
}

void unicorn_disappear(entity pUnicorn)
{
	scoped_entity hearts = add_entity("heartsburst");
	set_position(hearts , get_position(pUnicorn));
	
	remove_entity(pUnicorn);
	animation::start(hearts);
	animation::play_wait(hearts);
}

