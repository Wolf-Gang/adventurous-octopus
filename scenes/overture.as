//#include "backend/user_data.as"

[start]
void start()
{
	music::volume(0);
	music::open("doodle110_start");
	music::fade_volume(70, 5);
	set_visible(get_player(), false);
}

/* some testing

[start]
void test_values()
{
  once_flag("ahhhh");

  set_slot(99);
  save_game();
  
  values::set("pie/yay", 12);
  values::set("pie/ahhh", "pie");
  set_slot(100);
  save_game();
  
  values::set("pie/ad/yay", 14);
  values::set("pie/ahhhss", "pie");
  set_slot(101);
  save_game();
  
  
  set_slot(101);
  open_game();
  dprint(formatInt(values::get_int("pie/yay")));
  dprint(formatInt(values::get_int("pie/ad/yay")));
  dprint(values::get_string("pie/ahhh"));
  array<string>@ arr = user_data::get_inventory_items();
  for (uint i = 0; i < arr.length(); i++)
  {
    dprint("Inventory: " + arr[i] + " Type: " + formatInt(user_data::get_item_type(arr[i])));
  }
}*/

[start]
void stuff()
{
	wait(2);
	narrative::show();
	narrative::set_interval(100);
	
	say("Broken, lost, and nothing left.");
	
	say("You are just a fading glimpse of your past.");
	
	say("Ugly, soulless, and disgraceful.");
	
	say("Wear this mask and lose yourself.");
	
	say("For your adventure starts here.");
	music::fade_volume(0, 3);
	fx::fade_out(3);
	narrative::end();
	load_scene("mainmenu");
}
