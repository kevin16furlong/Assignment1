class Songs
{
  PVector pos;
  PVector forward;
  float theta = 0.0f;
  float w;
  float halfW;
  float speed = 5.0f;
  color c; 
 
  
  Songs()
  {
     this(width * 0.5f, height  * 0.5f, 50);
  }
  Songs(float x, float y, float w)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, -1);
    this.w = w; // Disambiguate w by using this
    this.halfW = w * 0.5f;
    this.theta = 0.0f;
  }
  
  void update()
 {
 } 
  void render()
  {
  }

  /*
  void speak()
  {
  }  
  */
}

  

