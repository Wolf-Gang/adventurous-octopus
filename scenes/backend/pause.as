#include "user_data.as"


namespace pause
{

  namespace priv
  {
    bool pause_locked;
    
    [start]
    void pause_on()
    {
      pause_locked = false;
    }
    
    array<menu_item@> make_text_items(array<string> pInputs)
    {
      array<menu_item@> ret;
      
      for(uint i = 0; i < pInputs.length(); i++)
      {
        ret.insertLast(text_entry(pInputs[i]));
      }
      
      return ret;
    }
    
    array<menu_item@> make_text_sprite_items(array<string> pInputs, array<array<string>> pSprites)
    {
      array<menu_item@> ret;
      
      for(uint i = 0; i < pInputs.length(); i++)
      {
        ret.insertLast(text_sprite_entry(pInputs[i], pSprites[i][0], pSprites[i][1]));
      }
      
      return ret;
    }
  }
  
  void lock(bool pLock)
  {
    yield();
    pause::priv::pause_locked = pLock;
  }
  
};

[start]
void check_pause() {
  
  do {
    
    if(!pause::priv::pause_locked && is_triggered("menu"))
      open_menu();
    
  } while(yield());
  
};

const vec pause_menu_position  = pixel(35, 27);
const vec pause_option_padding = pixel(5, 7);

void open_menu()
{
  array<string> pause_strings = {"Items"};
  if(player_has_a_gift())
    pause_strings.insertLast("Gifts");
  
  menu pause_menu (pause_menu_position, vec(1, 3));
  
  pause_menu.add(pause::priv::make_text_items(pause_strings));
  pause_menu.show_box(true);
  pause_menu.set_padding(pause_option_padding);
  
  player::lock(true);
  
  bool exit = false;
  
  do
  {
    
    switch(pause_menu.tick())
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      //inventory
      case 0:
        pause_menu.hide();
        open_inv();
        pause_menu.show();
        break;
      
      //gifts
      case 1:
        pause_menu.hide();
        open_gifts();
        pause_menu.show();
    }
    
  } while(yield() && !exit);
  
  player::lock(false);
}

void open_inv()
{
  array<menu_item@> inv = pause::priv::make_text_items(user_data::get_inventory_list());
  
  menu inv_menu (pause_menu_position, vec(1, 3));
  
  inv_menu.add(inv);
  inv_menu.show_box(true);
  inv_menu.set_padding(pause_option_padding);
  
  if(inv.length() == 0)
    inv_menu.hide_cursor();
  
  bool exit = false;
  
  while(!exit && yield())
  {
    int sel = inv_menu.tick();
    
    switch(sel)
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      default:
        if(inv.length() == 0)
          break;
        say(user_data::inventory[sel].get_desc());
        narrative::end();
        break;
    }
    
  }
  
  
}

void open_gifts()
{
  menu gift_menu (pause_menu_position, vec(1, gift_list.length()));
  
  gift_menu.add(pause::priv::make_text_sprite_items(user_data::get_gift_names(), user_data::get_gift_sprites()));
  gift_menu.show_box(true);
  gift_menu.set_padding(pause_option_padding);
  
  bool exit = false;
  
  while(!exit && yield())
  {
    int sel = gift_menu.tick();
    
    switch(sel)
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
        
      default:
        
        break;
    }
  }
}

