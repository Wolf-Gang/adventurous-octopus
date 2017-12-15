
[start]
void start()
{
  set_position(get_player(), vec(3, 3.8));
  set_direction(get_player(), direction::up);
  fx::fade_in(1.5);
}

[start]
void make_counter()
{
  entity counter = add_entity("shop_tilemap", "sale_counter");
  set_anchor(counter, anchor::topleft);
  set_position(counter, vec(2, 1));
  
  entity left_counter  = add_entity("shop_tilemap", "counter");
  entity right_counter = add_entity("shop_tilemap", "counter");
  
  set_anchor(left_counter, anchor::topleft);
  set_anchor(right_counter, anchor::topleft);
  
  set_position(left_counter,  vec(1, 1));
  set_position(right_counter, vec(4, 1));
}

entity shopkeep;

[start]
void add_shopkeep()
{
  shopkeep = add_entity("shopkeep", "hello");
  set_anchor(shopkeep, anchor::top);
  set_position(shopkeep, vec(3, .3));
  if(!has_flag("heyllo_intro"))
    set_z(shopkeep, -.761);
}

[group shopguyy]
void heyllo()
{
  if(!has_flag("heyllo_intro"))
  {
    rise();
    wait(.5);
    say("heyllo.");
    say("weylcome to shop.");
    fsay("you like... ");
    wait(1.312);
    append("potion?");
    if(select("yes.", "no.") == option::first)
    {
      say("sorry.");
      nl("potion not ready now.");
      nl("and have big order to fiyll.");
      say("apoylogies for inconvenience.");
    }
    else
    {
      say("that okay.");
    }
    set_flag("heyllo_intro");
  }
  else
  {
    say("how you?");
  }
  
  narrative::end();
  player::lock(false);
  return;
}

void rise()
{
  player::lock(true);
  move_z(shopkeep, 0, .2);
}

