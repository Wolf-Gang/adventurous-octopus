#include "../backend/dreamland_effects.as"

namespace bar
{
entity topbar;
entity bottombar;

void show_bar()
{
  topbar = add_entity("pixel");
  set_color(topbar, 0, 0, 0, 255);
  set_scale(topbar, pixel(get_display_size().x, 50));
  
}

}

[start]
void create_houses() {
  
  entity house1 = add_entity("dreamland", "house");
  set_position(house1, vec(7, 0.5));
  entity house2 = add_entity("dreamland", "house");
  set_position(house2, vec(11, -0.5));
}

entity create_tiki_phlooph(int mask_type)
{
  entity phlooph = add_entity("little phlooph");
  entity mask = add_entity("tiki-masks", "tiki" + formatInt(mask_type));
  add_child(phlooph, mask);
  set_position(mask, vec(-0.15, 0));
  set_z(mask, 0.15);
  animation::start(phlooph);
  animation::set_speed(phlooph, 1 + float(random(-10, 10))/10.f);
  return phlooph;
}

void create_running_person(vec pPosition, float pDistance)
{
  create_thread(function(pArgs)
  {
    const vec pPosition = vec(pArgs["pPosition"]);
    const float pDistance = float(pArgs["pDistance"]);
		
    entity person = add_character("mc");
    set_position(person, pPosition);
    
    do{
      move(person, pPosition - vec(random(1, pDistance), 0), speed(random(3, 5)));
      move(person, pPosition + vec(random(1, pDistance), 0), speed(random(3, 5)));
    }while(true);
  }, dictionary = {{"pPosition", pPosition}, {"pDistance", pDistance}});
}

void phloophsintroduce()
{
	if (has_flag("phloophsintroduce"))
	{
		music::open("doodle169-AFV-Dreamland-Guitar");
		return;
	}
  
  entity firething1 = add_entity("dreamland", "firesign1");
  set_position(firething1, vec(11, 0));
  
  entity phlooph1 = create_tiki_phlooph(1);
  set_position(phlooph1, vec(7, 3));
  
  entity phlooph2 = create_tiki_phlooph(2);
  set_position(phlooph2, vec(8, 3));
  
  entity phlooph3 = create_tiki_phlooph(3);
  set_position(phlooph3, vec(9, 3));
  
	create_running_person(vec(9.4, 3.5), 5);
	create_running_person(vec(10.4, 1.7), 5);
	
  //for (int i = 0; i < 1000; i++)
  //  create_running_person(vec(random(30, 60)/10.0,random(18, 40)/10.0));
  
  set_position(get_player(), vec(-1, 2.8));
	
	say("Hey!");
	narrative::hide();
	
	set_direction(get_player(), direction::right);
	
	entity npc1 = add_character("mc");
	set_position(npc1, vec(5, 3));
	move(npc1, vec(0, 2.8), 2);
	
	say("Run now!\nEverything's on fire!");
	narrative::end();
	
	music::open("doodle180-Phloophs-Beware");
	focus::move(vec(8, 2), 2);
	wait(0.2);
	narrative::show();
	narrative::set_expression("tiki-masks", "tiki2");
	say("Panic, run, and do other things that incite chaos!");
	narrative::set_expression("tiki-masks", "tiki1");
	say("MWAHAHAHA");
	narrative::end();
	focus::move(get_position(get_player()), 2);
  focus::player(true);
  player::lock(false);
}


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