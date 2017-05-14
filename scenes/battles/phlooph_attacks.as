class phlooph_attack_info
{
	entity object;
	bool bottom;
};

void phlooph_attack(float pSpeed, bool pHas_bottom = false)
{
	const uint count = 10;
	
	const uint safe_one = random(0, 10);
	
	array<phlooph_attack_info> things(count);
	for (uint i = 0; i < count; i++)
	{
		if (i != safe_one)
		{
			things[i].object = add_entity("little phlooph");
			set_atlas(things[i].object, "scary");
			
			things[i].bottom = rand()%2 == 0 && pHas_bottom;
			if (things[i].bottom)
				set_position(things[i].object, game_position + vec(0.5 + i, 8));
			else
				set_position(things[i].object, game_position + vec(0.5 + i, 1));
		}
	}
	
	wait(1);
	
	const float duration = 8/pSpeed;
	float timer = 0;
	do{
		timer += get_delta();
		for (uint i = 0; i < count; i++)
			if (i != safe_one)
			{
				set_position(things[i].object, get_position(things[i].object)
					+ vec(0, get_delta()*pSpeed)
					*(things[i].bottom ? -1 : 1));
				
				// Check hit
				if (check_hit(things[i].object, 0.4))
					ded("dangerous_game");
			}
	}while(yield() && timer < duration);
	
	for (uint i = 0; i < things.length(); i++)
		remove_entity(things[i].object);
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
					if (check_hit(things[i], 0.4))
						ded("dangerous_game");
					
					light_sparkles(get_position(things[i]));
					remove_entity(things[i]);
					--alive;
				}
			}
		}
	}while(yield() && alive != 0);
}

