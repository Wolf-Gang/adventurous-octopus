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
const vec padding = pixel(15, 10);

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
  
  array<string> menu_text = {"Slot 1", "Slot 2", "Slot 3"};
  array<menu_item@> menu_items;
  
  for(uint i = 0; i < menu_text.length(); i++)
    menu_items.insertLast(text_entry(menu_text[i]));
  
  menu save_menu (menu_items, origin, padding, vec(3, 1), false, true);
  
  yield();
  
  bool exit = false;
  
  do
  {
    
    int sel = save_menu.tick();
    
    switch(sel)
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
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

array<entity> gifters (1);

void show_gifts()
{
  if(user_data::has_gift("Cloud"))
  {
    gifters[0] = add_entity("little_phlooph");
    make_gui(gifters[0], 3);
    set_position(gifters[0], pixel(160, 200));
  }
}

void hide_gifters()
{
  for(uint i = 0; i < gifters.length(); i++)
    if(gifters[i].is_valid())
      remove_entity(gifters[i]);
}

