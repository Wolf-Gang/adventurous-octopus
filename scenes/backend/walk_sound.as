
namespace walk_sound
{

namespace priv
{
  string walk_sound = "FX_footsteps";
  bool is_walk_sound_enabled = false;
}

void set_sound(const string &in pSound)
{
  priv::walk_sound = pSound;
}

void set_enabled(bool pIs_enabled)
{
  priv::is_walk_sound_enabled = pIs_enabled;
}

[start]
void walk_sound()
{
  vec last_position = get_position(get_player()); // Tracks when the player is moving
  bool sound_played = true; // This ensures that the sound plays once
  while(yield())
  {
    const vec position = get_position(get_player());
    if (position != last_position && !player::is_locked())
    {
      last_position = position;
    
      const uint frame = animation::get_frame(get_player());
      if (frame == 1 && !sound_played)
      {
        sound_played = true;
        fx::sound(priv::walk_sound, 1, 0.01 * random(90, 110));
      }
      else if (frame != 1)
        sound_played = false;
    }
  }
}

}