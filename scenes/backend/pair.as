
class pair {
  
  private entity right;
  private entity left;
  
  private float separation;
  
  private float angle;
  
  pair() {
  }
  
  pair(const pair &in other) {
	
    this.right = other.get_right();
    this.left = other.get_left();
    
    this.separation = other.get_separation();
    
    this.angle = other.get_angle();
    this.set_pair_position(other.get_pair_position());
	
  }
  
  pair(string pLeft_texture, string pRight_texture, vec &in pPosition, float pSeparation, float pAngle = 0) {
    
    right = add_entity(pRight_texture);
    left = add_entity(pLeft_texture);
    
    separation = pSeparation;
    
    angle = pAngle;
    
    set_pair_position(pPosition);
  }
  
  pair(string pLeft_texture, string pLeft_atlas, string pRight_texture, string pRight_atlas, vec &in pPosition, float pSeparation, float pAngle = 0) {
    
    right = add_entity(pRight_texture, pRight_atlas);
    left = add_entity(pLeft_texture, pLeft_atlas);
    
    separation = pSeparation;
    
    angle = pAngle;
    
    set_pair_position(pPosition);
  }
  
  pair(string pPair_texture, vec &in pPosition, float pSeparation, float pAngle = 0) {
    
    left = add_entity(pPair_texture);
    right = add_entity(pPair_texture);
    
    separation = pSeparation;
    
    angle = pAngle;
    
    set_pair_position(pPosition);
  }
  
  void set_left(entity e) {
    left = e;
  }
  
  entity get_left() const {
    
    return left;
    
  }
  
  void set_right(entity e) {
    
    right = e;
    
  }
  
  entity get_right() const { 
    
    return right;
    
  }
  
  void set_separation(float pSeparation) {
    
    separation = pSeparation;
    
    update_positions();
  }
  
  float get_separation() const {
    
    return separation;
    
  }
  
  void set_angle(float pRadians) {
    
    angle = pRadians;
    
    update_positions();
  }
  
  float get_angle()  const {
    
    return angle;
    
  }
  
  void set_pair_position(vec pPos_left)
  {
    set_position(left, pPos_left);
    update_positions();
  }
  
  void move_pair(vec pPosition, float time) {
    for(float t = 0; t < time; t += get_delta()) {
      set_pair_position(get_pair_position() + (pPosition - get_pair_position()) * get_delta());
    }
  }
  
  void move_pair(vec pPosition, speed pSpeed) {
    move_pair(pPosition, pSpeed.get_time(get_pair_position().distance(pPosition)));
  }
  
  vec get_pair_position() const{
    
    return get_position(left);
    
  }
  
  void set_pair_atlas(string atlas) {
    
    set_atlas(right, atlas);
    set_atlas(left, atlas);
  }

  void start_pair_animation() {
    
    animation::start(right);
    animation::start(left);
  }

  void set_pair_depth(float depth) {
    
    set_depth(right, depth);
    set_depth(left, depth);
  }
  
  pair@ opAssign(const pair &in other) {
    
    this.right = other.get_right();
    this.left = other.get_left();
    
    this.separation = other.get_separation();
    
    this.angle = other.get_angle();
	
    set_pair_position(other.get_pair_position());
    return this;
  }
  
  private void update_positions()
  {
    vec right_position = get_position(left);
    right_position.x += separation;
    set_position(right, right_position.rotate(get_position(left), angle));
  }
  
}

