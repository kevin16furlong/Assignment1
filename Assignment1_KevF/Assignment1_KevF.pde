
//import for gui
import controlP5.*;

//imports for music
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//controlp5 objects
ControlP5 cp5;
ControlP5 cp6;

//Declare variables related to music
Minim minim;
AudioPlayer player;
int muteValue=0;

//useful variables
  PVector pos;
  PVector forward;
  float theta = 0.0f;
  float w;
  float halfW;
  float speed = 5.0f;
  float X=50;
  float Y =50;
  int set;
  int mode = 0;
 
  
// arrayfor holding data
ArrayList<Songs> songs = new ArrayList<Songs>();
ArrayList<Temp> data = new ArrayList<Temp>();


float border;
float min, max, minc,maxc;

//set up the program

void setup()
{
 set = 0;
 size(700, 600);
 loadData();
 calcMinMax();
 border = width * 0.1f;
 
 cp5 = new ControlP5(this);
 // had implemented these but for saome reason my methods all stopped refreshing or updating when used, 
 //so reverted back to input based code
 /*  //setup cp5 buttons for navigating 
   cp5.addButton("Home").setValue(1).setPosition(20,height-40).setSize(80,20).setLabel("Line Graph");
   cp5.addButton("HotLineGraph").setValue(2).setPosition(100,height-40).setSize(80,20).setLabel("Hot Graph");
   cp5.addButton("ColdLineGraph").setValue(3).setPosition(180, height-40).setSize(80,20).setLabel("Cold Graph");
   cp5.addButton("twolineGraphs").setValue(4).setPosition(260,height-40).setSize(80,20).setLabel("Full LineGraph");
   cp5.addButton("WeatherSpirils").setValue(5).setPosition(340,height-40).setSize(80,20).setLabel("Spirils");*/
   cp5.addButton("Unmute").setValue(6).setPosition(420,height-40).setSize(80,20).setLabel("UnMute");
   cp5.addButton("Mute").setValue(7).setPosition(500,height-40).setSize(80,20).setLabel("Mute Music");/*
   cp5.addButton("printValues").setValue(8).setPosition(580, height-40).setSize(80,20).setLabel("Print Values");*/

   //set custom song to play
    minim = new Minim(this);
    //song choice picked due to data being weather in new york, and time of year of project.
    player = minim.loadFile("FairytaleOfNewYork.mp3",2048);
    player.loop();
 
 
 //textMode(SHAPE);
 color[] colors = new color[data.size()];
 
}// end setup

//code for picking random color
color randomColor()
{
  return color(random(0, 255), random(0, 255), random(0, 255));
}

//code for muteing music
void Mute()
{
   player.mute();

   
}
//code to unmute song
void Unmute()
{
  player.unmute();

}

//code to check keys
void keyPressed() // used fortaking input form numbers
{
 if (key >= '0' && key <='5')
  {
    mode = key - '0';
  }
  println(mode);
  
}

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

// calculating min and max tempratures
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

// drawing the Hot temprature line graph
void drawLineGraphHot()
{
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
    
    text(data.get(i).hot,border-60,y2);
    
     if(i % 2 == 1)
    {
      //print the odd years
      text(data.get(i).year,x1+8,height-60);
    }
    else
    {
      //print the even years
      text(data.get(i).year,x1+8,height-50);
    }
    
 
  }  
}
// drawing the cold temprature line graph
void drawLineGraphC()
{
  stroke(255);
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border );
    
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(0, 0, 255);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).cold, minc, maxc, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).cold, minc, maxc, height - border, border);
    line(x1, y1, x2, y2);
    stroke(0,0,255);
    //print the temp values
    text(data.get(i).cold,border-60,y2);
    if(i % 2 == 1)
    {
      //print the odd years
      text(data.get(i).year,x1+8,height-60);
    }
    else
    {
      //print the even years
      text(data.get(i).year,x1+8,height-50);
    }
  }  

}

//draw double line graph
void drawLineGraph()
{
  stroke(255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);
  //print values 1-80
  for (int i=0;i<90;i+=10)
  {
    //for some reason in the code the values for the cold were matching up, but the hot were not so i spaced them slightly differently so it would work out.
    if(i<30)
    {
      text(i,border-20,height-((i+10)*6));
    }
    else
    {
      text(i,border-20,height-((i+8)*6));
    }
    
  }//end print values
  
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(255, 0, 0);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).hot, 0, 80, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).hot, 0, 80, height - border, border);
    line(x1, y1, x2, y2);
    //print years    
     if(i % 2 == 1)
    {
      text(data.get(i).year,x1+8,height-60);
    }
    else
    {
      text(data.get(i).year,x1+8,height-50);
    }
  }
  //draw line line for cold values
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(0, 0, 255);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).cold, 0, 80, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).cold, 0, 80, height - border, border);
    line(x1, y1, x2, y2);
    stroke(0,0,255);
    
  }  //end printing cold
  
  //print both lines to give current point values
    if (mouseX >= border && mouseX <= width - border)
  {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    float y = map(data.get(i).hot, 0, 80, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text("Year: " + data.get(i).year, mouseX + 10, y);
    text("Temprature: " + data.get(i).hot, mouseX + 10, y + 10);
  }
   if (mouseX >= border && mouseX <= width - border)
  {
    stroke(0, 0, 255);
    fill(0, 0, 255);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    float y = map(data.get(i).cold, 0, 80, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text("Year: " + data.get(i).year, mouseX + 10, y+20);
    text("Temprature: " + data.get(i).cold, mouseX + 10, y + 30);
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
//graphic line to follow cold graph
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
}//end graphic lines for graphs

void draw()
{
  if(set==0)
  {
    
    Home();
  }
  switch(mode)
  {
    case 0:
    {
      Home();
      break;
    }
    case 1:
    {
      HotLineGraph();
      break;
    }
    case 2:
    {
      ColdLineGraph();
      break;
    }
    case 3:
    {
      twolineGraphs();
      break;
    }
    case 4:
    {
      WeatherSpirils();
      break;
    }
    case 5:
    {
      printValues();
      break;
    }
    
  }
}
             
//print home screen
void Home()
{
  
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  text("Hi and welcome to kevs project",X,Y);
  text("Please choose options of input 0-5",X,Y+20);
  set=1;
  for (int i = 0 ; i < data.size() ; i ++)
  {
    Float x = i * border;
    fill(randomColor());
    stroke(randomColor());
    rect(x, data.get(i).hot+(height/2), Y , - (data.get(i).hot));
  }  
}

// print Hot weather line graph
void HotLineGraph()
{
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  set=2;
  text("Graph to show the warm weather differences in NYC frmo 1900-2015\n",X,Y);
  drawLineGraphHot();
  drawTemphot();
}

//print cold weather line graph
void ColdLineGraph()
{
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  set=3;
  text("Graph to show the cold weather differences in NYC frmo 1900-2015\n",X,Y);
  drawLineGraphC();
  drawTempCold();
}
        
//print both line graphs
void twolineGraphs()
{
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  set=4;
  
  drawLineGraph();
  
}//end draw two line graphs

//print out Circles to represent weather data
void WeatherSpirils()
{
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  set=5;
  for(int i=0;i<data.size();i++)
  {
    //in this code it was just drawing circles using line data taken in
    stroke(255,0,0);
    ellipse(X+100, Y+100,data.get(i).hot*5,data.get(i).hot*5);
    stroke(0,0,255);          
    ellipse(X+300, Y+300,data.get(i).cold*10,data.get(i).cold*10);
  }
  // this code below is to print rotating objects also representing the values from the data
  //aka a random bit of fun. using code learned from game coded in class
  for(int i = songs.size() - 1 ; i >= 0   ;i --)
  {
    if(i==10)
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
   if (frameCount %60 ==0)
   {
     Songs love = new Love();
     songs.add(love);           
    }
}// end print circles
        
//print out values for weather
void printValues()
{
  background(0);
  fill(255,255,255);
  stroke(255,255,255);
  set=8;
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

    text(YEAR,X,j); 
    text(COLD,X+60,j);
    text(HOT, X+120,j);
             
   }
}//end print weather values
