
#include "backend/entity_ring.as"

entity_ring fork_ring;

[start]
void fork_dance() {
  
  array<entity> forks;
  
  for(int i = 0; i < 20; i++) {
    
    forks.insertLast(add_entity("fork"));
    
  }
  
  fork_ring = entity_ring (forks, 3, vec(0, 0), 0, 20);
  
  wait(5);
  
  fork_ring.set_speed(40);
  
}

[start]
void all_around_you() {
  
  do {
    
    fork_ring.set_center(get_position(get_player()));
    
  } while(yield());
  
}

[start]
void ring_spin() {
  
  fork_ring.spin();
  
}