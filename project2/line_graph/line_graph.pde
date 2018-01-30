String[] lines = null;
float y1 = 0;
float y2 = 0;
void setup(){
  size(600,600);  
  selectInput("Select a file to process:", "fileSelected");
  background(138);
  while(lines==null){
    print();
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
      float x1 = 50 + (500/7)*(i) - 0.7*(500/7);
      float x2 = x1 + 0.35*(500/7);
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
      stroke(0);
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
    line(10, 550, 550, 550);
    text("> YEAR", 545, 554);
    line(10, 550, 10, 50);
    text("^", 7, 56);
    text("VALUE0", 7, 45);
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