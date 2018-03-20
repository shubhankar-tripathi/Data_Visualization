class SplitFrame extends Frame{
  int u0,v0,w,h;
  SplitFrame(int u,int v,int wd,int ht){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;
  }  
  void draw(){
    rect(u0,v0,w,h);
  }
  void mouseClicked(){
  }
}