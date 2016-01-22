class Ball extends GO
{
  int crw = 30;
  String name;
  int score;
  int gravity = 0;
  int thrust = 12;
  int j = 0;
  float theta = 0;
  
  Ball()
  {
    name = "No name";
    score = 0;
    pos.x = 200;
    pos.y = height/2;
    forward.x = 0;
    forward.y = 0;
  }
  
  void update()
  {
    if(j == 1)
    {
      //animating jump with respect to gravity :P
      forward.y = -(thrust - (gravity));
      
      //terminal velocity
      if(gravity<40)
      {
        gravity += 1;
      }
    }
    else
    {
      if(j == 0)
      {
        forward.y = 0;
      }
      else
      {
        forward.y = +gravity;
      }
    }
    
    theta += 0.2;
    pos.add(forward);
  }

  
  void render()
  {
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(theta);
    ellipse(0, 0, crw, crw);
    stroke(255, 0, 0);
    line(0, -crw/2, 0, crw/2);
    theta+= 0.02;
    
    rotate(theta);
    stroke(155, 0, 0);
    line(0, -crw/2, 0, crw/2);
    theta+= 0.02;
    
    rotate(theta);
    stroke(55, 0, 0);
    line(0, -crw/2, 0, crw/2);
    
    popMatrix();
  }
}
