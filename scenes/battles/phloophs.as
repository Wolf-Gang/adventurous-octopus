
#include "battle_util.as"

#include "phlooph_attacks.as"

const vec game_position(-10, -10);

void goto_area()
{
	get_boundary_position(game_position); // TODO: Fix these names in the engine
	get_boundary_size(vec(10, 8));
	set_position(get_player(), (game_position + vec(10, 8)/2) + vec(0, 2));
}

void phlooph_game()
{
	say("WE KNOW DADDY SENT YOU");
	
	entity bg = add_entity("pixel");
	set_position(bg, game_position);
	set_scale(bg, vec(10, 10)*32);
	set_anchor(bg, anchor::topleft);
	set_color(bg, 100, 50, 50, 255);
	set_depth(bg, fixed_depth::background);
	
	entity scary_phlooph = add_entity("little phlooph");
	set_atlas(scary_phlooph, "scary");
	set_position(scary_phlooph, vec(-5, -7));
	shadows::add(scary_phlooph);
	set_z(scary_phlooph, 1);
	float_entity(scary_phlooph, 1, 2, -1);
	
	say("HEHEHEHEHE.");
	say("YOU WILL NEVER BRING US TO DADDY.");
	narrative::end();
	player::lock(false);
	create_thread(function(args)
	{
		entity bg = entity(args["bg"]);
		while(yield())
		{
			wait(1);
			set_color(bg, random(50, 150)
				,  random(50, 150)
				, random(50, 150), 255);
		}
	}, dictionary = {{"bg", bg}});
	
	music::volume(70);
	music::open("doodle109");
	
	phlooph_attack(2);
	say("YOU WILL NEVER GET AWAY.");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(3);
	say("UGH!");
	nl("We'll have to get a little more serious!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(5, 4);
	say("We will never be caught!");
	nl("We don't like daddy!");
	say("AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(10, 7);
	say("AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(20, 7);
	say("AAAAAHHHHH");
	nl("ONCE AGAIN!");
	narrative::end();
	player::lock(false);
	
	phlooph_drop_attack(40, 7);
	
	say("Hmmmmm... Quite persistent you are.");
	nl("...Or are we just tooooo easy for you?");
	say("We see how it is.");
	nl("PREPARE FOR MORE.");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(3);
	phlooph_drop_attack(10, 5);
	
	phlooph_attack(4);
	phlooph_drop_attack(20, 7);
	
	say("Daddy is always saying we would be the next leaders of the dreamland.");
	nl("But we don't want to!");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(4);
	phlooph_attack(3);
	
	phlooph_drop_attack(40, 7);
	phlooph_attack(4);
	phlooph_drop_attack(20, 8);
	
}

