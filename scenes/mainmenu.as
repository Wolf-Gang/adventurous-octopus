
bool are_there_saves()
{
	if (is_slot_used(0)
	||  is_slot_used(1)
	||  is_slot_used(2))
		return true;
	return false;
}

[start]
void start()
{
	music::open("doodle110_theme");
	music::volume(70);
	set_visible(get_player(), false);
}

entity add_menu_text(const string&in pText, const vec&in pPosition)
{
	entity text = add_text();
	set_text(text, pText);
	make_gui(text, 1);
	set_position(text, pPosition);
	return text;
}

const vec base_position(pixel(20, 150));
const vec row(pixel(0, 20));
const vec column(pixel(100, 0));

entity cursor;

[start]
void mainmenu()
{
	// Create the little cursor thing
	cursor = add_entity("NarrativeBox", "SelectCursor");
	make_gui(cursor, 1);
	set_anchor(cursor, anchor::topright);
	set_position(cursor, base_position);
	
	// Create the selections
	entity selstart = add_menu_text("Start", base_position);
	entity selcontinue = add_menu_text("Continue", base_position + row);
	if (!are_there_saves())
		set_color(selcontinue, 100, 100, 100, 255);
	
	entity selexit = add_menu_text("Exit", base_position + row*2);
	
  //needs 2 yields for some reason to prevent input leakage from terminal
  yield();
  yield();
  
  int current_selection = 0;
  
  bool exit = false;
  
	do {
    
    if(is_triggered(control::select_up) && current_selection != 0)
      --current_selection;
    
    if(is_triggered(control::select_down) && current_selection != 2)
      ++current_selection;
    
    if(is_triggered(control::activate)) {
      
      switch(current_selection) {
        
        //'Start'
        case 0:
          
          load_scene("start");
          break;
        
        //'Continue'
        case 1:
          
          if(are_there_saves()) {
            
            set_color(selstart, 50, 50, 50, 255);
            set_color(selexit, 50, 50, 50, 255);
            
            saves_menu();
            
            set_color(selstart, 255, 255, 255, 255);
            set_color(selexit, 255, 255, 255, 255);
            
          }
          
          break;
        
        //'Exit'
        case 2:
          
          exit = true;
          break;
        
      }
      
      if(is_triggered(control::back))
        exit = true;
      
    }
    
    
    set_position(cursor, base_position + row * current_selection);
    
	} while(yield() && !exit);
  
  load_scene("overture");
  
}

void saves_menu() {

  array<entity> save_slots(3);
  
  for(int i = 0; i < 3; i++) {
    
    save_slots[i] = add_menu_text( (is_slot_used(i) ? "Slot " + (i + 1) : "Empty"), base_position + column + row * i);
    
    if(!is_slot_used(i))
      set_color(save_slots[i], 150, 150, 150, 255);
    
  }
  
  bool go_back = false;
  
  int selection = 0;
  
  do {
    
    if (is_triggered(control::select_up) && selection != 0)
			--selection;
      
		if (is_triggered(control::select_down) && selection != 2)
			++selection;
    
    if(is_triggered(control::activate)) {
      
      if(is_slot_used(selection)) {
      
        set_slot(selection);
        open_game();
        
      }
      
    }
    
    if(is_triggered(control::back))
      go_back = true;
    
    //TODO?: display some info about the hovered save, like progress or something
    
    set_position(cursor, base_position + column + row * selection);
    
  } while(yield() && !go_back);
  
  for(int i = 0; i < 3; i++) {
    
    remove_entity(save_slots[i]);
    
  }
  
}

