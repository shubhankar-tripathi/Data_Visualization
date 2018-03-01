import java.util.Collections;
import java.util.ArrayList;
String[] lines = null;
String axisName =null;
int numCol = 4;
int y = 0;
ArrayList<ArrayList<Float>> list = new ArrayList<ArrayList<Float>>();
ArrayList<Float> aL_satm = new ArrayList<Float>();
ArrayList<Float> aL_satv = new ArrayList<Float>();
ArrayList<Float> aL_act = new ArrayList<Float>();
ArrayList<Float> aL_gpa = new ArrayList<Float>();
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
    aL_satm.add(satmScore);
    aL_satv.add(satvScore);
    aL_act.add(actScore);
    aL_gpa.add(gpaScore);    
  }
  list.add(aL_satm);
  list.add(aL_satv);
  list.add(aL_act);
  list.add(aL_gpa);
  
//  numCol = tests.length;
  for(int k=0; k<numCol; k++){
    for(int j=0; j<numCol; j++){
      y=j;
      stroke(0);
      fill(280,280,280);
      rect(50+j*(width-100)/numCol,50 + k*(height-100)/numCol, (width-100)/numCol, (height-100)/numCol);
      if(k!=j) plot(list.get(k),list.get(j),k,j);
    }
    drawScales(tests);
  }
noLoop();
}

void drawScales(String[] tests){
  for(int i=0; i<numCol; i++){
    for(int j=0; j<4; j++){
    fill(0,0,0);
    textSize(8);
    text("|", 55+(j+1)*((width-100)/numCol-10)/4+i*(width-100)/numCol, 50);
    text(Float.toString((j+1)*Collections.max(list.get(i))/5) , 55+(j+1)*((width-100)/numCol-10)/4+i*(width-100)/numCol, 40);
    text(tests[i], 50+(width-100)/(2*numCol)+i*(width-100)/numCol, 20);
    text("-", 50, 55+(j+1)*((height-100)/numCol-10)/4+i*(height-100)/numCol);
    text(Float.toString((j+1)*Collections.max(list.get(i))/5) , 27, 55+(j+1)*((height-100)/numCol-10)/4+i*(height-100)/numCol);
    pushMatrix();
    translate(5,50+(width-100)/(2*numCol)+ i*(height-100)/numCol);
    rotate(-HALF_PI);
    text(tests[i], 0,0);
    popMatrix();
    }
    }
}
void plot(ArrayList<Float> p, ArrayList<Float> q,int k,int j){
  for(Float obj : p){
    int index = p.indexOf(obj);
    stroke(0,0,280);
    ellipse(55+obj*((width-100)/numCol-10)/Collections.max(p)+j*(width-100)/numCol,  55+q.get(index)*((height-100)/numCol-10)/Collections.max(q)+ k*(height-100)/numCol,0.5,0.5);
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