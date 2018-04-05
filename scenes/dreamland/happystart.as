#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"

characters::unicorn unicorn;

[start]
void create_cloud_trees()
{
	create_tree(vec(1, 1));
  create_tree(vec(6, 1));
}

[start]
void create_flowers()
{
	create_flower_patch(vec(0, 1.5), vec(4, 8), 2);
	create_flower_patch(vec(5.5, 1.5), vec(4, 8), 2, flower_type::orange);
}

[start]
void create_unicorn()
{
  unicorn.create();
  set_position(unicorn, vec(3.5, 2));
}

[start]
void start()
{
	set_position(player::get(), vec(3.5, 4));
  set_atlas(player::get(), "oof");
}

[start]
void things()
{
  entity blackout = add_entity("pixel");
  make_gui(blackout, 1);
  set_scale(blackout, get_display_size());
  set_color(blackout, 255, 255, 255, 255);
  set_anchor(blackout, anchor::topleft);
  
  wait(1);
  say("Hello?");
  nl("You awake?");
  narrative::hide();
  
  music::set_volume(1);
  music::open("doodle132-dreamland-start_2");
	wait(1);
  fx::fade_out(blackout, 5);
  set_direction(player::get(), direction::up);
  wait(0.5);
  quick_emote(unicorn, emote_type::surprise, 1);
  
  narrative::show();
  
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
  
  say("AH Hello there!");
	say("I'm the majestic unicorn of <b>DEATH</b>.");
	nl("A fighter against world hunger.");
  say("I found you lying peacefully in these flowers.");
  say("You must <b>REALLY</b> like flowers.");
  say("Don't worry...");
  say("Your secret is safe with me.");
  
  narrative::clear_speakers();
	narrative::set_expression("mc_expression", "default:default");
  say("...");
  
  narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
  fsay("Anyway, where do you live? Are you new?");
  
	if (select("Yes", "...") == option::first)
	{
		say("I love newcomers!");
		say("Meet me on the other side of this tunnel.");
		nl("I will show you around.");
	}
	else
  {
		narrative::set_speaker(unicorn);
		narrative::set_expression("unicorn icon", "default:default");
		say("Rather quiet, aren't you?");
		say("Your speech must be beyond normal comprehension.");
		say("How bout' I talk to you on a spiritual level!");
		
		narrative::clear_speakers();
		say("*Stares deeply*\n.......\n.......");
		
		narrative::set_speaker(unicorn);
		narrative::set_expression("unicorn icon", "default:default");
		say("I see... come with me though this tunnel.");
		say("We can sort things out then.");
	}
	
  narrative::end();
  
  unicorn.disappear();
  player::lock(false);
  
}
