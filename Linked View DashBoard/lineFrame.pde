import java.util.Collections;
Lineplot selectlp = null;
Frame cancelline = null;

ArrayList<Table> tables = new ArrayList<Table>();
class LineFrame extends Frame{
  int check = 0;
  int u0,v0,w,h;
  ArrayList<Lineplot> plots = new ArrayList<Lineplot>();
  int colCount;
  Table data;
  
  LineFrame(){
    this.data = table;
    colCount = useColumns.size();
    for( int j = 0; j < colCount-1; j++ ){
      for( int i = j+1; i < colCount; i++ ){
        Lineplot lp = new Lineplot( tables.get(useColumns.get(j)), useColumns.get(j), useColumns.get(i) );
        plots.add(lp);
      }
    }
  }  float border = 20;
  
  void setPosition(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;  
    h = ht;
    int curPlot = 0;
    for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
  //       Button b = n
         Lineplot lp = plots.get(curPlot++);
           
           int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
           lp.setPosition( su0, sv0, (int)(w-2*border)/(colCount-1), (int)(h-2*border)/(colCount-1) );
           lp.drawLabels = false;
           lp.border = 3;
       }
    }
  }


  void draw(){
    if(selectlp==null){
      for( Lineplot l : plots ){
        l.k=1;
        l.draw(); 
      }
      for (Lineplot l : plots){
        l.k=1;
        l.printDataPoints();
      }
    }
    else{  
      selectlp.k=4;
      selectlp.draw();
      selectlp.printDataPoints();
      cancelline = new SplitFrame(u0+selectlp.border,v0+selectlp.border,15,15,110);
      cancelline.draw();
      fill(0);
      text("<",u0+selectlp.border+2,v0+selectlp.border+12);
    }
  }


  void mouseClicked(){
    for(Lineplot l : plots) {
      if(l.mouseIn()){
        selectlp = new Lineplot(tables.get(l.idx0), l.idx0,l.idx1);
        selectlp.setPosition(u0,v0,w,h);
        selectlp.border = 50;
        selectlp.spacer = 20;
        selectlp.drawLabels = true;
      }
    }
    if(cancelline!=null&&cancelline.mouseIn()){
      selectlp=null;
      cancelline=null;
    }
  }
}


class Lineplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 20;
  int k;
  boolean drawLabels = true;
  float spacer = 5;
  Table data;
  ArrayList<Float[]> filteredData;
  ArrayList<float[]> drawPoints = null;
  Lineplot( Table data, int idx0, int idx1 ){
     
    this.idx0 = idx0;
    this.idx1 = idx1;
    this.data = data; 
    minX = min(data.getFloatColumn(idx0));
    maxX = max(data.getFloatColumn(idx0));
     
    minY = min(data.getFloatColumn(idx1));
    maxY = max(data.getFloatColumn(idx1));

     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
     data.sort(idx0);
     float x=0;
     filteredData = new ArrayList<Float[]>();
     ArrayList<Float> temp = new ArrayList<Float>();
     for(int i=0; i<data.getRowCount(); i++){
       if(i==0){
         temp.add(data.getRow(i).getFloat(idx1));
       }
       if(data.getRow(i).getFloat(idx0)==x){
         temp.add(data.getRow(i).getFloat(idx1));
       }
       if(data.getRow(i).getFloat(idx0)>x&&i!=0||i==data.getRowCount()-1){
         filteredData.add(new Float[] {data.getRow(i).getFloat(idx0),Collections.max(temp)});
         temp.clear();
         temp.add(data.getRow(i).getFloat(idx1));
       }
       x=data.getRow(i).getFloat(idx0);
     }
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
     float x1=0;
     float y1=0;
     for( int i = 0; i < filteredData.size(); i++ ){
        float x = map( filteredData.get(i)[0], minX, maxX, u0+this.border+this.spacer, u0+w-this.border-this.spacer-k );
        float y = map( filteredData.get(i)[1], minY, maxY, v0+h-this.border-this.spacer, v0+this.border+this.spacer );
        stroke(223, 159, 190);
        fill(223, 159, 190);
        if(i>0){
          line(x1,y1,x,y);
          ellipse(x1,y1,3,3);
          ellipse(x,y,3,3);
          x1 =x;
          y1 =y;          
        }
        if(i==0){
          x1 =x;
          y1 =y;
        }
     }
     if( drawLabels ){
       fill(0);
       text( data.getColumnTitle(idx0), u0+w/2, v0+h-border/2 );
       pushMatrix();
       translate( u0+border/2, v0+h/2 );
       rotate( -PI/2 );
       text( data.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
   }
   void printDataPoints(){
    for( int i = 0; i < filteredData.size(); i++ ){
      float x = map( filteredData.get(i)[0],minX, maxX, u0+border+spacer, u0+w-border-spacer-k );
      float y = map( filteredData.get(i)[1], minY, maxY, v0+h-border-spacer,v0+border+spacer );
      if (Math.pow(mouseX - x,2) + Math.pow(mouseY - y,2) < 9.0){
        stroke(0);
        fill(191);
        rect(x-10,y-40,90,30,5);
        stroke(0);
        fill(0);
        textSize(12);
        text(filteredData.get(i)[0]+", "+filteredData.get(i)[1], x-5, y-20);
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