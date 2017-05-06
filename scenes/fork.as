#include "backend/dreamland_effects.as"

entity unicorn;

[start]
void create_unicorn()
{
	unicorn = add_entity("unicorn", "talk");
	set_position(unicorn, vec(5,5));
}

[start]
void start()
{
	music::open("doodle104_2");
	music::volume(70);
	set_position(get_player(), vec(5, 9));
	set_direction(get_player(), direction::up);
}

[group talktounicorn]
void talktounicorn()
{	
	music::fade_volume(40, 1);
	player::lock(true);
	//focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("");
	narrative::end();
	
	
	unicorn_disappear(unicorn);
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	
	group::enable("talktounicorn", false);
}