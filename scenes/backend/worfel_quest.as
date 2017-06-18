#include "user_data.as"

entity mc_hat;

[start]
void flower_hat()
{  
  if(has_flower())
  {
    mc_hat = add_entity("dreamland", "purpleflower");
    set_position(mc_hat, get_position(get_player()) + vec(0, .01));
    set_z(mc_hat, .8);
    add_child(get_player(), mc_hat);
  } 
}

bool has_flower()
{
  return user_data::has_item("Flower");
}

void get_flower()
{
  if(!has_flower())
  {
    user_data::add_inventory("Flower", item_type::misc);
    flower_hat();
  }
}

void give_flower(entity pRecipient, float pTime)
{
  detach_parent(mc_hat);
  move(mc_hat, get_position(pRecipient) + vec(0, .01), pTime);
  user_data::remove_inventory("Flower");
  
  add_child(pRecipient, mc_hat);
  float r_height = pixel(get_size(pRecipient)).y;
  set_z(mc_hat, r_height * .9);
  user_data::remove_inventory("Flower");
}

