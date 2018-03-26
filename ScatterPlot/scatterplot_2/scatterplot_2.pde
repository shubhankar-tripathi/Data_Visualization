import java.util.Collections;
import java.util.ArrayList;
String[] lines = null;
String axisName =null;
float y1 = 0;
float y2 = 0;
ArrayList<Float> arrayList_xAxis = new ArrayList<Float>();
ArrayList<Float> arrayList_yAxis = new ArrayList<Float>();
void setup(){
  size(800, 600); 
  selectInput("Select a file to process:", "fileSelected");
  background(138);
  try{
    while(lines==null){
      Thread.sleep(10000);
    }
  }
  catch(InterruptedException e){
  e.printStackTrace();
  }
}

void draw(){
  String[] tests = split(lines[0],',');
  for(int i=1; i<lines.length; i++){
    String[] line = split(lines[i],',');
    float satmScore = Float.valueOf(line[0]);
    float satvScore = Float.valueOf(line[1]);
    float  actScore = Float.valueOf(line[2]);
    float  gpaScore = Float.valueOf(line[3]);
    arrayList_xAxis.add(actScore);
    arrayList_yAxis.add(gpaScore);
    
  }
  drawAxes(tests[2],tests[3]);
  drawScales();
  plot();
}

void drawAxes(String xAxis, String yAxis){
  stroke(0);
  fill(0);
  //draw x -axis
  line(50, height-50, width-50, height-50);
  textSize(12);
  text("> "+ xAxis, width-55, height-46);
  //draw  y-axis
  line(50, height-50, 50, 50);
  textSize(12);
  text("^ "+ yAxis, 47, 55);
  noLoop();
}
void drawScales(){
  fill(0);
  for(int k=0; k<5; k++){
    text("|", 50+(k+1)*(width-150)/5, height-46);
    text(Float.toString((k+1)*Collections.max(arrayList_xAxis)/5) , 45+(k+1)*(width-150)/5, height-20);
    text("-", 50, height-50-(k+1)*(height-150)/5);
    text(Float.toString((k+1)*Collections.max(arrayList_yAxis)/5) , 15, height-50-(k+1)*(height-150)/5);
  }
}
void plot(){
  for(Float obj : arrayList_xAxis){
    int index = arrayList_xAxis.indexOf(obj);
    ellipse(50+obj*(width-150)/Collections.max(arrayList_xAxis),height-50-arrayList_yAxis.get(index)*(height-150)/Collections.max(arrayList_yAxis),2,2);
  }
}
void fileSelected(File selection) {
  if (selection == null) {
    println("Selected window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    lines = loadStrings(selection);
  }
}