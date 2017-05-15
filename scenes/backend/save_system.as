
bool are_there_saves()
{
	if (is_slot_used(0)
	||  is_slot_used(1)
	||  is_slot_used(2))
		return true;
	return false;
}

void save_slot(int pSlot) {

  set_slot(pSlot);
  save_game();
  
}

void load_slot(int pSlot) {
  
  if(is_slot_used(pSlot)) {
  
    set_slot(pSlot);
    open_game();
    
  } else {
    
    dprint("Attempt to load unused slot");
    
  }
  
}



const vec origin = pixel(50, 30);
const vec separation = pixel(80, 0);

void open_savepoint()
{
  
  player::lock(true);
  
  scoped_entity bg = add_entity("pixel");
  make_gui(bg, 0);
  set_scale(bg, vec(10, 10)*32);
  set_color(bg, 0, 0, 0, 255);
  set_anchor(bg, anchor::topleft);
  set_depth(bg, 2);
  
  //keep the player visible
  set_depth(get_player(), fixed_depth::overlay);
  
  set_direction(get_player(), direction::up);
  
  array<entity> slots(3);
  
  for(int i = 0; i < 3; i++) {
    
    slots[i] = add_text();
    set_text(slots[i], "Slot " + (i + 1));
    make_gui(slots[i], 1);
    //set_anchor(slots[i], anchor::center);
    set_position(slots[i], origin + separation * i);
    
  }
  
  scoped_entity cursor = add_entity("NarrativeBox", "SelectCursor");
  make_gui(cursor, 3);
  set_anchor(cursor, anchor::topright);
  set_depth(cursor, fixed_depth::overlay);
  
  set_position(cursor, origin);
  
  int currect_selection = 0;
  
  yield();
  
  bool exit = false;
  
  do{
    
    if (is_triggered(control::select_previous) && currect_selection != 0)
      --currect_selection;
    
    if (is_triggered(control::select_next) && currect_selection != 2)
      ++currect_selection;
    
    if(is_triggered(control::activate)) {
      
      if(confirm_save())
        save_slot(currect_selection);
      
      narrative::end();
      
    }
    
    if(is_triggered(control::back))
      exit = true;
    
    set_position(cursor, origin + separation * currect_selection);
    
  } while(yield() && !exit);
  
  for(int i = 0; i < 3; i++) {
    
    remove_entity(slots[i]);
    
  }
  
  set_depth_fixed(get_player(), false);
  
  player::lock(false);
  
}

bool confirm_save() {

  fsay("Save on this file? ");
  return (select("Yes", "No") == option::first ? true : false);
  
}

