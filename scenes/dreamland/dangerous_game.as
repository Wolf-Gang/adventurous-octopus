#include "../backend/float.as"
#include "../backend/shadows.as"
#include "../backend/save_system.as"
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
		set_position(phloophs[i], vec(0, 1).rotate((360/phloophs.length())*i) + center_of_phloophs);
		animation::start(phloophs[i]);
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
		
		say("We see.");
		nl('<c r="255" g="0" b="0"><shake>PREPARE TO BE ERASED.</shake></c>');
		
		narrative::hide();
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

