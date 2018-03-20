class BarFrame extends Frame{
  int u0,v0,w,h;
  void setPosition(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;    
  }
  void draw(){
    SelectUI ui = new SelectUI(u0,v0,w,h);
    ui.draw();
  }
  void mouseClicked(){
  }
  
}

class SelectUI extends Frame{
  int u0,v0,w,h;
  SelectUI(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;    
  }
  
  void draw(){
    int numAxis = 2;
    for(int i=0; i<numAxis; i++){
      
    }
  }
}