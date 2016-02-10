class AniBall extends GO
{
  int crw;
  
  AniBall()
  {
    w = 30;
    pos.x = int(random(100, 700));
    pos.y = int(random(100, 400));
    boolean j = true;
    while(j)
    {
      forward.x = int(random(-1.5, 1.1));
      forward.y = int(random(-1.5, 1.1));
      
      if(forward.x != 0 && forward.y != 0)
      {
        j = false;
      }
    }
  }
  
  void update()
  {
    pos.add(forward);
  }

  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(100);
    ellipse(0, 0, crw, crw);
    fill(255);
    popMatrix();
  }
}
