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
  array<string> pause_options = {"Items"};
  if(player_has_a_gift())
    pause_options.insertLast("Gifts");
  
  menu pause_menu (pause::priv::make_text_items(pause_options), pause_menu_position, pause_option_padding, vec(1, 3));
  
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
  array<string> inv_list = user_data::get_inventory_list();
  
  /*
  for(uint i = 0; i < inv_sprites.length(); i++)
  {
    array<string> info = user_data::get_item_sprite(inv_list[i]);
    inv_sprites[i] = add_entity(info[0], info[1]);
  }
  */
  
  menu inv (pause::priv::make_text_items(inv_list.length() != 0 ? inv_list : array<string> = {"Empty", "Like", "Your", "Soul"}), pause_menu_position, pause_option_padding, vec(1, (inv_list.length() ==0 ? 4 :inv_list.length())));
  
  if(inv_list.length() == 0)
    inv.hide_cursor();
  
  bool exit = false;
  
  while(yield() && !exit)
  {
    int sel = inv.tick();
    
    switch(sel)
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      default:
        if(inv_list.length() == 0)
          break;
        say(user_data::inventory[sel].get_desc());
        narrative::end();
        break;
    }
    
  }
}

void open_gifts()
{
  array<string> gift_names = user_data::get_gift_list();
  array<array<string>> gift_sprites;
  
  for(uint i = 0; i < gift_list.length(); i++)
    if(gift_list[i].has_gift())
        gift_sprites.insertLast(array<string> = {gift_list[i].get_texture(), gift_list[i].get_atlas()});
  
  menu gift_menu (pause::priv::make_text_sprite_items(gift_names, gift_sprites), pause_menu_position, pause_option_padding, vec(1, gift_list.length()));
  
  bool exit = false;
  
  while(yield() && !exit)
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

