
class item
{
  item() {}
  
  item(string pName, string pDescription, /*string pTexture, string pAtlas = "default:default"*/)
  {
    mName = pName;
    mDesc = pDescription;
    
    load_count();
  }
  
  const string name;
  const string desc;
  
  /*void use()
  {
    say("You should not see this message.");
    dprint("An item was used without a use() function defined.");
  }*/
  
  /*
  string mTexture;
  string mAtlas;
  */
  
  //private uint count;
  
  /*
  uint get_count()
  {
    return count;
  }
  
  void add_count(uint addend)
  {
    count += addend;
    save_count();
  }
  
  void subtract_count(uint subtrahend)
  {
    count -= subtrahend;
    save_count();
  }
  
  private void load_count()
  {
    if(values::exists("player/inventory/" + mName + "/count"))
    {
      count = values::get("player/inventory/" + mName + "/count");
    }
    else
    {
      count = 0;
      save_count();
    }
  }
  
  private void save_count()
  {
    values::set("player/inventory/" + mName + "/count", count);
  }
  */
}

item@ flower("Flower", "A beautiful flower. It gives you joy just looking at it.");
