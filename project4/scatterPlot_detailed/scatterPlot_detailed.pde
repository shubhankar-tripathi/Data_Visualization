import java.lang.Math;
Table table;
Frame myFrame = null;
boolean drawLabels = true;


void setup(){
  size(800, 600); 
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
  float minX, maxX;
  float minY, maxY;
  
  Frame(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w  = w;
    this.h  = h;
    minX = min(table.getFloatColumn(0));
    maxX = max(table.getFloatColumn(0));
  
    minY = min(table.getFloatColumn(1));
    maxY = max(table.getFloatColumn(1));
  }
  int clickBuffer = 2;
  
  void draw(){
    for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(1), minY, maxY, v0+h-border-spacer, v0+border+spacer );
        
        stroke( 0 );
        fill(255,0,0);
        ellipse( x,y,3,3 );
        if (Math.pow(mouseX - x,2) + Math.pow(mouseY - y,2) < 9.0){
          stroke(0);
          noFill();
          rect(x-10,y-40,90,30);
          stroke(0);
          fill(0);
          textSize(12);
          text(r.getFloat(0)+", "+r.getFloat(1), x-5, y-20);
        }
     }
     
     stroke(0);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);
     
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(0), u0+width/2, v0+height-10 );
       pushMatrix();
       translate( u0+10, v0+height/2 );
       rotate( PI/2 );
       text( table.getColumnTitle(1), 0, 0 );
       popMatrix();
     }
   
  }
  void mousePressed(){ }
  
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}