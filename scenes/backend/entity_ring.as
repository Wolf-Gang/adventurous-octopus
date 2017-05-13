

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
  }
  
  entity_ring() {
    
  }
  
  void add_entity(entity pEntity, int index = -1) {
    
    if(index < 0)
      mEntities.insertLast(pEntity);
    else
      mEntities.insertAt(pEntity, uint(index));
  }
  
  void remove_entity(uint index) {
    
    mEntities.removeAt(index);
    
  }
  
  void set_radius(float pRadius) {
    
    mRadius = pRadius;
    
  }
  
  void set_angle(float pDegrees) {
    
    mAngle = pDegrees;
    
  }
  
  //Degrees per second
  void spin(float pSeconds = -1) {
    
    float t = 0;
    
    if(pSeconds < 0) {
      
      do {
        
        this.set_angle(mRot_speed * get_delta());
        
      } while(yield());
      
    } else {
      
      do {
        
        this.set_angle(mRot_speed * get_delta());
        
        t += get_delta();
        
      } while(yield() && t <= pSeconds);
      
    }
    
  }
  
}

