
const string path_root = "worfel";

entity create_worfel(vec pPos)
{
  entity w = add_entity("worfel");
  set_position(w, pPos);
  
  return w;
}

