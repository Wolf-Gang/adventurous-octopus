#include "save_system.as"

void make_savepoint(vec pPos) {
  
  entity save_point = add_entity("save");
  animation::start(save_point);
  set_anchor(save_point, anchor::center);
  set_position(save_point, pPos);
  //TODO: when script collision becomes a thing, create the savepoint collision box
  
}

[group save]
void savepoint() {
  
  group::enable("save", false);
  open_savepoint();
  group::enable("save", true);
  
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
    
    if (is_triggered("select_left") && currect_selection != 0)
      --currect_selection;
    
    if (is_triggered("select_right") && currect_selection != 2)
      ++currect_selection;
    
    if(is_triggered("activate")) {
      
      if(confirm_save())
        save_slot(currect_selection);
      
      narrative::end();
      
    }
    
    if(is_triggered("back"))
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

