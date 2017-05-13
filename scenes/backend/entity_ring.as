

class entity_ring {
  
  private array<entity> mEntities;
  
  private float mRadius;
  
  private float mAngle;
  
  private float mRot_speed;
  
  private vec mCenter;
  
  entity_ring(array<entity> pEntities, float pRadius, vec pCenter, float pAngle = 0, float pRot_speed = 0) {
    
    mEntities = pEntities;
    
    mRadius = pRadius;
    
    mCenter = pCenter;
    
    mAngle = pAngle;
    
    mRot_speed = pRot_speed;
    
    if(mRot_speed != 0)
      create_thread(function(args) {
        
        entity_ring ring = entity_ring(args["this"]);
        
        ring.spin();
        
      }, dictionary = {{"this", this}});
  }
  
  entity_ring() {
    
  }
  
  void insert_entity(entity pEntity, int index = -1) {
    
    if(index < 0)
      mEntities.insertLast(pEntity);
    else
      mEntities.insertAt(uint(index), pEntity);
      
    this.update_positions();
    
  }
  
  void delete_entity(uint index) {
    
    mEntities.removeAt(index);
    this.update_positions();
    
  }
  
  void set_radius(float pRadius) {
    
    mRadius = pRadius;
    this.update_positions();
    
  }
  
  void set_angle(float pDegrees) {
    
    mAngle = pDegrees;
    this.update_positions();
    
  }
  
  void set_speed(float pSpeed) {
    
    mRot_speed  = pSpeed;
    
  }
  
  void set_center(vec pCenter) {
    
    mCenter = pCenter;
    this.update_positions();
    
  }
  
  //Degrees per second
  void spin(float pSeconds = -1) {
    
    float t = 0;
    
    if(pSeconds < 0) {
      
      do {
        
        this.set_angle(mRot_speed * get_delta());
        
        this.update_positions();
        
      } while(yield());
      
    } else {
      
      do {
        
        this.set_angle(mRot_speed * get_delta());
        
        this.update_positions();
        
        t += get_delta();
        
      } while(yield() && t <= pSeconds);
      
    }
    
  }
  
  private void update_positions() {
    
    for(int i = 0; i < int(mEntities.length()); i++) {
      
      set_position(mEntities[i], (mCenter + vec(mRadius, 0)).rotate(((360 / mEntities.length()) * i) + mAngle));
      
    }
    
  }
  
}

