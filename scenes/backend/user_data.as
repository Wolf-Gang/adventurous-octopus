
#include "inv_things/items.as"
#include "inv_things/gifts.as"

namespace user_data
{
  
  namespace priv
  {
    const string root_player_directory = "player";
    
    const string player_inventory = root_player_directory + "/inventory"; // "player/inventory"
    const string player_gifts = root_player_directory + "/gifts";
    
    // Ensure that all user data exists
    // and setup defaults if they don't.
    [start]
    void setup()
    {
      
    }
    
    void save_inv()
    {
      values::remove(player_inventory);
      for(uint i = 0; i < inventory.length(); i++)
        values::set(player_inventory + "/" + formatInt(i), "dfalh");
    }
  }
  
  //--------------------------Inventory---------------------------------------//
  
  array<item@> inventory;
  
  array<string> get_inventory_list()
  {
    array<string> item_names;
    for(uint i = 0; i < inventory.length(); i++)
      item_names.insertLast(inventory[i].get_name());
    return item_names;
  }
  
  bool has_item(const string&in pName)
  {
    for(uint i = 0; i < inventory.length(); i++)
      if(inventory[i].get_name() == pName)
        return true;
    
    return false;
  }
  
  int get_item_slot(const string &in pName)
  {
    uint slot = 0;
    for(; slot < inventory.length(); slot++)
      if(inventory[slot].get_name() == pName)
        return slot;
    return -1;
  }
  
  void add_inventory(item@ pItem)
  {
    inventory.insertLast(pItem);
    values::set(user_data::priv::player_inventory + "/" + formatInt(inventory.length() - 1), pItem.name);
  }
  
  void remove_inventory(const string&in pName)
  {
    if(has_item(pName))
      remove_inventory(get_item_slot(pName));
    else
      dprint("Attempt to remove non-held item " + pName);
  }
  
  void remove_inventory(uint pSlot)
  {
    inventory.removeAt(pSlot);
    user_data::priv::save_inv();
  }
  
  //------------------------------Gifts------------------------------------------//
  
  array<string> get_gift_list()
  {
    array<string> names;
    for(uint i = 0; i < gift_list.length(); i++)
      if(gift_list[i].has_gift())
        names.insertLast(gift_list[i].get_name());
    return names;
  }
  
  void give_gift(gift@ pGift)
  {
    pGift.give();
  }
  
  void remove_gift(gift@ pGift)
  {
    pGift.remove();
  }
}

