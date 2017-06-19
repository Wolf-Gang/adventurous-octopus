#include "save_system.as"

[group quicksave]
void quicksave() {
  
  if(!are_there_saves())
    set_slot(0);
  save_game();
  group::enable("quicksave", false);
}

