[start]
void start()
{
	set_position(get_player(), vec(1, 20));
}



[start]
void create_boxes()
{

  // AAAAHHHHH PERFORMANCE
  for (uint x = 0; x < 25; x++)
  {
    for (uint y = 0; y < 30; y++)
    {
      entity box = add_entity("lost", "crate");
      set_depth(box, fixed_depth::background);
      set_position(box, vec(-9 + float(x), -3 + float(y)));
      set_parallax(box, -2);
    }
  }
  
}
