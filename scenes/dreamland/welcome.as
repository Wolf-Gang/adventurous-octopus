#include "../backend/dreamland_effects.as"
#include "../backend/emote.as"
#include "../characters/unicorn.as"

characters::unicorn unicorn;

[start]
void create_unicorn()
{
	unicorn.create();
  set_position(unicorn, vec(6, 5));
}

entity froggo;

[start]
void create_froggo()
{
  froggo = add_entity("Frog");
  set_position(froggo, vec(24, -12));
}

[group frog1]
void frog1()
{
  narrative::show();
  narrative::set_expression("frog_expression", "default:default");
  say(".....");
  narrative::set_expression("mc_expression", "default:default");
  say(".....");
  narrative::end();
  
  music::pause();
  fx::sound("FX_nom", 0.7);
  set_atlas(froggo, "eat");
  set_visible(player::get(), false);
  animation::play_wait(froggo);
  wait(0.5);
  
  fx::sound("FX_splash", 0.5);
  set_atlas(froggo, "swim_right");
	animation::start(froggo);
  set_position(froggo, vec(25.5, -12));
	
	thread thread_frogmove;
	fx::fade_out(2, thread_frogmove);
  move(froggo, vec(28, -12), 2, thread_frogmove);
	thread_frogmove.wait();
	
	set_flag("frog_travel");
  load_scene("dreamland/residential");
}

[start]
void create_welcome_sign()
{
  entity welcome_sign = add_entity("dreamland", "welcome");
  set_position(welcome_sign, pixel(115,160));
}

[start]
void inconspicuous_bush()
{
  create_bush(vec(10.1, -15), 1);
}

entity hamster_police1;

[start]
void create_hamster()
{
  hamster_police1 = add_entity("Hamster");
  set_position(hamster_police1, vec(2.5, -14.5));
}

[group talktohamster1]
void talktohamster1()
{
  narrative::set_speaker(hamster_police1);
  say("Can't go farther than this, buddy.");
  say("This area is closed off for... \"Maintenance.\"");
  narrative::end();
  player::lock(false);
}

[start]
void create_trees()
{
  create_tree(vec(10, 5.5));
  create_tree(vec(14, -1.5));
  
  create_forest(vec(12, -15.5), vec(4, 3));
  create_forest(vec(4, -15.5), vec(4, 2));
  create_forest(vec(-1, -16.5), vec(1, 3));
  create_tree(vec(1, -15.5));
}


[start]
void create_flowers()
{
  create_flower_patch(vec(1, -6.5), vec(6, 12));
  create_flower_patch(vec(9, -14), vec(4, 8));
  create_flower_patch(vec(11, -13), vec(14, 8));
  create_flower_patch(vec(18, -13), vec(2, 7));
  create_flower_patch(vec(19, -13), vec(2, 5));
}

[start]
void create_buildings()
{
  entity building1 = add_entity("dreamland", "building1");
  set_position(building1, vec(7, -10.5));
}

[start]
void create_eggswing()
{
  entity eggswing = add_entity("dreamland", "eggswing");
  set_position(eggswing, vec(13.5, -1.6));
  set_z(eggswing, 0.5);
}

[group eggswing]
void eggswing_talks()
{
  say("Don't judge me.");
  nl("Eggs can swing, too.");
  say("Just gotta wait for the wind to pick up...");
  narrative::end();
  player::lock(false);
}

[group house_door]
void talk_door()
{
  if(!has_flag("shopisopen"))
  {
    say("door is open. come in?");
    set_flag("shopisopen");
  }
  load_scene("worfel/shop");
}

[group unicorn_talk]
void unicorn_talk()
{
	player::lock(true);
	
	wait(0.5);
	
	narrative::show();
  
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	
	say("Welcome");
	
	say("This is the magical dreamland of, well, I don't know...");
	set_atlas(unicorn, "talk_headup");
	nl("<wave>DREAMS?</wave>");
	set_atlas(unicorn, "talk");
	
	say("But, perhaps that's too mythical.");
	
	narrative::end();
	unicorn.disappear();
	player::lock(false);
	
	group::enable("unicorn_talk", false);
}

[group unicorn_talk2]
void unicorn_talk2()
{
	player::lock(true);
	
	unicorn.appear(vec(23, -11));
	
	wait(0.5);
	
	narrative::show();
  
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	
	say("Say hello to frog. He can take you anywhere.");
	say("By \"anywhere\", I mean <c r='1' g='0' b='0'><b>anywhere</b></c>.");
	say("But you only need to get across this waterfall.");
	
	narrative::end();
	unicorn.disappear();
	player::lock(false);
	
	group::enable("unicorn_talk2", false);
}

[start]
void start()
{
	music::set_volume(1);
  music::open("doodle169-AFV-Dreamland-Guitar");
	if (has_flag("frog_travel"))
	{
		set_position(player::get(), vec(24, -11));
		unset_flag("frog_travel");
	}
	else if(!has_came_through_door())
		set_position(player::get(), vec(6, 7.5));
}
