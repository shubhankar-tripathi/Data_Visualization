import java.lang.Math;
Table table;
Frame myFrame = null;
boolean drawLabels = true;
boolean click = false;
float lowBound = 0;
float upBound = 0;


void setup(){
  size(800, 400); 
  selectInput("Select a file to process:", "fileSelected");
}


void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
  if( myFrame != null ){
       myFrame.draw();
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Selected window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    
     for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
      }
      else{
        println( i + " - type string" );
      }
    }
    myFrame = new Frame(0,0,width,height);
  }
}

class Frame {
  
  int u0,v0,w,h;
  int border = 40;
  int spacer = 20;
  int rectW = 15;
  
  Frame(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w  = w;
    this.h  = h;
  }
  
  void draw(){
    stroke(0,255,255);
    fill(0,255,255);
    rect(10, 5, 90, 20,7);
    stroke(0);
    fill(0);
    textSize(12);
    text("Swap Axes +/-",12,17);
    for( int i = 0; i < table.getRowCount(); i++ ){
        float clr = map(i+1, 0, table.getRowCount(), 0, 255);
        TableRow r = table.getRow(i);
        float x0 = 0;
        float y0 = 0;
        for( int j=0; j< table.getColumnCount();j++){
          float minCol = min(table.getFloatColumn(j));
          float maxCol = max(table.getFloatColumn(j));
          lowBound = v0+h-border-spacer;
          upBound = v0+border+spacer;
          if(mouseX<100&&mouseX>10&&mouseY<25&&mouseY>5&&mouseClicked()){
           float k  = lowBound;
           lowBound = upBound;
           upBound = k;
          }
          float y = map( r.getFloat(j), minCol, maxCol, lowBound, upBound );
          float x = map(j,0,table.getColumnCount()-1, u0+border+spacer, u0+w-border-spacer);
          stroke(50,55,100,1);
          fill(50,55,100,1);
          rect(x-5, v0+border+spacer, 10, v0+h-2*border-2*spacer);
          stroke(0);
          line(x, u0+border, x, v0+h-border);
          stroke(0);
          fill(0);
          textSize(10);
          text(Float.toString(minCol), x-30, lowBound);
          text(Float.toString(maxCol), x-30, upBound);
          
          //  drawing data points
          stroke( 0 );
          fill(0,168,168);
          ellipse(x,y,4,4);
          if(j!=0){
            stroke(clr/2,11*clr/20,2*clr/3);
            line(x0,y0,x,y);
          }
          x0 = x;
          y0 = y;
          
          // point tracing
          if (Math.pow(mouseX - x,2) + Math.pow(mouseY - y,2) < 16.0){
          stroke(0);
          fill(280);
          rect(x-10,y-40,70,30);
          stroke(0);
          fill(0);
          textSize(12);
          text(r.getFloat(j), x-5, y-20);
        }
          
          // draw labels
          if( drawLabels ){
            textSize(14);
            fill(0);
            text( table.getColumnTitle(j), x-10, v0+h-20);

          }
      }
        
     }
     
   
  }
boolean mouseClicked(){
  if(mouseX<100&&mouseX>10&&mouseY<25&&mouseY>5&&mousePressed){
           return true;
          }
  return false;
}
  
}