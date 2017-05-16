
#include "battle_util.as"

#include "phlooph_attacks.as"

const vec game_position(-10, -10);

void goto_area()
{
	get_boundary_position(game_position); // TODO: Fix these names in the engine
	get_boundary_size(vec(10, 8));
	set_position(get_player(), (game_position + vec(10, 8)/2) + vec(0, 2));
}

void quick_text(vec pPosition, string pText)
{
	create_thread(function(args)
	{
		vec pPosition = vec(args["pPosition"]);
		string pText = string(args["pText"]);
		
		scoped_entity text = add_text();
		set_text(text, pText);
		set_color(text, 255, 255, 255, 255);
		set_position(text, pPosition);
		set_anchor(text, anchor::center);
		
		fx::fade_in(text, 0.5);
		wait(0.5);
		fx::fade_out(text, 0.5);
		
	}, dictionary = {{"pPosition", pPosition}, {"pText", pText}});
}

void random_quick_text(string pText)
{
	quick_text(game_position + vec(float(random(1, 4)*2), float(random(1, 4)*2)), pText);
}

class little_bros
{
	array<entity> mLittle_bros(6);
	
	void talk(string pText, uint pIndex)
	{
		quick_text(get_position(mLittle_bros[pIndex]) + vec(pIndex%2 == 0 ? 1 : -1, 0), pText);
	}
	
	void all_talk(string pText)
	{
		for (uint i = 0; i < mLittle_bros.length(); i++)
			talk(pText, i);
	}
	
	void show()
	{
		for (uint i = 0; i < mLittle_bros.length(); i++)
		{
			entity bro = add_entity("little phlooph");
			set_atlas(bro, "scary");
			if (i%2 == 0)
				set_position(bro, game_position + vec(1, i + 1));
			else
				set_position(bro, game_position + vec(9, i));
			mLittle_bros[i] = bro;
		}
	}
	
	void hide()
	{
		for(uint i = 0; i < mLittle_bros.length(); i++)
		{
			light_sparkles(get_position(mLittle_bros[i]));
			remove_entity(mLittle_bros[i]);
		}
	}
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
	
	little_bros bros;
	bros.show();
	say("HEHEHEHEHE.");
	say("YOU WILL NEVER BRING US TO DADDY.");
	bros.talk("You jerk!", 0);
	bros.talk("AHHHH", 3);
	bros.talk("Gimmi turtles", 5);
	say("Little bros.\nSQUISH IT!");
	narrative::end();
	
	
	music::volume(70);
	music::open("doodle109");
	bros.all_talk("HAHAHAHA");
	wait(1);
	bros.hide();
	wait(0.5);
	player::lock(false);
	
	// Randomize background color
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
	
	phlooph_attack(3, true);
	phlooph_drop_attack(10, 5);
	
	phlooph_attack(4, true);
	phlooph_drop_attack(20, 7);
	phlooph_drop_attack(20, 8);
	phlooph_attack(5, true);
	phlooph_attack(5, true);
	
	bros.show();
	say("Daddy is always saying we would be the next leaders of the dreamland.");
	bros.talk("Its terrible", 2);
	bros.talk("I want mommy", 3);
	bros.talk("gimmi", 5);
	
	fnl("But we don't want to!");
	bros.all_talk("YAH");
	keywait();
	
	fnl("We want to be something else!");
	bros.all_talk("YAAAASS");
	keywait();
	
	wait(1);
	bros.hide();
	wait(0.5);
	
	narrative::end();
	player::lock(false);
	
	phlooph_attack(5, true);
	phlooph_attack(6, true);
	phlooph_attack(7, true);
	
	phlooph_drop_attack(40, 7);
	phlooph_drop_attack(60, 8);
	
	
	say("Lets see how much you can handle.");
	nl("Try this!");
	narrative::end();
	player::lock(false);
	
	phlooph_attack(6, true);
	phlooph_attack(7, true);
	phlooph_attack(8, true);
	phlooph_drop_attack(60, 8);
	phlooph_attack(9, true);
	phlooph_attack(10, true);
	
	phlooph_drop_attack(70, 10);
	
	bros.show();
	say("I've always wanted to be a technician.");
	wait(0.1);
	bros.talk("Pyromaniac", 1);
	wait(0.1);
	bros.talk("Butcher", 2);
	wait(0.1);
	bros.talk("Secret agent", 3);
	wait(0.1);
	bros.talk("Astronaut", 4);
	wait(0.1);
	bros.talk("a turtle", 5);
	keywait();
	nl("");
}

