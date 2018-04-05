
#include "worfel_quest.as"
#include "flowers.as"

void create_tree(vec pPosition)
{
	entity tree1 = add_entity("small cloud tree", "rustle");
	set_position(tree1, pPosition);
	animation::start(tree1);
  
  const vec offset = pixel(-29, -16);
  const vec size = offset * vec(-2, -.6);
  collision::create(pPosition + offset, size);
}

void create_bush(vec pPosition, int t)
{
	entity bush;
	if(t == 1)
		bush = add_entity("dreamland", "cloudbush1");
	else if(t == 2)
		bush = add_entity("dreamland", "cloudbush2");
  else
  {
    eprint("t can onely be 1 and 2");
    return;
  }
	set_position(bush, pPosition);
  
  const vec offset = pixel(-7, -8);
  const vec size = pixel(14, 2);
  collision::create(pPosition + offset, size);
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
	set_parallax(priv::cloud, 0.1);
	set_color(priv::cloud, 1, 1, 1, 0.4);
	set_scale(priv::cloud, vec(4, 4));
	set_depth(priv::cloud, -100);
  
	// First set
	set_position(priv::cloud, focus::get() - vec(random(-4, 4), 2));
	
	do
	{
		set_position(priv::cloud, get_position(priv::cloud) + vec(0, get_delta()*speed));
		
		if (get_position(priv::cloud).y >= focus::get().y + pixel(get_display_size()).y)
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

void create_forest(vec pPosition, vec pSize)
{
  for (float y = 0; y < pSize.y; y++)
    if (y % 2 == 0)
      for (float x = 0; x < pSize.x; x++)
          create_tree(pPosition + vec(x*2, y));
    else
      for (float x = 0; x < pSize.x - 1; x++)
          create_tree(pPosition + vec(x*2 + 1, y));
}
