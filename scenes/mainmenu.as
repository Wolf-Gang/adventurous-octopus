
#include "backend/save_system.as"

[start]
void start()
{
	music::open("doodle110_theme");
	music::set_volume(0.7);
	set_visible(get_player(), false);
	focus::set(vec(0, 0));
  pause::lock(true);
}

void cloud_movement(entity pCloud, float pSpeed, float pMin_y, float pMax_y)
{
	do {
		set_position(pCloud, vec(-9, random(int(pMin_y*10), int(pMax_y*10)) / 10));
		move(pCloud, direction::right, 17, speed(pSpeed));
		wait(random(9300, 15000) / 10000);
	} while(yield());
}

[start]
void create_bg()
{
	entity awrt = add_entity("menu");
	set_anchor(awrt, anchor::topleft);
	set_position(awrt, vec(-6, -5));
	set_depth(awrt, fixed_depth::background);
	animation::start(awrt);
}

[start]
void create_mc()
{
	entity mc = add_entity("MC_menu");
	set_position(mc, pixel(67, 11));
	set_depth(mc, fixed_depth::below);
	animation::start(mc);
	
	// Go in and out of existence
	while(yield())
	{
		wait(random(35000, 48300)/ 1000);
		
		// On my first go, I immediately thought
		// the engine was having rendering issues
		// so I replaced it with something a little
		// more... subtle (Hope ya dont mind).
		fx::fade_out(mc, 0.1);
    //wait(random(1500, 4880) / 1000);
		fx::fade_in(mc, 0.1);
	};
}

[start]
void create_flowers()
{
	entity flowers = add_entity("menu flowers");
	set_position(flowers, pixel(67, 110));
	set_depth(flowers, fixed_depth::below);
	animation::start(flowers);
}

[start]
void create_cloud()
{  
	entity cloud = add_entity("yet another cloud");
	set_depth(cloud, fixed_depth::background);
	cloud_movement(cloud, .374, -2, -3);
}

[start]
void create_cloud_2()
{  
	wait(random(19400, 26700) / 1000); // Lag it behind the other one
	entity cloud = add_entity("yet again a cloud");
	cloud_movement(cloud, .513, 1, 1.5);
}

const vec base_position(pixel(0, 250));
const vec item_padding(pixel(3, 4));

[start]
void mainmenu()
{
  menu main (base_position, vec(1, 3));
  
  main.add(text_entry("Start"));
  main.add(text_entry("Continue"));
  main.add(text_entry("Exit"));
  
  main.set_padding(item_padding);
  
	if (!are_there_saves())
		set_color(entity(main.get_option(1)), 255, 255, 255, 50);
	
	
  //needs 2 yields for some reason to prevent input leakage from terminal
  yield();
  yield();
  
  array<entity> meun_text;
  
  for(uint i = 0; i < main.get_options().length(); i++)
    meun_text.insertLast(entity(main.get_option(i)));
  
  bool exit = false;
	
	do
  {
    switch(main.tick())
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      //'Start'
      case 0:
        fx::scene_fade_out();
        load_scene("thoughts/entrance");
        break;
        
      //'Continue'
      case 1:
        if(are_there_saves())
				{
          set_color(meun_text[0], 255, 255, 255, 50);
          set_color(meun_text[2], 255, 255, 255, 50);
          main.hide_cursor();
          
          saves_menu();
          
          main.show_cursor();
          set_color(meun_text[0], 255, 255, 255, 255);
          set_color(meun_text[2], 255, 255, 255, 255);
        }
        break;
        
      //'Exit'
      case 2:
        abort_game();
        break;
    }
	} while(yield() && !exit);
	
  fx::scene_fade_out();
  load_scene("overture");
}

void saves_menu() {
  
  //TODO?: display some info about the hovered save, like progress or somethin
  
  array<menu_item@> save_slots;
  
  for(int i = 0; i < 3; i++)
    save_slots.insertLast(text_entry(is_slot_used(i) ? "Slot " + (i + 1) : "Empty"));
  
  menu saves (base_position + pixel(100, 0), vec(1, 3));
  
  saves.add(save_slots);
  saves.set_padding(item_padding);
  
  for(int i = 0; i < 3; i++)
    if(!is_slot_used(i))
      set_color(entity(saves.get_option(i)), 255, 200, 200, 250);
  
  bool go_back = false;
  
  // Pressing enter for the "Continue" bypasses the
  // next triggers causing it to load slot 1.
  // Having a normal while loop fixes this.
  while(yield() && !go_back)
  {
    int selection = saves.tick();
    
    switch(selection)
    {
      case menu_command::back:
        go_back = true;
        break;
        
      case menu_command::nothing:
        break;
      
      default:
        if(is_slot_used(selection) && confirm_load())
          load_slot(selection);  
        narrative::end();
        break;
    }
  }
}

bool confirm_load()
{
  fsay("Load this file?");
  return(select("Yes", "No") == option::first);
}

