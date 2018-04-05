//go here for *all* dialogue
#include "shop_dialogue.as"


//move the shop closer to the end of dreamland when we get to that point
//so as to not overload the player with new things or distract overmuch
//from the main story of the area


[start]
void start()
{
  set_position(player::get(), vec(3, 3.8));
  set_direction(player::get(), direction::up);
	
	music::set_volume(0.7);
  music::open("doodle181-shop-guy");
}

entity right_counter;
entity left_counter;

[start]
void make_counter()
{
  entity counter = add_entity("shop_tilemap", "sale_counter");
  //set_anchor(counter, anchor::topleft);
  set_position(counter, vec(3, 2));
  
  left_counter  = add_entity("shop_tilemap", "counter");
  right_counter = add_entity("shop_tilemap", "counter");
  
  set_position(left_counter,  vec(1.5, 2));
  set_position(right_counter, vec(4.5, 2));
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
  shopkeep = add_entity("shopkeep", (has_flag("shopguy_intro") ? "default:default" : "hello"));
  set_position(shopkeep, pixel(96, 50));
  if(!has_flag("shopguy_intro"))
    set_z(shopkeep, -24/32);
}

[start]
void open_door()
{
  if(!has_flag("begin_shopguy_worfel_quest"))
    return;
  set_z(back_door, 1);
  set_visible(right_counter, false);
  group::enable("counter_right", false);
}

