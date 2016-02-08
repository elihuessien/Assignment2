class Platform extends GO
{
  float speed;
  int w;
  int h;
  
  Platform()
  {
    speed = 10.0f;
    h = 20;
     
    if(level == 0)
    {
      w = 250;
    }
    
    if(level == 1)
    {
      w = 200;
    }
    
    if(level == 2)
    {
      w = 160;
    }
  }
  
  void update()
  {
    forward.x = -speed;
    forward.y = 0;
    pos.add(forward);
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rect(0, 0, w, h);
    popMatrix();
  }
}
