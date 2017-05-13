
#include "backend/entity_ring.as"

entity_ring fork_ring;

[start]
void forky() {
  
  array<entity> forks;
  
  for(int i = 0; i < 20; i++) {
    
    forks.insertLast(add_entity("fork"));
    
  }
  
  fork_ring = entity_ring (forks, 3, vec(0, 0), 0, 20);
  
  
  
}

