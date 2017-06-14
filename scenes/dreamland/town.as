
//ALL POSITIONS ARE FROM TOP-LEFT!?

//collision+entity
void create_bench(vec pPos, bool pVert = false)
{
  const vec offset = pixel(4, 13);
  const vec size = pixel(56, 10);
  
  const vec v_offset = pixel(7.5, 12);
  const vec v_size = pixel(18, 48);
  
  entity bench = add_entity("dreamland", "bench" + (pVert ? "2" : "1"));
  set_anchor(bench, anchor::bottomleft);
  set_position(bench, pPos + pixel(0, (pVert ? 64 : 32)));
  
  if(pVert)
    collision::create(collision::type::wall, pPos + v_offset, v_size);
  else
    collision::create(collision::type::wall, pPos + offset, size);
}

//On hold until script doors
void create_house(vec pPos, string pScene)
{
  //oh boy
  const vec base_offset = pixel(18, 73);
  
  const vec collision_size = pixel(34, 22);
  
}
