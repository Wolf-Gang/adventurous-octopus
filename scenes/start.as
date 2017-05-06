
entity unicorn;

[group lockedhouse]
void lockedhouse()
{
	say("Nobodies home unfortunately.");
	narrative::end();
}

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

[start]
void create_unicorn()
{
	unicorn = add_entity("unicorn", "talk");
	set_position(unicorn, vec(5,4));
}
	
[start]
void start()
{
	music::open("doodle104");
	music::volume(70);
	set_position(get_player(), vec(5, 7));
}

[group meetunicorn]
void meetunicorn()
{
	player::lock(true);
	focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("AH Hello here!");
	say("I'm the majestic unicorn\nof DEATH");
	nl("A fighter against world hunger.");
	say("This is the magical dreamland\nof, well, I don't know...");
	
	set_atlas(unicorn, "talk_headup");
	nl("DREAMS?");
	set_atlas(unicorn, "talk");
	
	say("I will be your guide.\nIt's too easy to get lost here.");
	nl("And drown in your own sorrow.");
	narrative::end();
	
	
	{
		scoped_entity hearts = add_entity("heartsburst");
		set_position(hearts , get_position(unicorn));
		
		remove_entity(unicorn);
		animation::start(hearts);
		animation::play_wait(hearts);
	}
	
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("meetunicorn", false);
}