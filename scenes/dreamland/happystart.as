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
	set_position(get_player(), vec(3.5, 4));
  set_atlas(get_player(), "oof");
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
  
  music::volume(1);
  music::open("doodle132-dreamland-start_2");
  fx::fade_out(blackout, 5);
  set_direction(get_player(), direction::up);
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
  say("Anyway, where do you live? Are you new?");
  
  narrative::clear_speakers();
	narrative::set_expression("mc_expression", "default:default");
  say("...");
  
  narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
  say("Hello?");
  
  narrative::clear_speakers();
	narrative::set_expression("mc_expression", "default:default");
  say("...");
  
  narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
  say("Rather quiet, aren't you?");
  say("How about you come with me to sort things out?");
  narrative::hide();
  
  music::stop();
  
  fx::sound("rumble");
  set_boundary_enable(false);
  fx::shake(0.5, 2);
  quick_emote(unicorn, emote_type::surprise, 1);
  
  wait(0.5);
  say("Hmmm...");
  nl("Some trouble has happened, again...");
  say("I will have to go. Don't get lost and die.");
  narrative::end();
  
  music::open("doodle132-dreamland-start_2");
  unicorn.disappear();
  player::lock(false);
  
}
