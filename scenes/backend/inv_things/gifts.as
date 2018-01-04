
abstract class gift
{
  gift() {}
  
  gift(string pName, string pDescription, string pTexture, string pAtlas = "default:default")
  {
    mName = pName;
    mDesc = pDescription;
    
    load_count();
  }
  
  string name;
  string desc;
  
  string texture;
  string atlas;
  
  private bool mRecieved;
  
  void give()
  {
    mRecieved = true;
  }
  
  void remove()
  {
    mrecieved = false;
  }
  
  bool has()
  {
    return mRecieved;
  }
  
  void use()
  {
    say("You should not see this message. Check the debug log.");
    dprint("Gift " + mName + " was used without a use() function defined.");
  }
  
  private void load_recieved()
  {
    if(values::exists("player/gifts/" + mName + "/recieved"))
    {
      mRecieved = values::get("player/gifts/" + mName + "/recieved");
    }
    else
    {
      mrecieved = false;
      save_recieved();
    }
  }
  
  private void save_recieved()
  {
    values::set("player/gifts/" + mName + "/recieved", mRecieved);
  }
}

array<gift> gift_list;

class cloud_thingy : gift
{
  
}
