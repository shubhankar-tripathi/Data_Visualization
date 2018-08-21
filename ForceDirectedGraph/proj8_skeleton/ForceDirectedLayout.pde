// most modification should occur in this file


class ForceDirectedLayout extends Frame {
  
  
  float RESTING_LENGTH = 15.0f;   // update this value
  float SPRING_SCALE   = 0.1f; // update this value
  float REPULSE_SCALE  = 400.0f;  // update this value
  float colorBlack = 0;
  float colorWhite = 180;

  float TIME_STEP      = 0.5f;    // probably don't need to update this

  // Storage for the graph
  ArrayList<GraphVertex> verts;
  ArrayList<GraphEdge> edges;

  // Storage for the node selected using the mouse (you 
  // will need to set this variable and use it) 
  GraphVertex selected = null;
  

  ForceDirectedLayout( ArrayList<GraphVertex> _verts, ArrayList<GraphEdge> _edges ) {
    verts = _verts;
    edges = _edges;
  }

  void applyRepulsiveForce( GraphVertex v0, GraphVertex v1 ) {
    
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A REPULSIVE FORCE
    float dx = v0.getPosition().x - v1.getPosition().x;
    float dy = v0.getPosition().y - v1.getPosition().y;
    float dist = sqrt(dx*dx + dy*dy);
    float x_ = dx / dist;
    float y_ = dy / dist;
    
    float fm = REPULSE_SCALE*(v0.getMass())*(v1.getMass())/(5*pow(dist,2));
    
    //float v0fx = fm*((v0.getPosition()).sub(v1.getPosition()).normalize().x);
    //float v0fy = fm*((v0.getPosition()).sub(v1.getPosition()).normalize().y);
    
    float v0fx = fm*x_;
    float v0fy = fm*y_;
    v0.addForce(v0fx, v0fy);
    //v1.addForce(-v0fx, -v0fy);
  }

  void applySpringForce( GraphEdge edge ) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A SPRING FORCE
    GraphVertex p = edge.v0;
    GraphVertex q = edge.v1;    
    float dx = p.getPosition().x - q.getPosition().x;
    float dy = p.getPosition().y - q.getPosition().y;
    float dist = sqrt(dx*dx + dy*dy);
    float x_ = dx/dist;
    float y_ = dy/dist;
    float L = RESTING_LENGTH;
    float Ca = SPRING_SCALE;
    
    float fm = Ca*(dist-L);
    float v0fx =  -1 * fm * x_;
    float v0fy =  -1 * fm * y_;
    
    
    edge.v0.addForce(v0fx, v0fy);
    edge.v1.addForce(-1*v0fx, -1*v0fy);
  }

  void draw() {
    update(); // don't modify this line
    
    // TODO: ADD CODE TO DRAW THE GRAPH
    for(int i = 0; i < edges.size(); i++){
      colorMode(HSB,100,100,100);
      stroke(0,0,50);
      line(edges.get(i).v0.getPosition().x, edges.get(i).v0.getPosition().y, edges.get(i).v1.getPosition().x, edges.get(i).v1.getPosition().y );
      GraphVertex p = edges.get(i).v0;
      GraphVertex q = edges.get(i).v1;
      PVector pPos = p.getPosition();
      PVector qPos = q.getPosition();
      float diam = p.getDiameter();
      stroke(p.getColor(),60,80);
      fill(p.getColor(),60,80);
      ellipse(pPos.x,pPos.y,diam/2,diam/2);
      stroke(p.getColor(),60,80);
      fill(p.getColor(),60,80);
      ellipse(qPos.x,qPos.y,diam/2,diam/2);
    }
    //Object[] arr = groups.toArray();
    int[] arr = {1,2,3,4,5,6,7,8};
    for(int i = 0; i < arr.length; i++){
      int val = (Integer)arr[i];
      float clr = map((float)val, 0, 10, 20, 80);
      colorMode(HSB, 100, 100, 100);
      stroke(clr, 60, 80);
      fill(clr, 60, 80);
      rect(10, 10*(i*5 + 1), 10, 5);
      colorMode(RGB,255);
      fill(0);
      text("Group "+ arr[i], 25, 10*(i*5 + 1)+5);
    }

  }


  void mousePressed() { 
    // TODO: ADD SOME INTERACTION CODE
    for(GraphVertex v : verts){
      if(v.getPosition().x-v.getDiameter()/2 < mouseX && v.getPosition().x+v.getDiameter()/2 > mouseX && v.getPosition().y-v.getDiameter()/2 < mouseY && v.getPosition().y+v.getDiameter()/2 > mouseY){
        selected = v;
        selected.setVelocity(0.0f,0.0f);
        selected.setPosition(mouseX, mouseY);
        selected.setVelocity(0.0f,0.0f);
        selected.clearForce();
      }
    }

  }

  void mouseReleased() {    
    // TODO: ADD SOME INTERACTION CODE
    selected = null;
  }



  // The following function applies forces to all of the nodes. 
  // This code does not need to be edited to complete this 
  // project (and I recommend against modifying it).
  void update() {
    for ( GraphVertex v : verts ) {
      v.clearForce();
    }

    for ( GraphVertex v0 : verts ) {
      for ( GraphVertex v1 : verts ) {
        if ( v0 != v1 ) applyRepulsiveForce( v0, v1 );
      }
    }

    for ( GraphEdge e : edges ) {
      applySpringForce( e );
    }

    for ( GraphVertex v : verts ) {
      v.updatePosition( TIME_STEP );
    }
  }
}
