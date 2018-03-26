#include "../backend/dreamland_effects.as"
#include "../backend/user_data.as"
#include "../characters/unicorn.as"

entity smol_phlooph;

characters::unicorn unicorn;

[start]
void start()
{
	music::set_volume(1);
	music::open("doodle104_2");
	set_position(get_player(), vec(5, 3));
}

[start]
void create_unicorn()
{
	unicorn.create();
	if (!has_flag("uncorn_hmmmmlocked"))
	{
		set_position(unicorn, vec(7.5,-.5));
		return;
	}
	if(!has_flag("bridge_unicorn") && has_flag("unlockedgate"))
	{
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
		group::enable("thisisagate", false);
	}
  else
  {
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
}

[group thisisagate]
void thisisagate()
{
	player::lock(true);
	narrative::show();
  
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	
	say("That bridge is dangerous. You might fall off and...");
	wait(0.2);
	say("I don't want to talk about it.");
	say("Go this way. You have to meet someone.");
	
	narrative::end();
	player::lock(false);
	
	group::enable("unicorn_talk", false);
}


// Keeping all this for now.
/*

[group phloophgift]
void takethis()
{
  if(user_data::has_gift("Cloud"))
    return;
  
  say("Wait a sec!");
  narrative::hide();
  
  set_direction(get_player(), direction::up);
  
  entity littleguy = add_entity("little phlooph");
  set_position(littleguy, vec(5.5, -5));
  animation::start(littleguy);
  move(littleguy, direction::down, 2.5, .5);
  
	narrative::set_expression("smol phlooph icon", "default:default");
  say("Here, uh, have this.");
  nl("For helping us out.");
  
  narrative::clear_expression();
  const string description = "It's you, but in cloud form.";
  user_data::add_gift("Cloud", description, "gifts", "phlooph");
  
  say(description);
  
  narrative::set_expression("smol phlooph icon", "default:default");
  say("Hope you like it.");
  narrative::hide();
  
  move(littleguy, direction::up, 2.5, .5);
  
  group::enable("phloophgift", false);
  narrative::end();
  player::lock(false);
}

[group hmmmmlocked]
void hmmmmlocked()
{
	once_flag("uncorn_hmmmmlocked");
	music::fade_volume(40, 1);
	player::lock(true);
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("This is the bridge of y.. Hmmmm...");
	say("It seems to be locked.");
	
	set_atlas(unicorn, "talk_headup");
	say("Welp.");
	set_atlas(unicorn, "talk");
	nl("I guess we'll need to ask Mr Phlooph.");
  nl("He is the great leader of Dreamland.");
	say("Come.");
	narrative::end();
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
}

[group talktounicorn]
void talktounicorn()
{
	once_flag("asdfasdffa");
	music::fade_volume(40, 1);
	player::lock(true);
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("Ok, let's try this again.");
	say("This is the bridge of your hopes and dreams.");
	say("I have some place to be at the moment so I won't see you for a while.");
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
  say("The unicorn's sultry tones  echo through your head.");
  say("\"Don't get lost and die\"");
  move(get_player(), get_position(get_player()) + vec(0, .25), .1);
  narrative::end();
  player::lock(false);
}

[group dont2]
void no2() {
  say("The unicorn's sultry tones  echo through your head.");
  say("\"Don't get lost and die\"");
  move(get_player(), get_position(get_player()) + vec(0, -.25), .1);
  narrative::end();
  player::lock(false);
}

[group crushingyourhopesanddreams]
void crushingyourhopesanddreams()
{
	// Need to disable this because it pops up the narrative
  //lol
	//group::enable("dont2", false);
	
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
		set_z(get_player(), -timer); // Move player down
		set_rotation(get_player(), 90*(timer/4)); // Rotate clockwise
	} while(timer <= 4 && yield());
	
	group::enable("crushingyourhopesanddreams", false);
  
  load_scene("lost/fallen");
  
}*/

