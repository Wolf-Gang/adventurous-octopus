#include "backend/dreamland_effects.as"

entity unicorn;

[start]
void create_unicorn()
{
	if (!has_flag("uncorn_hmmmmlocked"))
	{
		unicorn = add_entity("unicorn", "talk");
		set_position(unicorn, vec(5.5,0));
		return;
	}
	if(!has_flag("bridge_unicorn") && has_flag("unlockedgate"))
	{
		unicorn = add_entity("unicorn", "talk");
		set_position(unicorn, vec(11,1));
	}
	else
	{
		group::enable("talktounicorn", false);
	}
}

[start]
void create_gate()
{
	// Unlock
	if (has_flag("unlockedgate"))
	{
		group::enable("gate", false);
		return;
	}
	
	// Lock it up
	for (uint i = 0; i < 8; i++)
	{
		entity gate = add_entity("dreamland", "bars");
		set_anchor(gate, anchor::topleft);
		set_position(gate, vec(9, -3 + float(i)));
		if (i == 3)
			set_atlas(gate, "lock");
	}
}

[group hmmmmlocked]
void hmmmmlocked()
{
	once_flag("uncorn_hmmmmlocked");
	music::fade_volume(40, 1);
	player::lock(true);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("This is the bridge of y..\nHmmmm...");
	say("It seems to be locked.");
	
	set_atlas(unicorn, "talk_headup");
	say("Welp");
	set_atlas(unicorn, "talk");
	nl("I guess we'll need\nto ask Mr Phlooph");
	say("Come.");
	narrative::end();
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
}

[group crushingyourhopesanddreams]
void crushingyourhopesanddreams()
{
	// Need to disable this because it pops up the narrative
  //lol
	group::enable("dont2", false);
	
	player::lock(true);
	
	entity lightning = add_entity("lightning");
	set_position(lightning, vec(26, 1.5));
	music::stop();
	fx::sound("rumble");
	wait(0.1);
	remove_entity(lightning);
	wait(0.5);
	
	set_direction(get_player(), direction::left);
	
	// The cracks
	for (uint i = 0; i < 4; i++)
	{
		entity crack = add_entity("cracks");
		set_position(crack, vec(25 + 2*i, 2));
		set_depth(crack, fixed_depth::below);
		fx::sound("boom");
		animation::play_wait(crack);
	}
	
	remove_dreamland_effects();
	
	fx::sound("heh");
	
	// Overlay the tilemap with a black gackbround
	entity overlay = add_entity("pixel");
	make_gui(overlay, 0);
	set_anchor(overlay, anchor::topleft);
	set_depth(overlay, fixed_depth::below);
	set_scale(overlay, vec(1000, 1000));
	set_color(overlay, 0, 0, 0, 255);
	
	
	// Add the broken bridge animations
	for (uint i = 0; i < 12; i++)
	{
		entity breaking_bridge = add_entity("dreamland", "breakingbridge");
		set_position(breaking_bridge, vec(24 + i, 2));
		set_depth(breaking_bridge, 100);
		animation::start(breaking_bridge);
	}
	fx::sound("wind1");
	
	// Fade out slowly
	create_thread(function(args){fx::fade_out(3);});
	
	float timer = 0;
	do
	{
		const float delta = get_delta();
		timer += delta;
		set_position(get_player(), get_position(get_player()) + vec(0, 1)*delta); // Move player down
		set_rotation(get_player(), 90*(timer/4)); // Rotate clockwise
	} while(timer <= 4 && yield());
	
	group::enable("crushingyourhopesanddreams", false);
}

[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(5, 3));
}

[group talktounicorn]
void talktounicorn()
{
	once_flag("asdfasdffa");
	music::fade_volume(40, 1);
	player::lock(true);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("Ok, let's try this again.");
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

