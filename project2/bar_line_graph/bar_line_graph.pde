String[] lines = null;
float y1 = 0;
float y2 = 0;
void setup(){
  size(600,600);  
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
    println(lines.length);
  for (int i=1; i<lines.length; i++) {
      String[] phrases = split(lines[i],',');
      String year = phrases[0];
      float value0 = Float.valueOf(phrases[1]);
      float value1 = Float.parseFloat(phrases[2]);
      String party = phrases[3];
      rectangle rec1 = new shape();
      rectangle rec2 = new shape();
      float x1 = 50 + (500/7)*(i) - 0.7*(500/7);
      float x2 = x1 + 0.35*(500/7);
      rec1.setPosition(x1, 550-value0*50, 25, value0*50,0,168,168);
      rec2.setPosition(x2, 550-5*value1, 25, value1*5,168,168,0);
      if(i>1){
        stroke(0,0,280);
        line(50 + (500/7)*(i-1) - 0.515*(500/7), y1, x1 + 0.185*(500/7), 550-value0*50 );
        smooth();
        stroke(0,280,0);
        line(50 + (500/7)*(i-1) - 0.185*(500/7), y2, x2 + 0.185*(500/7), 550-value1*5 );
        smooth();
      }
      y1 = 550 - value0*50;
      y2 = 550 - value1*5;
      rec1.draw();
      rec2.draw();
      fill(0);
      textSize(12);
      text(year, x1+10, 575);
      text("|", x2, 554);
      ellipse(x1+0.185*(500/7),y1,5,5);
      ellipse(x2+0.185*(500/7),y2,5,5);
      textSize(8);
      text("( "+value0+", "+ party + " )", x1, y1-10); 
      text("( "+value1+", "+ party + " )", x2, y2-10);
    }
  stroke(0);
  line(50, 550, 550, 550);
  text("> YEAR", 545, 554);
  line(50, 550, 50, 50);
  text("^", 47, 56);
  text("VALUE0, VALUE1", 47, 45);
  fill(0,168,168);
  rect(535, 10, 10, 10);
  fill(0);
  text("VALUE0", 550, 20);
  fill(168,168,0);
  rect(535, 25, 10, 10);
  fill(0);
  text("VALUE1", 550, 35);
  noLoop();
    
}
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    lines = loadStrings(selection);
  }
}

abstract class rectangle {
  
  float x,y,w,h,r,g,b;
  void setPosition( float x, float y, float w, float h, int r, int g, int b){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.r=r;
    this.g=g;
    this.b=b;
  }
  
  abstract void draw();
}