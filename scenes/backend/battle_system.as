#include "../../internal/gui.as"
#include "user_data.as"


/// This is entirely experimental and very messy.

// This is the event system for one enemy
interface enemy
{
	void create();
	void destroy();
	
	void start();
	void end();
	
	void attack();
	void attacked();
	
	void check();
	
	bool is_finished();
	
	string get_name();
};

void narrative_character_talk()
{
	set_color(_get_narrative_text(), 255, 255, 0);
}

class guy_enemy : enemy
{
	private void do_idle()
	{
		set_animation(mGuy, "idle");
		start_animation(mGuy);
	}
	
	private void do_talk()
	{
		stop_animation(mGuy);
		set_animation(mGuy, "talk");
		narrative_character_talk();
	}
	
	string get_name()
	{
		return "Billy";
	}
	
	void create()
	{
		mState = 0;
		mHP = 10;
		mGuy = add_entity("someguy_battle");
		do_idle();
		make_gui(mGuy, 1);
		set_position(mGuy, pixel(160, 64));
	}
	
	void destroy()
	{
		remove_entity(mGuy);
	}
	
	void start()
	{
		say(">> A Billy Approaches! <<");
		
		narrative::set_speaker(mGuy);
		
		do_talk();
		
		say("It has been too long.\nBilly challenges you!");
		
		narrative::end();
		do_idle();
	}
	
	void end()
	{
		do_talk();
		narrative::set_speaker(mGuy);
		fx::sound("bad");
		say("IT HAS CHOSEN BILLY!");
		say("BILLY HAS BEEN CHOSEN!");
		say("BILLY HAS CONCEDED!");
		narrative::end();
		do_idle();
	}
	
	void attack()
	{
		player_data@ player = get_player_data();
		player.set_hp(player.get_hp() - 2);
		
		
		do_talk();
		narrative::set_speaker(mGuy);
		say("Have this!");
		narrative::end();
		
		fx::sound("heh");
		
		set_animation(mGuy, "dance");// Play dis guys attack animation
		start_animation(mGuy);
		say("Billy attacks you with damage!");
		stop_animation(mGuy);
		
		set_animation(mGuy, "talk");
		narrative::end();
		
		do_talk();
		narrative::set_speaker(mGuy);
		switch(mState)
		{
		case 0:
			say("YES! YES! YES!");
			break;
		case 1:
			say("You has tough, Arn'tcha?");
			break;
		}
		narrative::end();
		++mState;
		do_idle();
	}
	
	void check()
	{
		say("With one and only Billy.\nHP: " + formatInt(mHP));
		narrative::end();
	}
	
	void attacked()
	{
		player_data@ player = get_player_data();
		
		mHP -= player.get_dp();
		fx::sound("heh");
		
		say("You attack!");
		
		
		if (mHP < 5)
		{
			say("Billy is showing weakness!");
		}
		

		
		narrative::end();
	}
	
	bool is_finished()
	{
		return mHP <= 0;
	}
	
	private int mState;
	private entity mGuy;
	private int mHP;
};

class battle_system
{
	void add_enemy(enemy@ pEnemy) {
    mEnemies.insertLast(pEnemy);
  }

	void start()
	{
		player_data@ player = get_player_data();
		
		player::lock(true);
		
		fx::sound("transition"); //Temp: use different better sound;
		fade_out(1.4);
		
		
		scoped_entity bg = create_background();
		
		if (mMusic.length() != 0)
		{
			music::open(mMusic);
			music::volume(80);
		}
		
		// Some text displaying the name
		scoped_entity txt = add_text();
		set_text(txt, mEnemy.get_name());
		set_anchor(txt, anchor::top);
		make_gui(txt, 1);
		set_position(txt, pixel(160, 110));
		
		mEnemy.create();
		
		fade_in(1);
		
		mEnemy.start();
		
		// HP text entity
		scoped_entity tx_hp = add_text();
		set_anchor(tx_hp, anchor::topleft);
		make_gui(tx_hp, 1);
		set_position(tx_hp, pixel(40, 145));
		
		array<inventory_item@>@ player_inventory =  player.get_inventory();
		
		// Position for all selectors
		const vec selector_position(pixel(50, 173));
		
		gui::menu_function_t@ inventory_eat =
			function(pArgs)
			{
				player_data@ player = get_player_data();
				uint item = uint(pArgs["item"]); // get argument "item" as a string
				auto@ item_ref = player.get_inventory()[item];
				
				
				say("You consumed '" + item_ref.get_name() +"'");
				
				// Consume food, you get hp
				if (item_ref.get_type() == item_type::food)
				{
					player.set_hp(player.get_hp() + item_ref.get_value());
					say("+" + formatInt(item_ref.get_value()) + " HP");
				}
				
				// Consume weapon, you get dp
				else if (item_ref.get_type() == item_type::weapon)
				{
					player.set_dp(item_ref.get_value() + player.get_dp());
					say("+" + formatInt(item_ref.get_value()) + " DP");
				}
				narrative::end();
				player.remove_item(item);
			};
		
		while (true)
		{
			set_text(tx_hp, "HP: " + formatInt(player.get_hp()) + "/" + formatInt(player.get_hp_max()));
			
			// Turn HP text yellow when less then half health.
			if (player.get_hp() < player.get_hp_max()/2)
			{
				set_color(tx_hp, 255, 255, 0);
			}
			
			gui::selection_menu sel_action;
			sel_action.set_position(selector_position);
			
			// Attack action
			gui::menu_function attack_action("Attack"
				, function(pArgs)
				{
					enemy@ e = cast<enemy>(pArgs["enemy"]);
					e.attacked();
				}, dictionary = {{ "enemy", mEnemy}});
			
			sel_action.add(attack_action);
			
			// Check action
			sel_action.add(gui::menu_function("Check"
				, function(pArgs)
				{
					cast<enemy>(pArgs["enemy"]).check();
				}, dictionary = {{ "enemy", mEnemy}}));
			
			// Inventory
			gui::selection_menu sel_inventory("Inventory");
			sel_inventory.set_position(selector_position);
			sel_action.add(sel_inventory);
			
			if (player_inventory.length() == 0)
				sel_inventory.add(gui::empty_menu_item(">> Empty <<"));
			else
			{
				for (uint i = 0;  i < player_inventory.length(); i++)
				{
					string display_name = player_inventory[i].get_name();
					if (player_inventory[i].get_count() > 1)
						display_name += " (" + formatInt(player_inventory[i].get_count()) + ")"; // Add a number to specify amount of item
					
					// Create a menu for each item in the inventory
					gui::selection_menu sel_inventory_item(display_name);
					sel_inventory_item.set_position(selector_position);
					sel_inventory_item.add(
						gui::menu_function("Eat"
						, inventory_eat
						, dictionary = {{"item", i}}));
					sel_inventory.add(sel_inventory_item);
				}
			}
			
			sel_action.open(); // Start
			
			/*if (player.get_hp() <= 0)
			{
				fade_out(2);
				
			}*/
			
			if (mEnemy.is_finished())
			{
				break;
			}
			
			// Enemy attacks after you attack
			// This is down here so that the loop can end when you finished him off
			// before he attacks again (obviously he cant when ded so it down here)
			if (attack_action.is_selected())
				mEnemy.attack();
		}
		music::stop();
		mEnemy.end();
		
		// Do a cool effect and sound when the foe dies
		fx::sound("ding");
		scoped_entity light_effect = add_entity("light", "light_disperse");
		make_gui(light_effect, 1);
		set_position(light_effect, pixel(160, 64));
		start_animation(light_effect);
		mEnemy.destroy();
		wait(2);
		
		
		player::lock(false);
	}
	
	private entity create_background()
	{
		entity bg = add_entity("BSBG");
		set_anchor(bg, anchor::topleft);
		make_gui(bg, 0);
		set_position(bg, pixel(0, 0));
		return bg;
	}
	
	void set_music(const string&in pName)
	{
		mMusic = pName;
	}
	
	private string mMusic;
	private array<enemy@> mEnemies;
};

void start_test_battle_system()
{
	battle_system sattle_bystem;
	sattle_bystem.start();
}