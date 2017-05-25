
const float collision_radius = 0.6;

class phlooph_attack_info
{
	entity object;
	bool bottom;
};

void phlooph_attack(float pSpeed, bool pHas_bottom = false)
{
	const uint count = 10; // Fills the screen
	const uint randomize_count = 5;
	const uint safe_one = random(0, 10);
	
	// Create the things that go at you
	array<phlooph_attack_info> things(count);
	for (uint i = 0; i < count; i++)
	{
		if (i != safe_one || pHas_bottom)
		{
			// Use scary phlooph
			things[i].object = add_entity("little phlooph");
			set_atlas(things[i].object, "scary");
			
			// Choose if it is a bottom phlooph (If pHas_bottom is true)
			things[i].bottom = i%2 == 0 && pHas_bottom;
			
			if (things[i].bottom)
				set_position(things[i].object, game_position + vec(0.5 + i, 8));
			else
				set_position(things[i].object, game_position + vec(0.5 + i, 1));
		}
	}
  
  // Randomize
  if (pHas_bottom)
  {
    for (uint i = 0; i < randomize_count; i++)
    {
      uint index_1 = random(0, count);
      uint index_2 = random(0, count);
      
      // Swap stuffs
      const vec temp_1 = get_position(things[index_1].object);
      const vec temp_2 = get_position(things[index_2].object);
      const bool is_bottom = things[index_1].bottom;
      
      set_position(things[index_1].object, vec(temp_1.x, temp_2.y));
      things[index_1].bottom = things[index_2].bottom;
      
      set_position(things[index_2].object, vec(temp_2.x, temp_1.y));
      things[index_2].bottom = is_bottom;
    }
  }
	
	wait(1);
	
	const float duration = 8/pSpeed;
	float timer = 0;
	do{
		timer += get_delta();
		for (uint i = 0; i < count; i++)
			if (i != safe_one || pHas_bottom)
			{
				// Move phloophs
				set_position(things[i].object, get_position(things[i].object)
					+ vec(0, get_delta()*pSpeed)
					*(things[i].bottom ? -1 : 1)); // Move up if bottom phlooph
				
				// Check hit
				if (check_hit(things[i].object, collision_radius))
					ded();
			}
	}while(yield() && timer < duration);
	
	for (uint i = 0; i < things.length(); i++)
    if (things[i].object.is_valid())
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

void phlooph_drop_attack(uint pAmount, float pSpeed, bool pRandom_move = true)
{
	array<entity> things(pAmount);
	array<vec> movement(pAmount);
  
	// Create the phloophs
	for (uint i = 0; i < pAmount; i++)
	{
		things[i] = add_entity("little phlooph");
		set_atlas(things[i], "scary");
		set_z(things[i], 8 + random(0, 10));
		shadows::add(things[i]);
		set_position(things[i], game_position + vec(random(1, 10), random(1, 8)));
    movement[i] = vec(random(-10, 10), random(-10, 10))/10;
	}
	
	wait(1);
	
	uint alive = pAmount;
	do{
		for (uint i = 0; i < pAmount; i++)
		{
			if (things[i].is_valid())
			{
				// Move down
				set_z(things[i], get_z(things[i]) - pSpeed*get_delta());
				
				// Random jittery movement
				if (pRandom_move)
					set_position(things[i]
						, get_position(things[i]) + movement[i]*get_delta());
				
				if (get_z(things[i]) <= 0)
				{
					// Check hit
					if (check_hit(things[i], collision_radius))
						ded();
					
					light_sparkles(get_position(things[i]));
					remove_entity(things[i]);
					--alive;
				}
			}
		}
	}while(yield() && alive != 0);
}

