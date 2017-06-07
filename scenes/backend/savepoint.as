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

const vec origin = pixel(70, 30);
const vec separation = pixel(80, 10);

void open_savepoint()
{
  
  player::lock(true);
  
  scoped_entity bg = add_entity("pixel");
  make_gui(bg, 0);
  set_scale(bg, get_display_size());
  set_color(bg, 0, 0, 0, 255);
  set_anchor(bg, anchor::topleft);
  set_depth(bg, 2);
  
  //keep the player visible
  set_depth(get_player(), fixed_depth::overlay);
  
  set_direction(get_player(), direction::up);
  
  array<string> menu_items = {"Slot 1", "Slot 2", "Slot 3"};
  
  list_menu save_menu (menu_items, origin, 3, separation);
  
  yield();
  
  bool exit = false;
  
  do
  {
    
    int sel = save_menu.tick();
    
    switch(sel)
    {
      case -2:
        exit = true;
        break;
      
      case -1:
        break;
      
      default:
        if(confirm_save())
          save_slot(sel);
        
        narrative::end();
        break;
    
    }
    
  } while(yield() && !exit);
  
  save_menu.set_visible(false);
  
  set_depth_fixed(get_player(), false);
  
  player::lock(false);
  
}

bool confirm_save() {

  fsay("Save on this file? ");
  return (select("Yes", "No") == option::first ? true : false);
  
}

