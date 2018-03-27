Parallelplot pp=null;
float lowBound,upBound;
boolean swap = false;
class ParallelFrame extends Frame{
  int u0,v0,w,h;
  int border = 50;
  int spacer = 20;

  void setPosition(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;
    pp = new Parallelplot(u0,v0,w,h);
  }
  void draw(){
    if(swap!=true){
      lowBound = v0+h-border-spacer;
      upBound = v0+border+spacer;
    }
    if(swap==true){
      lowBound = v0+border+spacer;
      upBound = v0+h-border-spacer;
    }
    pp.draw();
    pp.printDataPoints();
  }
  void mouseClicked(){
    if(mouseX<u0+100&&mouseX>u0+10&&mouseY<v0+30&&mouseY>v0+10){
      swap = !swap;
    }
  }
}


class Parallelplot extends Frame{
  int u0,v0,w,h;
  int rectW = 15;  
  boolean drawLabels = true;
  float clr=0;  
  Parallelplot(int u0,int v0,int w, int h){
    this.u0=u0;
    this.v0=v0;
    this.w=w;
    this.h=h;
  }
  void draw(){
    stroke(0);
    fill(191);
    rect(u0+10, v0+10, 90, 20,7);
    fill(0);
    textSize(12);
    text("Swap Axis +/-",u0+12,v0+25);
    fill(255);
    rect(u0+border,v0+border,w-2*border,h-2*border,5);
    for(int i=0; i<table.getColumnCount(); i++){
      float x = map(i,0,table.getColumnCount()-1, u0+border+spacer, u0+w-border-spacer);
      stroke(110,110,110,1);
      fill(110,110,110,1);
      rect(x-5, v0+border, 10, v0+h-2*border);
      stroke(0);
      line(x, v0+border+spacer, x, v0+h-border-spacer );
    }
    for( int i = 0; i < table.getRowCount(); i++ ){
      TableRow r = table.getRow(i);
      float x0 = 0;
      float y0 = 0;
      for( int j=0; j < table.getColumnCount();j++){
        float minCol = min(table.getFloatColumn(j));
        float maxCol = max(table.getFloatColumn(j));
        float y = map( r.getFloat(j), minCol, maxCol, lowBound, upBound );
        float x = map(j,0,table.getColumnCount()-1, u0+border+spacer, u0+w-border-spacer);
          stroke(0);
          fill(0);
          textSize(12);
          if(i==0){
            if(swap==false){
              text(Float.toString(minCol), x-14, lowBound+14);
              text(Float.toString(maxCol), x-14, upBound-7);
            }
            if(swap==true){
              text(Float.toString(minCol), x-14, lowBound-7);
              text(Float.toString(maxCol), x-14, upBound+14);              
            }
          }
          //  drawing data points
          stroke( 0 );
          fill(223, 159, 190);
          ellipse(x,y,4,4);
          if(j!=0){
            stroke(223, 159, 190);
            line(x0,y0,x,y);
          }
          x0 = x;
          y0 = y;
          
          
          // draw labels
          if( drawLabels && i==0 ){
            textSize(12);
            stroke(0);
            fill(0);
            text( table.getColumnTitle(j), x-10, v0+h-20);

          }
      }
        
     }
     
       
     

  }
  //trace datapoints
  void printDataPoints(){
    for( int i = 0; i < table.getRowCount(); i++ ){
      TableRow r = table.getRow(i);
      for( int j=0; j< table.getColumnCount();j++){
        float minCol = min(table.getFloatColumn(j));
        float maxCol = max(table.getFloatColumn(j));
        float y = map( r.getFloat(j), minCol, maxCol, lowBound, upBound );
        float x = map(j,0,table.getColumnCount()-1, u0+border+spacer, u0+w-border-spacer);
        if (Math.pow(mouseX - x,2) + Math.pow(mouseY - y,2) < 16.0){
          stroke(0);
          fill(191);
          rect(x-10,y-40,70,30,7);
          fill(0);
          textSize(12);
          text(r.getFloat(j), x-5, y-20);
        }
      }
    }
  }

}