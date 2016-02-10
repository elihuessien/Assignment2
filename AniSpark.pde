class AniSpark extends GO
{
  float theta2;
  int points;
  int lineno;
  float circle_points, theta, radius;
  int cx, cy, i=1;
  float x, y;
  float lastx=0, lasty=0;
  
  int j;

  AniSpark(float x, float y)
  {
    j = 0;
    theta = 0;
    theta2 = 0;
    points = 5;
    lineno = points*2;
    circle_points = (TWO_PI/lineno);
    radius = 10;
    
    pos.x = x;
    pos.y = y;
  }
  
  void update()
  {
    theta2+= 0.005;
    
    if(theta2 == TWO_PI)
    {
      j=0;
    }
  }

  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta2);
    fill(100);
    
    for(theta=0; theta<=(TWO_PI+1); theta+=circle_points)
    {
      if(i % 2 == 0)
      {
        x = sin(theta)*radius/2;
        y = cos(theta)*radius/2;
      }
      else
      {
        x = sin(theta)*radius;
        y = cos(theta)*radius;
      }
      
      if(lastx!=0)
      {
        line(cx+lastx,cy+lasty,cx+x,cy+y);
      }
      i++;
      lastx=x;
      lasty=y;
    }
    
    fill(255);
    popMatrix();  
  }
}
