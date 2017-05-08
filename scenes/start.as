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