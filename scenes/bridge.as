#include "backend/dreamland_effects.as"

entity unicorn;

[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(3, 0));
}

[start]
void create_unicorn()
{
  if(!has_flag("bridge_unicorn")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(11,1));
  } else {
    group::enable("talktounicorn", false);
  }
}


[group talktounicorn]
void talktounicorn()
{	
	music::fade_volume(40, 1);
	player::lock(true);
	//focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("Hello again.");
	say("This is the bridge of your\nhopes and dreams.");
	say("I have some place to be at the\nmoment so I won\'t see you for\na while.");
	say("Don't get lost and die.");
	narrative::end();
	
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	
  set_flag("bridge_unicorn");
	group::enable("talktounicorn", false);
}

[group dont1]
void no1() {
  say("The unicorn's sultry tones\n echo through your head.");
  say("\"Don't get lost and die\"");
  move(get_player(), get_position(get_player()) + vec(0, .25), .1);
  narrative::end();
  player::lock(false);
}

[group dont2]
void no2() {
  say("The unicorn's sultry tones\n echo through your head.");
  say("\"Don't get lost and die\"");
  move(get_player(), get_position(get_player()) + vec(0, -.25), .1);
  narrative::end();
  player::lock(false);
}

