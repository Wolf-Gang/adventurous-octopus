#include "backend/dreamland_effects.as"

[start]
void start()
{
	music::open("doodle104");
	music::volume(70);
	set_position(get_player(), vec(5, 5));
	set_direction(get_player(), direction::up);
}
