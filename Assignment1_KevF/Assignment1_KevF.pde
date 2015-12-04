/*float value;
float highC=0.0f, lowC=1000.0f;
float highW=0.0f, lowW=1000.0f;
int lowIndex;
int highIndex;
int start = 1900;
int count=0;
float sumH =0.00;
float sumC =0.00;
float avgH =0.00;
float avgC =0.00;
float y=1900;

ArrayList<Float> lineData = new ArrayList<Float>();
ArrayList<Float> cold =new ArrayList<Float>();
ArrayList<Float> hot =new ArrayList<Float>();
  
//array
ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>>();
  
String [] years ={"1900","1910","1920","1930","1940","1950","1960","1970","1980","1990","2000","2010"};

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
 
 //load in file
 loadData();
 
}



void draw()
{
  background(0);
  stroke(200, 200, 200);
  fill(200, 200, 200);
  
  linegraph();
}
  
void loadData()
{
   String[] strings = loadStrings("NewYorkTemp.csv");
   println("Year\tColdest\tHottest");
   for(int i=0;i<30;i++)  
   {
     print("-");
   }
   println("");
    
   for(String s:strings)
   {
     println(s);
     String[] line = s.split(",");
      
    
     
      
     // Start at 1, so we skip the first one 
     for (int i = 1 ; i < line.length ; i ++)
     {
       lineData.add(Float.parseFloat(line[i]));
       if(i==1)
       {
         sumC += Float.parseFloat(line[i]);
         cold.add(Float.parseFloat(line[i]));
       }
       else
       {
         sumH += Float.parseFloat(line[i]); 
        hot.add(Float.parseFloat(line[i]));     
       }
       count++;
       data.add(lineData);
     }
   }
   //calculate the average
   avgC  = sumC/count ;
   avgH  = sumH/count ;
   //change code to print year 1887-2015
  
   println("The average hot weather was ",(avgH), " \nWith average cold weather being ", (avgC), " degrees farinheight"); 
}//end load data

//code to make a line graph
void linegraph()
{
  float border = width * 0.1f;
  for(int i = 1 ; i < count ; i ++)
  {
    drawAxis(hot, years, 8, 80.0, border);
    stroke(200);
    fill(200);
           
    float windowRange = (width - (border * 2.0f));
    float dataRange = 80;      
    float lineWidth =  windowRange / (float) (years.length - 1) ;
    lineWidth = lineWidth*0.5f;    
    float scale = windowRange / dataRange;
    
    for (int in = 1 ; in< hot.size()-1 ; in ++)
      {
        float x1 = border + ((in - 1) * (lineWidth));
        float x2 = border + (in  * (lineWidth));
        float y1 = (height) - (hot.get(in- 1));
        float y2 = (height) - (hot.get(in));
        line(x1, y1, x2, y2);
      }  
    }
  }


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
  
    
  for (int i = 0 ; i < data.size(); i +=2)
  {
    // Draw the ticks
    float x = border + (i * horizInterval);
    line(x, height - (border - tickSize), x, (height - border));
    float textY = height - (border * 0.5f);
   
     // Print the text 
     textAlign(CENTER, CENTER);
   
     text(horizLabels[j].substring(0, 4), x, textY);
     j++;
       
  }//end for
  
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
  }// end for 
  
   if(mouseX <450 && mouseX>50 && mouseY <450 && mouseY>50)
  {
    stroke(255,0,0);
    fill(0,255,0);
    //line(mouseX,y1,mouseX,y);
   
        ellipse(mouseX,mouseY,20,20);
        print(hot,years);
    
    
  }
}//end draw axis
/*

// draw a graph border
void drawAxis()
{
   stroke(255);
   fill(255);
   float x,x1;
   float y,y1;
   x1=50;
   x=450;
   y1=50;
   y=450;
   line(x1,y,x,y);
   line(x1,y1,x1,y);
   
   if(mouseX <450 && mouseX>50 && mouseY <450 && mouseY>50)
  {
    stroke(255,0,0);
    fill(0,255,0);
    line(mouseX,y1,mouseX,y);
 
    ellipse(mouseX,mouseY,20,20);
    println(mouseX,mouseY);
  }
//}*/

void setup()
{
 size(500, 500);
 loadData();
 calcMinMax();
 border = width * 0.1f;
 
}

// Question 2
ArrayList<Temp> data = new ArrayList<Temp>();

float border;
float min, max;

// Question 3
void loadData()
{
  String[] lines = loadStrings("NewYorkTemp.csv");
  for(String line: lines)
  {
    Temp temp = new Temp(line);
    data.add(temp);
  }
}

// Question 4
void calcMinMax()
{
  min = max = data.get(0).hot; 
  for (Temp temp:data)
  {
    if (temp.hot < min)
    {
      min = temp.hot;
    }
    if (temp.hot > max)
    {
      max = temp.hot;
    }    
  }
}

// Question 4 continued
void drawLineGraph()
{
  stroke(255);
   
  
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);
  
  
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(0, 255, 255);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).hot, min, max, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).hot, min, max, height - border, border);
    line(x1, y1, x2, y2);
    
    // Another way to solve Question 5
    /*
    if (mouseX >= x1 && mouseX <= x2)
    {      
      stroke(255, 0, 0);
      fill(255, 0, 0);
      line(x1, border, x1, height - border);
      ellipse(x1, y1, 5, 5);
      fill(255);
      text("Year: " + data.get(i - 1).year, x1 + 10, y1);
      text("GDP (Mill$): " + data.get(i - 1).amount, x1 + 10, y1 + 10);
    } 
    */
  }  
}

// Question 5
void drawTemphot()
{
  if (mouseX >= border && mouseX <= width - border)
  {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    float y = map(data.get(i).hot, min, max, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text("Year: " + data.get(i).year, mouseX + 10, y);
    text("Temprature: " + data.get(i).hot, mouseX + 10, y + 10);
  }
}

void draw()
{
  background(0);
  drawLineGraph();
  drawTemphot();
}
