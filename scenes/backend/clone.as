

void make_clone(vec pPos, float pSpeed = 1, bool pMirror = false){
  
  entity clone = add_character("somedude1");
  set_position(clone, pPos);
  set_direction(clone, direction::down);
  
  create_thread(function(args) {
    
    const bool mirror = bool(args["mirror"]);
    
    const float speed = float(args["speed"]);
    
    entity clone = entity(args["clone"]);
    
    vec pos_difference = get_position(get_player()) - get_position(clone);
    
    vec movement;
    
    do {
      
      movement = (get_position(get_player()) - get_position(clone)) - pos_difference;
      
      if(movement.x != 0 || movement.y != 0) {
        
        set_direction(clone, vector_direction(movement * (mirror ? -1 : 1)));
        
        animation::start(clone);
        
        set_position(clone, get_position(clone) + (mirror ? -movement : movement) * speed);
        
      } else{
      
        animation::stop(clone);
        
      }
      
      pos_difference = get_position(get_player()) - get_position(clone);
      
    } while (yield());
    
  }, dictionary = {{"clone", clone}, {"speed", pSpeed}, {"mirror", pMirror}});
  
}

void make_clone(vec pPos, vec pScale){
  
  entity clone = add_character("somedude1");
  set_position(clone, pPos);
  set_direction(clone, direction::down);
  
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
    
  }, dictionary = {{"clone", clone}, {"scale", pScale}});
  
}

