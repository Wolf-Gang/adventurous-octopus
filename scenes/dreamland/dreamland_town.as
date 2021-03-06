#include "../backend/dreamland_effects.as"
#include "town.as"

entity unicorn;

entity key;
	
[start]
void start()
{
	music::open("doodle104_2");
	
	music::set_volume(0.7);
	set_position(get_player(), vec(5.5, 22));
	set_direction(get_player(), direction::up);
}

[start]
void create_welcome_sign()
{
  entity sign = add_entity("dreamland", "welcome");
  set_position(sign, vec(3, 19));
}

[start]
void doyouevenbench()
{
  create_bench(vec(4, 1), true);
  create_bench(vec(6.5, 17.5));
}

//Start
///////////////////////////////////////////////////////////////////////////////////////////////////
//Houses

/*
  2
1
  0
*/
array<entity> houses(3);

[start]
void make_houses() {
  
  houses[0] = add_entity("dreamland", "house");
  set_position(houses[0], vec(8, 9));
  houses[1] = add_entity("dreamland", "house");
  set_position(houses[1], vec(2, 5));
  houses[2] = add_entity("dreamland", "house");
  set_position(houses[2], vec(8, 3));
}

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
  set_position(key, vec(2.5, 12.1));
  set_z(key, 2.1);
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
    
    move_z(key, 0, 1.3444);
    group::enable("key", true);
  } else {
    say("\"click\"");
    set_flag("house_unlocked");
    load_scene("dreamland/house", "front_door");
  }
}

[group key]
void find_key() {
  remove_entity(key);
  set_flag("keese");
  group::enable("key", false);
}

//Houses
//////////////////////////////////////////////////////////////////////////////////////////////////
//Foliage

[start]
void create_cloud_trees()
{
	create_tree(vec(3, 12.4));
	create_tree(vec(8, 14.9));
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
	create_bush(vec(2, 6.9), 1);
	create_bush(vec(3, 7.1), 1);
	create_bush(vec(4, 6.9), 1);
	create_bush(vec(4.5, 7.5), 1);
	
  //bottom-right
	create_bush(vec(7, 9), 1);
	//create_bush(vec(6.5, 9.25), 1);
	//create_bush(vec(6, 9), 1);
	create_bush(vec(9, 9.25), 1);
  
	create_bush(vec(6.5, 6), 2);
	create_bush(vec(6.5, 6.7), 1);
	create_bush(vec(6.5, 7.4), 2);
	create_bush(vec(6.5, 7.9), 1);
	create_bush(vec(6.5, 8.5), 1);
  
}

[start]
void create_meadow()
{
	// Left
	create_flower_patch(vec(1, 8), vec(8, 20), 2);
  
	// Left
	//create_flower_patch(vec(1, 12), vec(8, 12), 2);
	
	// Right
	create_flower_patch(vec(6.5, 11), vec(6, 14), 2);
}

//Foliage
////////////////////////////////////////////////////////////////////////////////////////////////////
//Unicorn things

[start]
void create_unicorn()
{
  if (!has_flag("meet_unicorn")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(5.5, 14));
  } else {
    
    group::enable("meetunicorn", false);
    
  }
}

[group meetunicorn]
void meetunicorn()
{
	music::fade_volume(0.4, 1);
	player::lock(true);
	focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("AH Hello there!");
	say("I'm the majestic unicorn of <b>DEATH</b>.");
	nl("A fighter against world hunger.");
	say("This is the magical dreamland of, well, I don't know...");
	
	set_atlas(unicorn, "talk_headup");
	nl("<wave>DREAMS?</wave>");
	set_atlas(unicorn, "talk");
	
	say("I will be your guide. It's too easy to get lost here...");
	nl("And drown in your own sorrow.");
	
	say("Explore if you want. You will find me up north.");
	narrative::end();
	
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(0.7, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("meetunicorn", false);
  set_flag("meet_unicorn");
}

//Unicorn things
////////////////////////////////////////////////////////////////////////////////////////
//Worfel

float flower_timer = 0;

[group lefrow]
void flower() {
  
  if(has_flag("meet_unicorn"))
    flower_timer += get_delta();
  
  if(flower_timer >= 15)
    worfel();
  
}

void worfel() {
  
  say("It likes flowers, yes it does!");
  nl("It wants the flowers!");
  
  load_scene("worfel/intro");
  
}

