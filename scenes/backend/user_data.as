
// This is mostly for example.
// It can be changed up to what is needed.

enum item_type
{
  misc = 0,
  food,
}

namespace user_data
{
  
  namespace priv
  {
    const string root_player_directory = "player";
    
    const int default_hp = 100;
    const string player_hp  = root_player_directory + "/hp";  // "player/hp"
    const string player_atk = root_player_directory + "/atk";
    const string player_def = root_player_directory + "/def";
    
    const string player_inventory = root_player_directory + "/inventory"; // "player/inventory"
    
    // Ensure that all user data exists
    // and setup defaults if they don't.
    [start]
    void setup()
    {
       if (!values::exists(player_hp))
         user_data::set_hp(default_hp);
    }
  }

  void set_hp(int pValue)
  {
    values::set(user_data::priv::player_hp, pValue);
  }
  
  int get_hp()
  {
    return values::get_int(user_data::priv::player_hp);
  }
  
  void set_atk(int pValue)
  {
    values::set(user_data::priv::player_atk, pValue);
  }
  
  int get_atk()
  {
    return values::get_int(user_data::priv::player_atk);
  }
  
  void set_def(int pValue)
  {
    values::set(user_data::priv::player_def, pValue);
  }
  
  int get_def()
  {
    return values::get_int(user_data::priv::player_def);
  }
  
  array<string> get_inventory_items()
  {
    return values::get_entries(user_data::priv::player_inventory);
  }
  
  bool has_item(const string&in pName)
  {
    return values::exists(user_data::priv::player_inventory + "/" + pName);
  }
  
  array<string> get_item_sprite(string pName)
  {
    return array<string> = {
    values::get_string(user_data::priv::player_inventory + pName + "/atlas"),
    values::get_string(user_data::priv::player_inventory + pName + "/texture"};
  }
  
  item_type get_item_type(const string&in pName)
  {
    const string path = user_data::priv::player_inventory + "/" + pName + "/type";
    if (!values::exists(path))
    {
      eprint("Invalid inventory item");
      return item_type::misc;
    }
    return item_type(values::get_int(path));
  }
  
  void add_inventory(const string&in pName, item_type pType, const string&in pTexture = "", const string&in pAtlas = "")
  {
    // Each inventory item is an entry in the inventory directory
    const string path = user_data::priv::player_inventory + "/" + pName;
    
    // In this example each inventory item has a value
    // specifying how much you have of this item.
    // Increment this value when inserting the same thing.
    if (values::exists(path))
    {
      int item_count = values::get_int(path);
      ++item_count;
      values::set(path, item_count);
    }
    else
    {
      // Create the new inventory entry
      // with the value "1" for 1 item.
      values::set(path, 1);
      
       // Entries can actually double as folders
       // because of the way paths work.
      values::set(path + "/type", int(pType));
      
      if(pTexture != "")
        values::set(path + "/texture", pTexture);
      
      if(pAtlas != "")
        values::set(path + "/atlas", pAtlas);
    }
  }
}

