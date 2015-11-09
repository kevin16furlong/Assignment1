  float value;
  float high=0.0f, low=1000.0f;
  int lowIndex;
  int highIndex;
  int start = 1850;
  int count=0;
  float sum =0.00;
  float avg=0.00;
  float y=1850;
  
  String [] years ={"1900","1910","1920","1930","1940","1950","1960","1970","1980","1990","2000","2010"};
  // float[] rainfall;
color randomColor()
{
  return color(random(0, 255), random(0, 255), random(0, 255));
}

  
void setup()
{
    background(0);
    size(500, 500);
    fill(255);
  String fsval;
  
  ArrayList<Float> arrList=new ArrayList<Float>();

 //load in file
 String[] lines=loadStrings("NewYorkTemp.csv");
 for(String s:lines)
  {
    fsval=s;
    float fval= Float.parseFloat(fsval);
    arrList.add(fval);
  }
  
  for( int  i=0;i<arrList.size();i++)
  {
    count++;
    sum+=arrList.get(i);
  
     if(arrList.get(i)>high)
     {
       high=arrList.get(i); 
       highIndex=i;
     }
     if(arrList.get(i)<low)
     {
       low=arrList.get(i);
       lowIndex=i;
     }
  }
 /* //calculate the average
  avg= sum/count;
  //change code to print year 1887-2015

  println("Dryist year was ",(start+lowIndex), " With ", low, "mm of rain"); 
  println("Wettest year was ",(start+highIndex), "With ", high, "mm of rain");
  println("the average rain over the ", count, "years was ", avg, "mm of rain");
  
  //code to make a line graph
  
  float border = width * 0.1f;
      drawAxis(arrList, years, 15, 150.0, border);
      stroke(200);
      fill(200);
      
      
      float windowRange = (width - (border * 2.0f));
      float dataRange = 150;      
      float lineWidth =  windowRange / (float) (years.length - 1) ;
      
      float scale = windowRange / dataRange;
      for (int i = 1 ; i < arrList.size() ; i ++)
      {
        float x1 = border + ((i - 1) * lineWidth);
        float x2 = border + (i * lineWidth);
        float y1 = (height - border) - (arrList.get(i - 1)) * scale;
        float y2 = (height - border) - (arrList.get(i)) * scale;
        line(x1, y1, x2, y2);
      }  
  */
}/*
void drawAxis(ArrayList<Float> data, String[] horizLabels, int verticalIntervals, float vertDataRange, float border)
{
  
  
  stroke(0,255,255);
  fill(0,255,255);  
  int j=0; 
  // Draw the horizontal azis  
  line(border, height - border, width - border, height - border);
  
  float windowRange = (width - (border * 2.0f));  
  float horizInterval =  windowRange / (data.size() - 1);
  float tickSize = border * 0.1f;
  //data.size()
    
  for (int i = 0 ; i < data.size() ; i +=16)
  {  
   
   // Draw the ticks
   float x = border + (i * horizInterval);
    line(x, height - (border - tickSize), x, (height - border));
   float textY = height - (border * 0.5f);
   
   // Print the text 
   textAlign(CENTER, CENTER);
   
   text(horizLabels[j].substring(0, 4), x, textY);
   j++;
     
   
  }
  
  // Draw the vertical axis
  line(border, border , border, height - border);
  
  float verticalDataGap = vertDataRange / verticalIntervals;
  float verticalWindowRange = height - (border * 2.0f);
  float verticalWindowGap = verticalWindowRange / verticalIntervals; 
  for (int i = 0 ; i <= verticalIntervals ; i ++)
  {
    float y = (height - border) - (i * verticalWindowGap);
    line(border - tickSize, y, border, y);
    float hAxisLabel = verticalDataGap * i;
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  } 
  
}
*/
