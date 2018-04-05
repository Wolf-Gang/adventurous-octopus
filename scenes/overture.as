//#include "backend/user_data.as"

[start]
void start()
{
	music::set_volume(0);
	music::open("doodle110_2-AFV-Overture");
	music::fade_volume(0.7, 5, thread());
	set_visible(player::get(), false);
  pause::lock(true);
	dprint("pie is great yaaa");
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
  
  entity pretty_pictures = add_entity("intro", "a1");
  set_position(pretty_pictures, pixel(0, 30));
  
	narrative::show();
	narrative::set_interval(80);
	
	say("In the world of the unknown, a darkness lingers among the people.");
  
  set_atlas(pretty_pictures, "a2");
	
	say("A darkness that will consume the land and bring chaos. However...");
	
  set_atlas(pretty_pictures, "a3");
  
	say("Once in a great while, a robed figure replenishes the happiness of this world.");
	
  set_atlas(pretty_pictures, "a4");
  
	say("One who sees the sadness of others yet ignores its own.");
  
  set_atlas(pretty_pictures, "a5");
	
	say("One such character will reveal itself and step forward...");
  
  set_atlas(pretty_pictures, "a6");
	
	say("For a new adventure starts here.");
  
  set_atlas(pretty_pictures, "a7");
  
	narrative::end();
  wait(1);
  
  fx::fade_out(1.5);
	
	//fx::scene_fade_out();
	load_scene("mainmenu");
}

