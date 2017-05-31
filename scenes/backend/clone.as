
void make_clone(vec pPos, vec pScale, entity pEntity)
{
  set_position(pEntity, pPos);
  set_direction(pEntity, direction::down);
  
  create_thread(function(args) {
    
    const vec scale = vec(args["scale"]);
    
    entity clone = entity(args["clone"]);
    
    vec pos_difference = get_position(get_player()) - get_position(clone);
    
    vec movement;
    
    do {
      
      movement = ((get_position(get_player()) - get_position(clone)) - pos_difference)*scale; // You can multiply vectors together
      
      if(movement.x != 0 || movement.y != 0) {
        
        set_direction(clone, vector_direction(movement));
        
        animation::start(clone);
        
        set_position(clone, get_position(clone) + vec(movement));
        
      } else{
      
        animation::stop(clone);
        
      }
      
      pos_difference = get_position(get_player()) - get_position(clone);
      
    } while (yield());
    
  }, dictionary = {{"clone", pEntity}, {"scale", pScale}});
  
}

