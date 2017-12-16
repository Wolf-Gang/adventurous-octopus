[start]
void start()
{
	music::open("doodle169-AFV-Dreamland-Guitar");
	//if (has_flag("frog_travel"))
	{
		set_position(get_player(), vec(-1, 2.8));
		unset_flag("frog_travel");
	}
}

entity froggo;

[start]
void create_froggo()
{
  froggo = add_entity("Frog");
  set_position(froggo, vec(-1, 2));
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
  set_visible(get_player(), false);
  animation::play_wait(froggo);
  wait(0.5);
  
  fx::sound("FX_splash", 0.5);
  set_atlas(froggo, "swim_left");
	animation::start(froggo);
  set_position(froggo, vec(-2.5, 2));
	fx::fade_out(2, thread());
  move(froggo, vec(-5, 2), 2);
	set_flag("frog_travel");
  load_scene("dreamland/welcome");
}