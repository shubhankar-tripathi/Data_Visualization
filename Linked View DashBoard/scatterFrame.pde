Scatterplot detailed = null;
SplitFrame cancel=null;
class ScatterFrame extends Frame{
  int check = 0;
  int u0,v0,w,h;
  void setPosition(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;
    int curPlot = 0;
    for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
          Scatterplot sp = plots.get(curPlot++);
           int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
           sp.setPosition( su0, sv0, (int)(w-2*border)/(colCount-1), (int)(h-2*border)/(colCount-1) );
           sp.drawLabels = false;
           sp.border = 3;
       }
    }
  }
  ScatterFrame(){
    this.data = table;
    colCount = useColumns.size();
    for( int j = 0; j < colCount-1; j++ ){
      for( int i = j+1; i < colCount; i++ ){
        Scatterplot sp = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
        plots.add(sp);
      }
    }
  }
  ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
  int colCount;
  Table data;
  float border = 20;
  void draw(){
    if(detailed==null){
      for( Scatterplot s : plots ){
        s.draw(); 
      }
      for (Scatterplot s : plots){
        s.printDataPoints();
      }
    }
    else{  
      detailed.draw();
      detailed.printDataPoints();
      cancel = new SplitFrame(u0+detailed.border,v0+detailed.border,15,15,110);
      cancel.draw();
      fill(0);
      text("<",u0+detailed.border+2,v0+detailed.border+12);
    }
  }
  


  void mouseClicked(){
    for(Scatterplot s : plots) {
      if(s.mouseIn()){
        detailed = new Scatterplot(table, s.idx0,s.idx1);
        detailed.setPosition(u0,v0,w,h);
        detailed.border = 50;
        detailed.spacer = 50;
        detailed.drawLabels = true;
      }
    }
    if(cancel!=null&&cancel.mouseIn()){
      detailed=null;
      cancel=null;
    }
  }
}





class Scatterplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  
    Scatterplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
   }
  int u0, v0, w, h;
  
  void setPosition(int u0, int v0, int w, int h){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
   void draw(){
     stroke(0);
     fill(255);
     rect( u0+border,v0+border, w-2*border, h-2*border,5);
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer, v0+border+spacer );
        
        stroke(238,130,238);
        fill(238,130,238);
        ellipse( x,y,3,3 );
     }
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(idx0), u0+w/2, v0+h-border/2 );
       pushMatrix();
       translate( u0+border/2, v0+h/2 );
       rotate( -PI/2 );
       text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
   }
   void printDataPoints(){
    for( int i = 0; i < table.getRowCount(); i++ ){
      TableRow r = table.getRow(i);
      float x = map( r.getFloat(idx0),minX, maxX, u0+border+spacer, u0+w-border-spacer );
      float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer,v0+border+spacer );
      if (Math.pow(mouseX - x,2) + Math.pow(mouseY - y,2) < 9.0){
        stroke(0);
        fill(110);
        rect(x-10,y-40,90,30,5);
        stroke(0);
        fill(0);
        textSize(12);
        text(r.getFloat(idx0)+", "+r.getFloat(idx1), x-5, y-20);
      }
    }
  }
   boolean mouseIn(){
    if((u0 < mouseX) && ((u0 + w) > mouseX) && (v0< mouseY) && ((v0 + h) > mouseY)){
      return true;
    }
    else{return false;}
  }
  
}