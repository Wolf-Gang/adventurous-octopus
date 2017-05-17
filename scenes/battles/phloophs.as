
#include "battle_util.as"

#include "phlooph_attacks.as"

const vec game_position(-10, -10);

namespace priv
{
  vec last_boundery_position;
  vec last_boundary_size;
}

void return_boundary()
{
  get_boundary_position(priv::last_boundery_position);
  get_boundary_size(priv::last_boundary_size);
}

void goto_area()
{
  priv::last_boundery_position = get_boundary_position();
  priv::last_boundary_size = get_boundary_size();
	get_boundary_position(game_position); // TODO: Fix these names in the engine
	get_boundary_size(vec(10, 8));
	set_position(get_player(), (game_position + vec(10, 8)/2));
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

class little_bros
{
	array<entity> mLittle_bros(6);
	
	~little_bros()
	{
		for(uint i = 0; i < mLittle_bros.length(); i++)
		{
			remove_entity(mLittle_bros[i]);
		}
	}
	
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
			::set_atlas(bro, "scary");
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
	
	void set_atlas(string pName)
	{
		for(uint i = 0; i < mLittle_bros.length(); i++)
		{
			::set_atlas(mLittle_bros[i], pName);
		}
	}
}

entity create_backgound()
{
  entity e = add_entity("pixel");
	set_position(e, game_position);
	set_scale(e, vec(10, 10)*32);
	set_anchor(e, anchor::topleft);
	set_depth(e, fixed_depth::background);
  return e;
}

void phlooph_game()
{
	
	say("WE KNOW DADDY SENT YOU");
  
  scoped_entity bg = create_backgound();
	set_color(bg, 100, 50, 50, 255);
	
	scoped_entity scary_phlooph = add_entity("little phlooph");
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
		while(yield() && bg.is_valid())
		{
			wait(1);
			set_color(bg, random(50, 150)
				,  random(50, 150)
				, random(50, 150), 255);
		}
	}, dictionary = {{"bg", bg.get()}});
	
	
	/*phlooph_attack(2);
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
	fsay("Daddy is always saying we would be the next leaders of the dreamland.");
	bros.talk("Its terrible", 2);
	bros.talk("I want mommy", 3);
	bros.talk("gimmi", 5);
	keywait();
	
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
	
	phlooph_drop_attack(70, 10);*/
	
	bros.show();
	
	say("I've always wanted to be a technician.");
	narrative::hide();
	wait(0.1);
	bros.talk("Body builder", 0);
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
	wait(1);
	
	say("We've never wanted to be successors to a boring job.");
	nl("Where we will never achieve anything.");
	nl("We will never let you take us back to it.");
	
	fsay("NEVER!");
	bros.all_talk("NEVER!");
	keywait();
	narrative::end();
	
	narrative::show();
	narrative::set_expression("question_expr", "default:default");
	say("Ah. I see now.");
	narrative::hide();
	
	scoped_entity phlooph = add_entity("mrphlooph", "justphlooph");
	set_position(phlooph, vec(-5, -6));
	set_z(phlooph, 4);
	shadows::add(phlooph, shadows::shadow_size::big);
	
	music::fade_volume(30, 2);
	set_atlas(scary_phlooph, "surprised");
	bros.set_atlas("surprise");
	move_z(phlooph, 0, 1);
	fx::sound("heh");
	music::stop();
	shadows::remove(phlooph);
	
  bg = create_backgound();
	set_color(bg, 100, 100, 50, 255);
  
	wait(0.5);
	set_atlas(phlooph, "awakening");
	animation::start(phlooph);
	wait(1);
	set_atlas(phlooph, "talk");
	
	narrative::set_speaker(phlooph);
	narrative::set_expression("mrphlooph icon", "sinister");
	say("Found ya.");
  nl("I can hear you a mile away.");
	narrative::hide();
	
	bros.all_talk("*Silence*");
	wait(2);
	narrative::set_expression("mrphlooph icon", "default:default");
  say("So none of you want to be my successor.");
	narrative::hide();
  
  bros.all_talk("*Silence*");
	wait(2);
  
  narrative::set_expression("mrphlooph icon", "sleepy");
  say("...");
  
  music::volume(0);
  music::open("doodle111");
  music::fade_volume(70, 6);
  
  
  nl("I see.");
  nl("No wonder why you all avoid me.");
  nl("");
	narrative::hide();
}

