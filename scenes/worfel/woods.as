
#include "../backend/flowers.as"
#include "../backend/worfel_util.as"

entity worfel;

const vec worfel_spot (4.5, 3.51);

[start]
void giverofflowers()
{
  worfel = create_worfel(worfel_spot);
}

[start]
void start()
{
  set_position(get_player(), vec(4.5, 17.8));
}

const vec tree_box_offset = pixel(-11, -5);

void create_tree(vec pPos)
{
  entity tree = add_entity("woods_tilemap", "tree");
  set_position(tree, pPos);
  
  collision::create(pPos + tree_box_offset, -tree_box_offset * vec(2, .6));
}

[start]
void create_trees()
{
  //left
  for(int y = 0; y < 20; y++)
  {
    for(int x = 0; x < 4; x++)
    {
      vec pos (-1 + 1.3 * x + float(random(-16, 16)) / 16, 17.8 - y + float(random(-16, 16))/32);
      if(pos.distance(worfel_spot) >= 3.5)
        create_tree(pos);
    }
  }
  
  //top
  for(int y = 0; y < 2; y++)
  {
    for(int x = 0; x < 4; x++)
    {
      vec pos (2.5 + x + float(random(-16, 16)) / 32, -1 + y + float(random(-8, 8)) / 32);
      if(pos.distance(worfel_spot) >= 3.5)
        create_tree(pos);
    }
  }
  
  //right
  for(int y = 0; y < 20; y++)
  {
    for(int x = 0; x < 4; x++)
    {
      vec pos (6.5 + 1.3 * x + float(random(-16, 16)) / 16, 17.8 - y + float(random(-16, 16))/32);
      if(pos.distance(worfel_spot) >= 3.5)
        create_tree(pos);
    }
  }
}

[start]
void flowers()
{
  //create_flower_patch(vec(3, 1.5),  vec(6, 2));
  
  create_flower_patch(vec(1.75, 1.5), vec(12, 6), 3, flower_type::red);
}

[group worfel_notice]
void flowery_thing()
{
  player::lock(true);
  
  narrative::show();
  narrative::set_expression("question_expr", "default:default");
  
  say("Hmmm?");
  append(" A visitor?");
  
  narrative::hide();
  
  focus::move(worfel_spot, 1);
  
  move(get_player(), vec(4.5, 6), speed(2));
  set_direction(get_player(), direction::up);
  
  narrative::set_expression("worfel_expressions", "default:default");
  
  say("It is a very visitor, indeed.");
  
  say("It is from shop, yes?");
  nl("Worfel must ask it for help.");
  
  narrative::end();
  player::lock(false);
}

