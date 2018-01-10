
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
}

const item@ flower = item("Flower", "A beautiful flower. It gives you joy just looking at it.");
