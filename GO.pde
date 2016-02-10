abstract class GO
{
  int w;
  int h;
  int j;
  PVector pos;
  PVector forward;
  
  GO()
  {
    pos = new PVector(0,0);
    forward = new PVector(0, 0);
  }
  
  abstract void update();
  abstract void render();
  
}
