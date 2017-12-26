//go here for *all* dialogue
#include "shop_dialogue.as"

[start]
void start()
{
  set_position(get_player(), vec(3, 3.8));
  set_direction(get_player(), direction::up);
  music::open("doodle181-shop-guy");
  fx::fade_in(1.5);
}

entity right_counter;
entity left_counter;

[start]
void make_counter()
{
  entity counter = add_entity("shop_tilemap", "sale_counter");
  set_anchor(counter, anchor::topleft);
  set_position(counter, vec(2, 1));
  
  left_counter  = add_entity("shop_tilemap", "counter");
  right_counter = add_entity("shop_tilemap", "counter");
  
  set_anchor(left_counter, anchor::topleft);
  set_anchor(right_counter, anchor::topleft);
  
  set_position(left_counter,  vec(1, 1));
  set_position(right_counter, vec(4, 1));
}

entity back_door;

[start]
void make_door()
{
  back_door = add_entity("shop_tilemap", "back_door");
  set_position(back_door, vec(4.5, 0));
}

entity shopkeep;

[start]
void add_shopkeep()
{
  shopkeep = add_entity("shopkeep", (has_flag("heyllo_intro") ? "default:default" : "hello"));
  set_anchor(shopkeep, anchor::top);
  set_position(shopkeep, vec(3, .3));
  if(!has_flag("heyllo_intro"))
    set_z(shopkeep, -.761);
}

