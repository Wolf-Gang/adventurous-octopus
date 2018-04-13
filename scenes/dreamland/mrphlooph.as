
#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../backend/shadows.as"

entity unicorn;
entity phlooph;
entity little_phlooph;

[start]
void create_meadow()
{
	// Top
	create_flower_patch(vec(.75, -1), vec(18, 9), 2);
}

[start]
void create_phlooph()
{
	if (has_flag("phloophgate"))
	{
		phlooph = add_entity("mrphlooph", "default:default");
		set_position(phlooph, vec(5, 4.5));
	}
  
  // The little phlooph
  if (has_flag("caughtthephloophs"))
  {
    little_phlooph = add_entity("little phlooph");
    set_position(little_phlooph, vec(2, 6));
    animation::start(little_phlooph);
    
    if (!has_flag("unlockedgate"))
    {
			player::lock(true);
      set_position(player::get(), vec(5, 6));
      set_direction(player::get(), direction::up);
      narrative::show();
      narrative::set_expression("mrphlooph icon", "default:default");
      say("My little friend. Thank you.");
      say("My little phloophs were such a hassle.");
      nl("I'll pay you back by opening the gate.");
      
      narrative::set_expression("mrphlooph icon", "sleepy");
      say("MMMMMMMMMMMM.");
      narrative::set_expression("mrphlooph icon", "default:default");
      nl("BAM!");
      set_flag("unlockedgate");
      nl("It's open now.");
      say("You'll meet druggy by the bridge.");
      nl("Good luck on your friendly little venture.");
      narrative::end();
      player::lock(false);
    }
  }
  else
    group::enable("littlephlooph_talk", false);
}

[group littlephlooph]
void littlephlooph_talk()
{
  narrative::show();
	narrative::set_expression("smol phlooph icon", "default:default");
  say("I was really mean to daddy...");
  nl("Sowwy daddy.");
  narrative::end();
	player::lock(false);
}

[start]
void create_unicorn()
{
  if(!has_flag("bridge_unlocked") && !has_flag("caughtthephloophs")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(7.5, 5));
    if(!has_flag("phloophgate")) {
      group::enable("unicorn", false);
    }
  } else {
    group::enable("unicorn", false);
  }
}

[start]
void start()
{
	music::open("doodle219-Unicorns-Tour");
  
  if (!has_flag("caughtthephloophs") || has_flag("unlockedgate"))
    set_position(player::get(), vec(5, 9));
}

[start]
void create_tree()
{
	entity tree = add_entity("cloud tree", "rustle");
	set_position(tree, vec(5, 4));
	animation::start(tree);
}

[start]
void event_check() {
  if(has_flag("phloophgate")) {
    group::enable("mrphlooph", false);
  }
}

[group mrphlooph]
void mrphlooph()
{
	//once_flag("phloophgate");
	music::fade_volume(40, 1, thread());
	player::lock(true);
	focus::move(vec(5, 4), 1);
	
	narrative::show();
	narrative::set_speaker(unicorn);
	set_atlas(unicorn, "talk_headup");
	say("MR PHLOOOPH!");
	set_atlas(unicorn, "talk");
	
	narrative::hide();
	
	// Create the phlooph of POWER
	phlooph = add_entity("mrphlooph", "justphlooph");
	set_position(phlooph, vec(5, 1));
	set_depth(phlooph, fixed_depth::overlay); // Visible above the tree
	
	music::pause();
	fx::sound("heh");
	move(phlooph, direction::down, 3.5, 1); // Mr phlooph has a fall
	set_depth_fixed(phlooph, false); // Set to normal depth after falling
	fx::sound("heh");
	wait(1);
	
	set_atlas(phlooph, "awakening");
	animation::start(phlooph);
	wait(1);
	set_atlas(phlooph, "talk");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("Haah?");
	music::play();
	say("What did you wake me for? Druggy.");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	say("I am not a Druggy.");
	say("Anyhow, someone new has appeared.");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("Again?!");
	say("I'm guessing this one wants through the bridge as well?");
	
	narrative::set_expression("unicorn icon", "default:default");
	narrative::set_speaker(unicorn);
	say("Of course not!\nHe is not ready.");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	fsay("Hmm...");
	wait(0.2);
	nl("That mask isn't the most intimidating");
	nl("Smiley child, I will call you Smiley.");
	say("I have to measure your strength and worthiness.");
	fsay("It may be harsh");
	narrative::set_expression("mrphlooph icon", "sinister");
	append(" but this is necessary.");
	
	music::pause();
	narrative::set_expression("mrphlooph icon", "sleepy");
	narrative::set_speaker(phlooph);
	say("MMMMMMMMMMMM.");
	narrative::set_expression("mrphlooph icon", "default:default");
	fnl("BAM!");
	
	// Drop a phlooph
	entity phloo = add_entity("little phlooph", "default:default");
	set_position(phloo, get_position(player::get()));
	shadows::add(phloo);
	set_z(phloo, 8);
	move_z(phloo, 0, 6);
	
	fx::sound("heh");
	set_atlas(player::get(), "oof"); // MC kinda fails
	
	wait(0.5);
	move_hop(phloo, get_position(phloo) - vec(1, 0), 0.5, 1);
	wait(0.5);
	move_hop(phloo, get_position(phloo) - vec(6, 0), 3, 2);
	wait(0.2);
	
	//music::play();
	narrative::clear_speakers();
	narrative::set_expression("mrphlooph icon", "default:default");
	say("........");
	
	narrative::set_expression("unicorn icon", "default:default");
	say("........");
	wait(0.3);
	quick_emote(unicorn, emote_type::angry, 1);
	narrative::set_speaker(unicorn);
	say("Oh no!");
	say("I told you he is not ready!");
	
	narrative::set_expression("mrphlooph icon", "default:default");
	narrative::set_speaker(phlooph);
	say("I just wanted to have a little fun.");
	
	set_atlas(phlooph, "default:default");
	animation::start(phlooph);
	
	music::fade_volume(70, 1);
	focus::move(get_position(player::get()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("mrphlooph", false);
  set_flag("phlooph");
}

[group unicornbehere]
void unicornbehere()
{
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("I'll stay here.");
	nl("Go find his little phloophs and come back.");
	narrative::end();
	player::lock(false);
}

