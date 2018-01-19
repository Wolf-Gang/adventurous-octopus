
class item
{
  item() {}
  
  item(string pName, string pDescription)
  {
    mName = pName;
    mDesc = pDescription;
  }
  
  private string mName;
  private string mDesc;
  
  string get_name()
  {
    return mName;
  }
  
  string get_desc()
  {
    return mDesc;
  }
  
  bool opEquals(item@ a)
  {
    return this.mName == a.get_name() && this.mDesc == a.get_desc();
  }
}

array<item@> complete_item_list = {
item("Flower", "A beautiful flower. It gives you joy just looking at it.")
};