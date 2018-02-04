
entity create_tiki_phlooph(int mask_type)
{
  entity phlooph = add_entity("little phlooph");
  entity mask = add_entity("tiki-masks", "tiki" + formatInt(mask_type));
  add_child(phlooph, mask);
  set_position(mask, vec(-0.15, 0));
  set_z(mask, 0.15);
  animation::start(mask);
  return phlooph;
}

void create_running_person(vec pPosition)
{
  
  create_thread(function(pArgs)
  {
    const vec pPosition = vec(pArgs["pPosition"]);
    
    entity person = add_character("mc");
    set_position(person, pPosition);
    
    do{
      move(person, pPosition - vec(random(1, 10), 0), speed(random(1, 10)));
      move(person, pPosition + vec(random(1, 10), 0), speed(random(1, 10)));
      if (random(0, 1) == 0)
        move(person, direction::up, random(-10, 10)/10.0, speed(random(1, 10)));
    }while(true);
    
    
  }, dictionary = {{"pPosition", pPosition}});
}

[start]
void phloophsintroduce()
{
	if (has_flag("phloophsintroduce"))
	{
		music::open("doodle169-AFV-Dreamland-Guitar");
		return;
	}
  
  entity firething1 = add_entity("dreamland", "firesign1");
  set_position(firething1, vec(5, 2));
  
  entity phlooph1 = create_tiki_phlooph(1);
  set_position(phlooph1, vec(5, 3));
  
  entity phlooph2 = create_tiki_phlooph(2);
  set_position(phlooph2, vec(6, 3));
  
  entity phlooph3 = create_tiki_phlooph(3);
  set_position(phlooph3, vec(7, 3));
  
  for (int i = 0; i < 100; i++)
    create_running_person(vec(random(30, 60)/10.0,random(18, 40)/10.0));
  
  
  set_position(get_player(), vec(-1, 2.8));
	music::open("doodle180-Phloophs-Beware");
	//focus::move(vec(6, 2), 2);
}


[start]
void start()
{
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