class Love extends Songs
{
   //AudioPlayer audio;

 /*
 void speak()
  {
    audio.rewind();
    audio.play();
  }
  */
  
 Love()
  {
    //audio = minim.loadFile("LoveShack.mp3");
    // Constructor chaining. Call a constructor in the super class
    super(random(0,width),random(0, height), 50);  
    c = color(255,0,0);
    forward.x=random(-1,1);
    forward.y=random(-1.1);
    forward.normalize();
    
  }
  
 
 void update()
  {
    
      theta+=0.1f;
      pos.add(forward);
    
       if (pos.x < 0)
    {
      pos.x = width;
    }
    
    if (pos.x > width)
    {
      pos.x = 0;
    }
    
    if (pos.y < 0)
    {
      pos.y = height;
    }
    
    if (pos.y > height)
    {
      pos.y = 0;
    }
    
  }
  
   void render()
  {
    pushMatrix(); // reset the translation and rotation
    translate(pos.x, pos.y);
    rotate(theta); // We want rotate to happen first, so you make the call AFTER translate  
    stroke(c);
    fill(0);  
    for(int i=0;i<data.size();i++)
    {
      if(i%2==0){
        stroke(c);
        ellipse(-halfW, data.get(i).hot,data.get(i).hot,w);
      }else{
        stroke(0,0,255);
        ellipse(-halfW,-halfW, data.get(i).cold,data.get(i).cold);
      }
    }
    popMatrix();
  }  
}
