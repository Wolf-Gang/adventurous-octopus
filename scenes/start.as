#include "backend/dreamland_effects.as"

entity unicorn;

entity key;


[group lockedhouse]
void lockedhouse()
{
	say("Nobody\'s home, unfortunately.");
	narrative::end();
}

[start]
void make_key() {
  key = add_entity("dreamland", "key");
  set_visible(key, false);
  set_depth(key, 100);
  set_position(key, vec(2.5, 5));
  animation::start(key);
  group::enable("key", false);
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
  if(!has_flag("keese")) {
    say("\"Nobody\'s home, unfortunately.\"");
    narrative::end();
    set_visible(key, true);
    move(key, vec(2.5, 7), 1.3444);
    group::enable("key", true);
  } else {
    say("\"click\"");
    set_flag("house_unlocked");
    load_scene("house", "front_door");
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
	set_position(get_player(), vec(5.5, 13));
	set_direction(get_player(), direction::up);
}

void create_tree(vec pPosition)
{
	entity tree1 = add_entity("small cloud tree", "rustle");
	set_position(tree1, pPosition);
	animation::start(tree1);
}

[start]
void create_cloud_trees()
{
	create_tree(vec(7.5, 6));
	create_tree(vec(3, 7.6));
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
  //top-right
	//create_bush(vec(6, 5), 1);
	create_bush(vec(6.5, 5.25), 2);
	create_bush(vec(7.5, 5), 2);
	create_bush(vec(9, 5.15), 1);
	
  //left
	create_bush(vec(1, 7.5), 1);
	create_bush(vec(2, 7), 1);
	
  //bottom-right
	create_bush(vec(7, 9), 1);
	create_bush(vec(6.5, 9.25), 1);
	//create_bush(vec(6, 9), 1);
	create_bush(vec(9, 9.25), 1);
}

enum flower_type {
  red = 1,
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

[start]
void create_meadow()
{
  //left
	for(float i = 8; i <= 14; i++)
	{
		for(int j = 1; j <= 4; j++)
		{
			create_flower(vec(j, i), flower_type(j));
			create_flower(vec(j + 0.5, i + 0.5), flower_type(j));
		}
	}
	
  //right
	for(float i = 11; i <= 14; i++)
	{
		for(int j = 1; j <= 3; j++)
		{
			create_flower(vec(j + 5.5, i), flower_type(j));
			create_flower(vec(j + 6, i + 0.5), flower_type(j));
		}
	}
}

[group key]
void find_key() {
  remove_entity(key);
  set_flag("keese");
  group::enable("key", false);
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