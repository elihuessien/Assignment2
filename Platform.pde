class Platform extends GO
{
  float speed;
  int w = 160;
  int h = 20;
  
  void update()
  {
    forward.x = -speed;
    forward.y = 0;
    pos.add(forward);
    speed = 10.0f;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rect(0, 0, w, h);
    popMatrix();
  }
}
