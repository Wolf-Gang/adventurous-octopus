#include "backend/dreamland_effects.as"
#include "backend/savepoint.as"

[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(5, 9));
	set_direction(get_player(), direction::up);
}

void create_bush(vec pPosition, int t)
{
	entity bush;
	if(t == 1)
		bush = add_entity("dreamland", "cloudbush1");
	if(t == 2)
		bush = add_entity("dreamland", "cloudbush2");
	set_position(bush, pPosition);
}

[start]
void create_cloud_bushes()
{
	create_bush(vec(4.25, 3.5), 1);
	create_bush(vec(5.75, 3.25), 1);
	create_bush(vec(4, 3), 2);
}

entity unicorn;

[start]
void create_unicorn()
{
  if(!has_flag("unicorn_fork")) {
    unicorn = add_entity("unicorn", "talk");
    set_position(unicorn, vec(5,5));
  } else {
    group::enable("talktounicorn", false);
  }
}


[group talktounicorn]
void talktounicorn()
{	
	music::fade_volume(40, 1);
	player::lock(true);
	//focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	narrative::set_expression("unicorn icon", "default:default");
	say("OH NO! It's a fork!");
	nl("Watch out for these.\nThey'll eat you right up!");
	say("In this case, veer left\nand you might make it.");
	narrative::end();
	
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	
	group::enable("talktounicorn", false);
  set_flag("unicorn_fork");
}

[start]
void make_savepoint() {
  
  entity save_point = add_entity("save");
  set_anchor(save_point, anchor::center);
  set_position(save_point, vec(5, 3));
  
}

[group save]
void save() {
  
  group::enable("save", false);
  remove_dreamland_effects();
  open_savepoint();
  dreamland_clouds();
  group::enable("save", true);
  
}

