
Frame myFrame = null;
Table table;
boolean click = false;

void setup(){
  size(600,600);  
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    
    ArrayList<Integer> useColumns = new ArrayList<Integer>();
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    myFrame = new Splom( table, useColumns );
    
    
    
  }
}


void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
  if( myFrame != null ){
       myFrame.setPosition( 0, 0, width, height );
       if (click!=true) myFrame.draw();
       else myFrame.mouseReleased();
       
  }
}
void mouseReleased(){
  click = true;
}

abstract class Frame {
  
  int u0,v0,w,h;
     int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
  void mouseReleased(){ }
  
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}