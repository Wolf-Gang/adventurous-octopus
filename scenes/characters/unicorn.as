
namespace characters
{

class unicorn
{
  private entity mEntity;
  
  void create()
  {
    mEntity = add_character("unicorn");
  }
  
  void teleport(vec pPosition)
  {
    fx::sound("FX_away");
    
    const vec last_position = get_position(mEntity);
    set_position(mEntity, pPosition);
    
    hearts(last_position); // Hearts in old position
    hearts(pPosition);     // Hearts in new position
  }
  
  entity opImplConv()
  {
    return mEntity;
  }
  
  void disappear()
  {
    fx::sound("FX_away");
    set_visible(mEntity, false);
    hearts(get_position(mEntity));
  }
  
  void appear(vec pPosition)
  {
    set_position(mEntity, pPosition);
    appear();
  }
	
	void appear()
  {
    set_visible(mEntity, true);
    
    fx::sound("FX_away");
    hearts(get_position(mEntity));
  }
  
  private void hearts(vec pPosition)
  {
    scoped_entity hearts = add_entity("heartsburst");
    set_position(hearts, pPosition);
    animation::start(hearts);
    animation::play_wait(hearts);
  }
};

}