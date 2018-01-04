
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
  }
  
  //--------------------------Inventory---------------------------------------//
  
  array<item@> inventory;
  
  array<item@> get_inventory()
  {
    return inventory;
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
      if(inventory[slot] == pName)
        return slot;
    return -1;
  }
  
  void add_inventory(item@ pItem)
  {
    inventory.insertLast(pItem);
    values::save(user_data::priv::player_inventory + "/" + formatInt(inventory.length() - 1), pItem.name);
  }
  
  void remove_inventory(const string&in pName/*, const uint pCount = 1*/)
  {
    if(has_item(pName))
      inventory.removeAt(uint(get_item_slot(pName)));
      values::remove(user_data::priv::player_inventory + "/" + formatInt(get_item_slot(pName)));
    else
      dprint("Attempt to remove non-held item " + pName);
  }
  
  void remove_inventory(uint pSlot)
  {
    inventory.removeAt(pSlot);
    values::remove(user_data::priv::player_inventory + "/" + formatInt(pSlot));
  }
  
  //------------------------------Gifts------------------------------------------//
  
  void give_gift(gift@ pGift)
  {
    pGift.give();
    values::save(user_data::priv::player_gifts + "/" + pGift.name, "Given");
  }
  
  void remove_gift()
  {
    
  }
}

