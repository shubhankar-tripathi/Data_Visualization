Barplot selectbp = null;
Frame cancelbar = null;
class BarFrame extends Frame{
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
  //       Button b = n
         Barplot bp = plots.get(curPlot++);
           
           int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
           bp.setPosition( su0, sv0, (int)(w-2*border)/(colCount-1), (int)(h-2*border)/(colCount-1) );
           bp.drawLabels = false;
           bp.border = 3;
       }
    }
  }
  BarFrame(){
    this.data = table;
    colCount = useColumns.size();
    for( int j = 0; j < colCount-1; j++ ){
      for( int i = j+1; i < colCount; i++ ){
        Barplot bp = new Barplot( table, useColumns.get(j), useColumns.get(i) );
        plots.add(bp);
      }
    }
  }
  ArrayList<Barplot> plots = new ArrayList<Barplot>();
  int colCount;
  Table data;
  float border = 20;
  void draw(){
    if(selectbp==null){
      for( Barplot b : plots ){
        b.k=1;
        b.draw(); 
      }
      for (Barplot b : plots){
        b.k=1;
        b.printDataPoints();
      }
    }
    else{  
      selectbp.k=4;
      selectbp.draw();
      selectbp.printDataPoints();
      cancelbar = new SplitFrame(u0+selectbp.border,v0+selectbp.border,15,15,110);
      cancelbar.draw();
      fill(0);
      text("<",u0+selectbp.border+2,v0+selectbp.border+12);
    }
  }
  


  void mouseClicked(){
    for(Barplot s : plots) {
      if(s.mouseIn()){
        selectbp = new Barplot(table, s.idx0,s.idx1);
        selectbp.setPosition(u0,v0,w,h);
        selectbp.border = 50;
        selectbp.spacer = 20;
        selectbp.drawLabels = true;
      }
    }
    if(cancelbar!=null&&cancelbar.mouseIn()){
      selectbp=null;
      cancelbar=null;
    }
  }
}


class Barplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 20;
  int k;
  boolean drawLabels = true;
  float spacer = 5;
  Barplot( Table data, int idx0, int idx1 ){
     
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
     rect( u0+this.border,v0+this.border, w-2*this.border, h-2*this.border,5);
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        float x = map( r.getFloat(idx0), minX, maxX, u0+this.border+this.spacer, u0+w-this.border-this.spacer-k );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-this.border-this.spacer, v0+this.border+this.spacer );
        
        stroke(238,130,238);
        fill(238,130,238);
        rect(x,y,k,v0+h-this.border-this.spacer-y);
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
      float x = map( r.getFloat(idx0),minX, maxX, u0+border+spacer, u0+w-border-spacer-k );
      float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer,v0+border+spacer );
      if (mouseX>x&&mouseX<x+k&&mouseY>y&&mouseY<v0+h-border-spacer){
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