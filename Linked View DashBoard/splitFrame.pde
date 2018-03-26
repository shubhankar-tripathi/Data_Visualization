class SplitFrame extends Frame{
  int u0,v0,w,h,colr;
  SplitFrame(int u,int v,int wd,int ht,int colr){
    u0 = u;
    v0 = v;
    w = wd;
    h = ht;
    this.colr= colr;
  }  
  void draw(){
    stroke(0);
    fill(colr);
    rect(u0,v0,w,h);
  }
  void mouseClicked(){
  }
  boolean mouseIn(){
    if((u0 < mouseX) && ((u0 + w) > mouseX) && (v0< mouseY) && ((v0 + h) > mouseY)){
      return true;
    }
    else{return false;}
  }  
}