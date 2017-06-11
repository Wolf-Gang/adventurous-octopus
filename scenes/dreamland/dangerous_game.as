#include "../backend/float.as"
#include "../backend/shadows.as"
#include "../backend/quicksave.as"
#include "../backend/dreamland_effects.as"

#include "../battles/phloophs.as"

[start]
void start()
{
	music::open("doodle58");
	music::volume(100);
	set_position(get_player(), vec(17.5, 6.5));
}


[start]
void running_phlooph()
{
  once_flag("phloophran");
	scoped_entity phlooph = add_entity("little phlooph");
	set_position(phlooph, vec(16.5, 6.5));
	move(phlooph, direction::left, 14, 2);
}

vec center_of_phloophs(7, 3);
array<entity> phloophs(5);

[start]
void create_flower()
{
	entity flower = add_entity("dreamland", "redflower");
	set_position(flower, center_of_phloophs);
	animation::start(flower);
}

[start]
void create_phloophs()
{
	for (uint i = 0; i < phloophs.length(); i++)
	{
		phloophs[i] = add_entity("little phlooph");
		set_position(phloophs[i], vec(0, 1).rotate((360*i/phloophs.length())) + center_of_phloophs);
		animation::start(phloophs[i]);
    //create collision boxes to talk to them after the battle
	}
	if(has_flag("caughtthephloophs"))
  {
    remove_entity(phloophs[0]);
    group::enable("phloophs", false);
    group::enable("quicksave", false);
  }
  else
  {
    group::enable("postphloophs", false);
    group::enable("goback", false);
  }
}

[group phloophs]
void phloophs_talk()
{
	say("Hello.");
	nl("This is our majestic hideout.");
	fsay("Have you come to catch us?");
	if (select("Yes", "No") == option::first)
	{
		narrative::hide();
		music::stop();
		for (uint i = 0; i < phloophs.length(); i++)
			set_atlas(phloophs[i],"scary");
		fx::sound("heh");
		wait(0.5);
		
    narrative::set_dialog_sound("roughdialog");
		say('<c r="255" g="0" b="0">We see.</c>');
		nl('<c r="255" g="0" b="0"><shake>PREPARE TO BE ERASED.</shake></c>');
		narrative::end();
    
		fx::sound("bad");
		goto_area();
		
		remove_dreamland_effects();
		
		wait(1);
		phlooph_game();

    
	}else{
		say("I hope we will be the bestest of friends.");
		narrative::end();
		move(get_player(), direction::down, 0.5, 0.5);
		player::lock(false);
	}
}

[group postphloophs]
void post()
{
  narrative::show();
  narrative::set_expression("smol phlooph icon", "default:default");
  say("We hope we can be better friends next time.");
  narrative::end();
  player::lock(false);
}

[group goback]
void back()
{
  fsay("Leave the hideout?");
  if(select("Yes", "No") == option::first)
    load_scene("dreamland/hall");
  narrative::end();
  player::lock(false);
}

