

[start]
void make_counter()
{
  entity counter = add_entity("shop_tilemap", "sale_counter");
  set_anchor(counter, anchor::topleft);
  set_position(counter, vec(2, 1));
}

