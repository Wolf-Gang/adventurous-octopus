
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
				if (check_hit(things[i], 0.4))
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
					if (check_hit(things[i], 0.4))
						ded();
					
					light_sparkles(get_position(things[i]));
					remove_entity(things[i]);
					--alive;
				}
			}
		}
	}while(yield() && alive != 0);
}

