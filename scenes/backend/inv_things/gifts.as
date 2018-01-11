
enum gift_received
{
  not_received = 0,
  received
}

abstract class gift
{
  gift() {}
  
  string get_name()    {return "";}
  
  string get_desc()    {return "";}
  
  string get_texture() {return "";}
  
  string get_atlas()   {return "";}
  
  entity create_entity()
  {
    entity e = add_entity("vill");
    return e;
  }
  
  protected bool mReceived;
  
  void give()
  {
    mReceived = true;
    //save_received();
  }
  
  void remove()
  {
    mReceived = false;
    //save_received();
  }
  
  bool has_gift()
  {
    return mReceived;
  }
  
  void use()
  {
    say("You should not see this message. Check the debug log.");
    eprint("Gift was used without a use() function defined.");
  }
  
  /*
  protected void load_received()
  {
    if(values::exists("player/gifts/" + mName + "/received"))
    {
      mReceived = (values::get_int("player/gifts/" + mName + "/received") == gift_received::received);
    }
    else
    {
      mReceived = false;
      save_received();
    }
  }
  
  protected void save_received()
  {
    if(mReceived)
      values::set("player/gifts/" + mName + "/received", gift_received::received);
    else
      values::set("player/gifts/" + mName + "/received", gift_received::not_received);
  }
  */
}

const array<gift@> gift_list = {};

bool player_has_a_gift()
{
  for(uint i = 0; i < gift_list.length(); i++)
    if(gift_list[i].has_gift())
      return true;
  return false;
}

class cloud_thingy : gift
{
  string get_name() override
  {
    return "Cloud";
  }
  
  string get_desc() override
  {
    return "";
  }
  
  void use()
  {
    
  }
}

