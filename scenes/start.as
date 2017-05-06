#include "backend/dreamland_effects.as"

entity unicorn;

[group lockedhouse]
void lockedhouse()
{
	say("Nobodies home unfortunately.");
	narrative::end();
}

[start]
void create_unicorn()
{
	unicorn = add_entity("unicorn", "talk");
	set_position(unicorn, vec(5,4));
}
	
[start]
void start()
{
	music::open("doodle104");
	music::volume(70);
	set_position(get_player(), vec(5, 13));
	set_direction(get_player(), direction::up);
}

[group meetunicorn]
void meetunicorn()
{
	music::fade_volume(40, 1);
	player::lock(true);
	focus::move(midpoint(get_position(unicorn), get_position(get_player())), 1);
	narrative::show();
	narrative::set_speaker(unicorn);
	say("AH Hello here!");
	say("I'm the majestic unicorn\nof DEATH");
	nl("A fighter against world hunger.");
	say("This is the magical dreamland\nof, well, I don't know...");
	
	set_atlas(unicorn, "talk_headup");
	nl("DREAMS?");
	set_atlas(unicorn, "talk");
	
	say("I will be your guide.\nIt's too easy to get lost here.");
	nl("And drown in your own sorrow.");
	narrative::end();
	
	
	{
		scoped_entity hearts = add_entity("heartsburst");
		set_position(hearts , get_position(unicorn));
		
		remove_entity(unicorn);
		animation::start(hearts);
		animation::play_wait(hearts);
	}
	
	music::fade_volume(70, 1);
	focus::move(get_position(get_player()), 0.5);
	focus::player();
	player::lock(false);
	group::enable("meetunicorn", false);
}