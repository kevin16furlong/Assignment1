/*
Used for playing music. didnt get it working
import ddf.minim.*;

Minim minim;
*/

//useful variables
  PVector pos;
  PVector forward;
  float theta = 0.0f;
  float w;
  float halfW;
  float speed = 5.0f;
  float X=50;
  float Y =50;
  //AudioPlayer audio;
  
// arrayfor holding data
ArrayList<Songs> songs = new ArrayList<Songs>();
ArrayList<Temp> data = new ArrayList<Temp>();

String [] years ={"1900","1910","1920","1930","1940","1950","1960","1970","1980","1990","2000","2010"};

float border;
float min, max, minc,maxc;

//set up the program

void setup()
{
 size(500, 500);
 loadData();
 calcMinMax();
 border = width * 0.1f;
 songs = new ArrayList<Songs>();
 Love love= new Love();
 
 //minim = new Minim(this);
 
 //textMode(SHAPE);
 color[] colors = new color[data.size()];
 
}// end setup


//code to check keys
void keyPressed() // used fortaking input form numbers
{
 if (key >= '0' && key <='5')
  {
    mode = key - '0';
  }
  println(mode);
 /* int k = key - '0';  
  
  if (k >= 0 && k < songs.size())
  {
    songs.get(k).speak();
  }
  */
}

//code for sounds
/*void speak()
  {
    audio.rewind();
    audio.play();
    
  }*/


// Code forloading data
void loadData()
{
  String[] lines = loadStrings("NewYorkTemp.csv");
  for(String line: lines)
  {
    Temp temp = new Temp(line);
    data.add(temp);
  }
}//end load data

// option 1
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
  minc = maxc = data.get(0).cold; 
  for (Temp temp:data)
  {
    if (temp.cold < minc)
    {
      minc = temp.cold;
    }
    if (temp.cold > maxc)
    {
      maxc = temp.cold;
    }    
  }
}

// option 1 continued
void drawLineGraph()
{
  stroke(255);
   
  
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);
  
  
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(255, 0, 0);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).hot, min, max, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).hot, min, max, height - border, border);
    line(x1, y1, x2, y2);
    
 
  }  
}
//option2
void drawLineGraphC()
{
  stroke(255);
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);
  
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(0, 0, 255);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).cold, minc, maxc, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).cold, minc, maxc, height - border, border);
    line(x1, y1, x2, y2);
  }  
}

// graphic line to follow graph
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
void drawTempCold()
{
  if (mouseX >= border && mouseX <= width - border)
  {
    stroke(0, 0, 255);
    fill(0, 0, 255);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    float y = map(data.get(i).cold, minc, maxc, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text("Year: " + data.get(i).year, mouseX + 10, y+20);
    text("Temprature: " + data.get(i).cold, mouseX + 10, y + 30);
  }
}

int mode = 0;

color randomColor()
{
  return color(random(0, 255), random(0, 255), random(0, 255));
}

void draw()
{
  background(0);
  
   switch (mode)
  {    
    case 0:
      fill(255,255,255);
      stroke(255,255,255);
      text("Hi and welcome to kevs project\n",X,Y);
      text("please choose an option between 0 & 4\n",X,Y+20);    
      
      
      for (int i = 0 ; i < data.size() ; i ++)
      {
        float x = i * border;
        fill(randomColor());
        stroke(randomColor());
        rect(x, data.get(i).hot+(height/2), Y , - (data.get(i).hot));
      }  
      break;
    case 1:
    {
       text("Graph to show the warm weather differences in NYC frmo 1900-2015\n",X,Y);
       drawLineGraph();
       drawTemphot();
      break;
    }      
  case 2:
  {
      text("Graph to show the cold weather differences in NYC frmo 1900-2015\n",X,Y);
      drawLineGraphC();
      drawTempCold();
      
      break;
  }  
   
    case 3:
    {
      drawLineGraphC();
      drawLineGraph();
      drawTempCold();
      drawTemphot();
      
      break;  
    } 
    
    case 4:
   {
               
          for(int i=0;i<data.size();i++)
          {
          println(data.get(i).year, ", " , data.get(i).cold, ", " ,data.get(i).hot, ".");
           
          stroke(255,0,0);
          ellipse(X+100, Y+100,data.get(i).hot*5,data.get(i).hot*5);
          
          stroke(0,0,255);          
          ellipse(X+300, Y+300,data.get(i).cold*10,data.get(i).cold*10);
          
          }
          
          for(int i = songs.size() - 1 ; i >= 0   ;i --)
          {
            if(i==5)
            {
              break;
            }
            else
            {
            Songs go = songs.get(i);
            go.update();
            go.render();
            }
          } 
          
            if (frameCount %180 ==0)
            {
             Songs love = new Love();
             songs.add(love);
             
            }
           
        
       
     
     break;
    }
    
    
    case 5:
    {
    float temp;
    float j = Y+60;
    int YEAR;
    int COLD;
    int HOT;
    //fill in some graph
    text("Year,   TempCold, TempHot",X,j-20);
    for(int i = 0 ; i < data.size();i++)
    {
      
     j+=10;
     YEAR=(int)data.get(i).year;
     COLD=(int)data.get(i).cold;
     HOT=(int)data.get(i).hot;
     
      
      text(YEAR ,X,j); 
      text(COLD,X+60,j);
      text(HOT, X+120,j);
    }
      
      break;  
    }
    default:
    {
      text("error please press 0-4 only", X,Y+40);
    }
  }
    
   
  
}
