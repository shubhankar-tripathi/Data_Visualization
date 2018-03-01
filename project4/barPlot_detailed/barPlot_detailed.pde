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
  int rectW = 15;
  float minX, maxX;
  float minY1, maxY1, minY2, maxY2;
  
  Frame(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w  = w;
    this.h  = h;
    minX = min(table.getFloatColumn(0));
    maxX = max(table.getFloatColumn(0));
  
    minY1 = min(table.getFloatColumn(1));
    maxY1 = max(table.getFloatColumn(1));
    
    minY2 = min(table.getFloatColumn(2));
    maxY2 = max(table.getFloatColumn(2));
  }
  
  void draw(){
    for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(0), minX, maxX, u0+border+spacer, u0+w-border-spacer-rectW );
        float y1 = map( r.getFloat(1), minY1, maxY1, v0+h-border-spacer, v0+border+spacer );
        float y2 = map( r.getFloat(2), minY2, maxY2, v0+h-border-spacer, v0+border+spacer );
        
        stroke( 0 );
        fill(0,168,168);
        rect(x-rectW/2,y1,rectW,h-border-y1);
        rect(x+rectW/2,y2,rectW,h-border-y2);
        
        if ((mouseX>x-rectW/2)&&(mouseX<x+rectW/2)&&(mouseY<h-border)&&(mouseY>y1)){
          stroke(0);
          fill(0);
          textSize(12);
          text(r.getFloat(1)+", "+r.getString(3)+", "+r.getString(0), mouseX-10, mouseY);
        }
        
        if ((mouseX>x+rectW/2)&&(mouseX<x+3*rectW/2)&&(mouseY<h-border)&&(mouseY>y2)){
          stroke(0);
          fill(0);
          textSize(12);
          text(r.getFloat(2)+", "+ r.getString(3)+", "+r.getString(0), mouseX-10, mouseY);
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
       text( table.getColumnTitle(1)+", "+ table.getColumnTitle(2)+", "+ table.getColumnTitle(3), 0, 0 );
       popMatrix();
     }
   
  }
  
  
}