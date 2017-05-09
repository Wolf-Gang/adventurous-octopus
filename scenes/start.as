#include "backend/dreamland_effects.as"

entity unicorn;

int house_count = 0;

[group lockedhouse]
void lockedhouse()
{
	say("Nobody\'s home, unfortunately.");
	narrative::end();
}

[start]
void unlock_house() {
  
  if(has_flag("house_unlocked")) {
    
    group::enable("lockedhouse?", false);
    group::enable("lockeddoor", false);
    
  }
  
}

[group lockedhouse?]
void lockedhouse_()
{
  if(house_count < 9) {
    say("\"Nobody\'s home, unfortunately.\"");
    narrative::end();
    house_count++;
  } else {
    say("Oh all right, come in.");
    set_flag("house_unlocked");
    narrative::end();
    load_scene("house");
  }
}

[start]
void create_unicorn()
{
  if(has_flag("start_unicorn")) {
    group::enable("meetunicorn", false);
  } else {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(5,4));
  }
}
	
[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(5, 13));
	set_direction(get_player(), direction::up);
}

void create_tree(vec pPosition)
{
	entity tree1 = add_entity("cloud tree", "rustle");
	set_position(tree1, pPosition);
	animation::start(tree1);
}

[start]
void create_cloud_trees()
{
	create_tree(vec(7, 6));
	create_tree(vec(3, 8));
}

void create_bush(vec pPosition, int t)
{
	entity bush;
	if(t == 1)
		bush = add_entity("dreamland", "cloudbush1");
	if(t == 2)
		bush = add_entity("dreamland", "cloudbush2");
	set_position(bush, pPosition);
}

[start]
void create_cloud_bushes()
{
	create_bush(vec(6, 5), 1);
	create_bush(vec(6.5, 5.25), 2);
	create_bush(vec(7.5, 5), 2);
	create_bush(vec(9, 5.15), 1);
	
	create_bush(vec(1, 7.5), 1);
	create_bush(vec(2, 7), 1);
	
	create_bush(vec(7, 9), 1);
	create_bush(vec(6.5, 9.25), 1);
	create_bush(vec(6, 9), 1);
	create_bush(vec(9, 9.25), 1);
}

void create_flower(vec pPosition, int t)
{
	entity flower;
    switch(t)
	{
		case 1:
			flower = add_entity("dreamland", "redflower");
			break;
		case 2:
			flower = add_entity("dreamland", "blueflower");
			break;
		case 3:
			flower = add_entity("dreamland", "orangeflower");
			break;
		case 4:
			flower = add_entity("dreamland", "purpleflower");
			break;
	}
	set_position(flower, pPosition);
	animation::start(flower);
}

//DO NOT LOOK AT THE METHOD BELOW

[start]
void create_meadow()
{
	for(int i = 8; i <= 14; i++)
	{
		for(int j = 1; j <= 4; j++)
		{
			create_flower(vec(j, i), j);
			create_flower(vec(j + 0.5, i + 0.5), j);
		}
	}
	
	for(int i = 11; i <= 14; i++)
	{
		for(int j = 5; j <= 8; j++)
		{
			create_flower(vec(j, i), j-5);
			create_flower(vec(j+0.5, i+0.5), j-5);
		}
	}
}

[group meetunicorn]
void meetunicorn()
{
	music::fade_volume(40, 1);
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
	
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("meetunicorn", false);
  set_flag("start_unicorn");
}