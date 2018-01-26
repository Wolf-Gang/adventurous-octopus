
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
      load_inv();
    }
    
    void save_inv()
    {
      values::remove(player_inventory);
      for(uint i = 0; i < inventory.length(); i++)
        values::set(player_inventory + "/" + inventory[i].get_name(), "placeholder value");
    }
    
    void load_inv()
    {
      array<string> item_names = values::get_entries(player_inventory);
      for(uint i = 0; i < item_names.length(); i++)
        inventory.insertLast(item_named(item_names[i]));
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
  
  item@ item_named(const string&in pName)
  {
    for(uint i = 0; i < complete_item_list.length(); i++)
      if(complete_item_list[i].get_name() == pName)
        return complete_item_list[i];
    eprint(pName + " is not a valid item name.");
    return null;
  }
  
  bool has_item(const string&in pName)
  {
    for(uint i = 0; i < inventory.length(); i++)
      if(inventory[i].get_name() == pName)
        return true;
    
    return false;
  }
  
  int get_item_slot(const string&in pName)
  {
    uint slot = 0;
    for(; slot < inventory.length(); slot++)
      if(inventory[slot].get_name() == pName)
        return slot;
    return -1;
  }
  
  void add_inventory(const string&in pName)
  {
    inventory.insertLast(item_named(pName));
    user_data::priv::save_inv();
  }
  
  void remove_inventory(const string&in pName)
  {
    if(has_item(pName))
      remove_inventory(get_item_slot(pName));
    else
      dprint("Attempt to remove non-held item " + pName);
    user_data::priv::save_inv();
  }
  
  void remove_inventory(uint pSlot)
  {
    inventory.removeAt(pSlot);
    user_data::priv::save_inv();
  }
  
  //------------------------------Gifts------------------------------------------//
  
  array<string> get_gift_names()
  {
    array<string> names;
    for(uint i = 0; i < gift_list.length(); i++)
      if(gift_list[i].has_gift())
        names.insertLast(gift_list[i].get_name());
    return names;
  }
  
  array<array<string>> get_gift_sprites()
  {
    array<array<string>> sprites;
    for(uint i = 0; i < gift_list.length(); i++)
      if(gift_list[i].has_gift())
        sprites.insertLast(array<string> = {gift_list[i].get_texture(), gift_list[i].get_atlas()});
    return sprites;
  }
  
  void give_gift(gift@ pGift)
  {
    pGift.give();
  }
  
  void remove_gift(gift@ pGift)
  {
    pGift.remove();
  }
  
  bool has_gift(string pName)
  {
    for(uint i = 0; i < gift_list.length(); i++)
      if(gift_list[i].get_name() == pName)
        return true;
    return false;
  }
}

