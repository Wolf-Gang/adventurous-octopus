
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
  
  wait(2);
  
  for(float t = 0; t < 10; t += get_delta()) {
    
    fork_ring.set_radius(3 + sin(math::pi * t));
    yield();
    
  }
  
  wait(10);
  
  narrative::show();
  narrative::set_skip(false);
  
  oneofus();
  
  wait(7);
  
  oneofus();
  
  wait(6);
  
  oneofus();
  
  wait(4);
  
  oneofus();
  
  wait(2);
  
  oneofus();
  oneofus();
  
  wait(1);
  
  create_thread(function(args) {
    
    entity_ring@ ring = cast<entity_ring>(args["ring"]);
    
    for(float t = 0; t < 6; t += get_delta()) {
      
      ring.set_radius(3 - t * .25);
      ring.set_speed(40 + t * 5);
      yield();
      
    }
    
  }, dictionary = {{"ring", fork_ring}});
  
  for(int i = 0; i < 12; i ++) {
    
    fsay("ONEOFUS");
    wait(.5);
    
  }
  
  narrative::hide();
  player::lock(false);
  
}

void oneofus() {
  
  fsay("ONEOFUS");
  wait(.5);
  narrative::hide();
  player::lock(false);
  
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