static Table table;
Frame frame;
Frame plot;
int border = 50;
int spacer = 20;
boolean selected = false;

BarFrame bf = null;
LineFrame lf = null;
ParallelFrame pf = null;
ScatterFrame sf = null;
ArrayList<Integer> useColumns = new ArrayList<Integer>();
void setup(){
 size(1200,800);
 selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    
    selected =true;
    
  }
}


void draw(){
 background(110);
 if(selected){
   ArrayList<SplitFrame> frames = new ArrayList<SplitFrame>( );
   ArrayList<Frame> plot = new ArrayList<Frame>();
   sortFill();
   bf = new BarFrame();
   lf = new LineFrame();
   pf = new ParallelFrame();
   sf = new ScatterFrame();
   plot.add(bf);
   plot.add(lf);
   plot.add(pf);
   plot.add(sf);
   int numPlots = 4;// number of plots
   int k = 0;
   for(int j=0; j<numPlots/2; j++){
     for(int i=0; i<numPlots/2; i++){
       int u0 = (int)map(i,0,numPlots/2,border,width-border);
       int v0 = (int)map(j,0,numPlots/2,border,height-border);
       int w = (width-2*border)/2;
       int h = (height-2*border)/2;
       stroke(0);
       int colr = 255;
       frame = new SplitFrame(u0,v0,w,h,colr);
       frames.add((SplitFrame)frame);
       plot.get(k).setPosition(u0,v0,w,h);
       k++;
     }
   }
   // draw big_frame
   for(SplitFrame f : frames) f.draw();
   plot.get(0).draw();
   plot.get(1).draw();
   plot.get(2).draw();
   plot.get(3).draw();
 
 }
}

void mouseClicked(){
  bf.mouseClicked();
  lf.mouseClicked();
  sf.mouseClicked();
  pf.mouseClicked();
}
void sortFill(){
  if(tables.size()<=3){
    for(int i=0; i<table.getColumnCount()-1;i++){
      table.sort(i);
      tables.add(table);
    }
  }
}
abstract class Frame{
  int x0, y0, w, h;
  
  void setPosition(int x0, int y0, int w, int h){
    this.x0 = x0;
    this.y0 = y0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
  void mouseClicked(){}
  
  boolean mouseIn(){
    if((x0 < mouseX) && ((x0 + w) > mouseX) && (y0< mouseY) && ((y0 + h) > mouseY)){
      return true;
    }
    else{return false;}
  }
}