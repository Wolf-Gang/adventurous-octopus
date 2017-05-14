#include "backend/float.as"
#include "backend/shadows.as"

[start]
void start()
{
	music::open("doodle58");
	music::volume(100);
	set_position(get_player(), vec(17.5, 6.5));
}


[start]
void running_phlooph()
{
	scoped_entity phlooph = add_entity("little phlooph");
	set_position(phlooph, vec(16.5, 6.5));
	move(phlooph, direction::left, 14, 2);
}

vec center_of_phloophs(7, 3);
array<entity> phloophs(5);

[start]
void create_flower()
{
	entity flower = add_entity("dreamland", "redflower");
	set_position(flower, center_of_phloophs);
	animation::start(flower);
}

[start]
void create_phloophs()
{
	for (uint i = 0; i < phloophs.length(); i++)
	{
		phloophs[i] = add_entity("little phlooph");
		set_position(phloophs[i], vec(0, 1).rotate((360/phloophs.length())*i) + center_of_phloophs);
		animation::start(phloophs[i]);
	}
	
}

const vec game_position(-10, -10);

void goto_area()
{
	get_boundary_position(game_position); // TODO: Fix these names in the engine
	get_boundary_size(vec(10, 8));
	set_position(get_player(), (game_position + vec(10, 8)/2) + vec(0, 2));
}

[group phloophs]
void phloophs_talk()
{
	say("Hello.");
	nl("This is our majestic hideout.");
	fsay("Have you come to catch us?");
	if (select("Yes", "No") == option::first)
	{
		narrative::hide();
		music::stop();
		for (uint i = 0; i < phloophs.length(); i++)
			set_atlas(phloophs[i],"scary");
		fx::sound("heh");
		wait(0.5);
		
		say("We see.");
		nl("PREPARE TO BE ERASED.");
		
		narrative::hide();
		fx::sound("bad");
		goto_area();
		
		wait(1);
		phlooph_game();
	}else{
		say("I hope we will be the bestest of friends.");
		narrative::end();
		move(get_player(), direction::down, 0.5, 0.5);
		player::lock(false);
	}
}

void ded()
{
	player::lock(true);
	entity bg = add_entity("pixel");
	make_gui(bg, 0);
	set_scale(bg, vec(10, 10)*32);
	set_anchor(bg, anchor::topleft);
	set_color(bg, 0, 0, 0, 255);
	
	fx::sound("heh");
	
	music::stop();
	
	narrative::show();
	narrative::set_interval(80);
	say("You ded");
	load_scene("dangerous_game");
}

void phlooph_attack(float pSpeed)
{
	const uint safe_one = random(0, 10);
	
	array<entity> things(10);
	for (uint i = 0; i < things.length(); i++)
	{
		if (i != safe_one)
		{
			things[i] = add_entity("little phlooph");
			set_atlas(things[i], "scary");
			set_position(things[i], game_position + vec(0.5 + i, 1));
		}
	}
	wait(1);
	
	const float duration = 8/pSpeed;
	float timer = 0;
	do{
		timer += get_delta();
		for (uint i = 0; i < things.length(); i++)
			if (i != safe_one)
			{
				set_position(things[i], get_position(things[i]) + vec(0, get_delta()*pSpeed));
				
				// Check hit
				if (get_position(get_player()).distance(get_position(things[i])) < 0.4)
					ded();
			}
	}while(yield() && timer < duration);
	
	for (uint i = 0; i < things.length(); i++)
		remove_entity(things[i]);
}

void light_sparkles(vec pPosition)
{
	create_thread(function(args)
	{
		vec pPosition = vec(args["pPosition"]);
		scoped_entity sparks = add_entity("light", "light_disperse");
		set_position(sparks, pPosition);
		animation::play_wait(sparks);
	}, dictionary = {{"pPosition", pPosition}});
}

void phlooph_drop_attack(uint amount, float pSpeed)
{
	array<entity> things(amount);
	for (uint i = 0; i < things.length(); i++)
	{
		things[i] = add_entity("little phlooph");
		set_atlas(things[i], "scary");
		set_z(things[i], 8 + random(0, 10));
		shadows::add(things[i]);
		set_position(things[i], game_position + vec(random(1, 10), random(1, 8)));
	}
	
	wait(1);
	
	uint alive = amount;
	do{
		for (uint i = 0; i < things.length(); i++)
		{
			if (things[i].is_valid())
			{
				set_z(things[i], get_z(things[i]) - pSpeed*get_delta());
				if (get_z(things[i]) <= 0)
				{
					// Check hit
					if (get_position(get_player()).distance(get_position(things[i])) < 0.4)
						ded();
					
					light_sparkles(get_position(things[i]));
					remove_entity(things[i]);
					--alive;
				}
			}
		}
	}while(yield() && alive != 0);
}

void phlooph_game()
{
	say("WE KNOW DADDY SENT YOU");
	
	entity bg = add_entity("pixel");
	set_position(bg, game_position);
	set_scale(bg, vec(10, 10)*32);
	set_anchor(bg, anchor::topleft);
	set_color(bg, 100, 50, 50, 255);
	set_depth(bg, fixed_depth::background);
	
	entity scary_phlooph = add_entity("little phlooph");
	set_atlas(scary_phlooph, "scary");
	set_position(scary_phlooph, vec(-5, -7));
	shadows::add(scary_phlooph);
	set_z(scary_phlooph, 1);
	float_entity(scary_phlooph, 1, 2, -1);
	
	say("HEHEHEHEHE.");
	say("YOU WILL NEVER BRING US TO DADDY.");
	narrative::end();
	player::lock(false);
	create_thread(function(args)
	{
		entity bg = entity(args["bg"]);
		while(yield())
		{
			wait(1);
			set_color(bg, random(50, 150)
				,  random(50, 150)
				, random(50, 150), 255);
		}
	}, dictionary = {{"bg", bg}});
	
	music::volume(70);
	music::open("doodle109");
	
	phlooph_attack(2);
	say("YOU WILL NEVER GET AWAY.");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(3);
	say("UGH!");
	nl("We'll have to get a little more serious!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(5, 4);
	say("We will never be caught!");
	nl("We don't like daddy!");
	say("AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(10, 7);
	say("AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(20, 7);
	say("AAAAAHHHHH");
	nl("ONCE AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(40, 7);
	
	say("Hmmmmm... Quite persistent you are.");
	nl("Or are we just tooooo easy for you.");
	nl("We see how it is.");
	nl("PREPARE FOR MORE.");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(3);
	phlooph_drop_attack(10, 5);
	
	phlooph_attack(4);
	phlooph_drop_attack(20, 7);
	
	say("Daddy is always saying we would be the next leaders of the dreamland.");
	nl("But we don't want do!");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(4);
	phlooph_attack(3);
	
	phlooph_drop_attack(40, 7);
	phlooph_attack(4);
	phlooph_drop_attack(20, 8);
	
}



