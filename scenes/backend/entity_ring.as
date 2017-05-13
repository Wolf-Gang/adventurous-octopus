

class entity_ring {
  
  private array<entity> mEntities;
  
  private float mRadius;
  
  private float mAngle;
  
  private float mRot_speed;
  
  private vec mCenter;
  
  entity_ring(array<entity> pEntities, float pRadius, vec pCenter, float pAngle = 0, float pRot_speed = 0) {
    
    this.mEntities = pEntities;
    
    this.mRadius = pRadius;
    
    this.mCenter = pCenter;
    
    this.mAngle = pAngle;
    
    this.mRot_speed = pRot_speed;
    
  }
  
  entity_ring() {
    
  }
  
  void insert_entity(entity pEntity, int index = -1) {
    
    if(index < 0)
      this.mEntities.insertLast(pEntity);
    else
      this.mEntities.insertAt(uint(index), pEntity);
      
    this.update_positions();
    
  }
  
  void delete_entity(uint index) {
    
    this.mEntities.removeAt(index);
    this.update_positions();
    
  }
  
  void set_radius(float pRadius) {
    
    this.mRadius = pRadius;
    this.update_positions();
    
  }
  
  void set_angle(float pDegrees) {
    
    this.mAngle = pDegrees;
    this.update_positions();
    
  }
  
  void set_speed(float pSpeed) {
    
    this.mRot_speed  = pSpeed;
    
  }
  
  void set_center(vec pCenter) {
    
    this.mCenter = pCenter;
    this.update_positions();
    
  }
  
  //Degrees per second
  void spin(float pSeconds = -1) {
    
    float t = 0;
    
    if(pSeconds < 0) {
      
      do {
        
        this.set_angle(this.mAngle + this.mRot_speed * get_delta());
        
      } while(yield());
      
    } else {
      
      do {
        
        this.set_angle(this.mAngle + this.mRot_speed * get_delta());
        
        t += get_delta();
        
      } while(yield() && t <= pSeconds);
      
    }
    
  }
  
  private void update_positions() {
    
    for(int i = 0; i < int(this.mEntities.length()); i++) {
      
      set_position(this.mEntities[i], (this.mCenter + vec(this.mRadius, 0)).rotate(mCenter, ((360 / this.mEntities.length()) * i) + this.mAngle));
      
    }
    
  }
  
}

