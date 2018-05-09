
JSONObject values;
Frame myFrame = null;
final int CANVAS_WIDTH_DEFAULT  = 1000;
final int CANVAS_HEIGHT_DEFAULT = 600;
String dataPath = "Data_Visulaization/Force Directed Graph/data.csv";
void setup() {
  //size(1000, 1000); 
  int canvasWidth = CANVAS_WIDTH_DEFAULT;
  int canvasHeight = CANVAS_HEIGHT_DEFAULT;
  size(canvasWidth, canvasHeight);
  //selectInput("Select a file to process:", "fileSelected");
}

/*void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } 
  else*/
  void getdata(){
    println("User selected " + /*selection.getAbsolutePath()*/ dataPath);

    ArrayList<GraphVertex> verts = new ArrayList<GraphVertex>();
    ArrayList<GraphEdge>   edges = new ArrayList<GraphEdge>();


    // TODO: PUT CODE IN TO LOAD THE GRAPH    
    values = loadJSONObject(/*selection.getAbsolutePath()*/dataPath);
    JSONArray nodes = values.getJSONArray("nodes");
    JSONArray links = values.getJSONArray("links");
    print(nodes.size()); 
    for(int j=0; j<nodes.size(); j++){
      JSONObject vertObj = nodes.getJSONObject(j); 
      GraphVertex vert = new GraphVertex(vertObj.getString("id"), vertObj.getInt("group"), random(300,700), random(300,700));
      verts.add(vert);
    }
    print(verts.size());
    for(int j=0; j<links.size(); j++){
      JSONObject edgeObj = links.getJSONObject(j);
      GraphVertex source = null;
      GraphVertex target = null;
      for(int k=0; k<verts.size(); k++){
        if(verts.get(k).getID().equals(edgeObj.getString("source"))) source = verts.get(k);
        if(verts.get(k).getID().equals(edgeObj.getString("target"))) target = verts.get(k);
      }
      GraphEdge edge = new GraphEdge(source, target, edgeObj.getFloat("value")); 
      edges.add(edge);
    }

    myFrame = new ForceDirectedLayout( verts, edges );
  }
//}


void draw() {
  colorMode(RGB,255);
  background( 255 );

  if ( myFrame != null ) {
    myFrame.setPosition( 0, 0, width, height );
    myFrame.draw();
  }
}

void mousePressed() {
  myFrame.mousePressed();
}

void mouseReleased() {
  myFrame.mouseReleased();
}

abstract class Frame {

  int u0, v0, w, h;
  int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  abstract void draw();
  
  void mousePressed() { }
  void mouseReleased() { }

  boolean mouseInside() {
    return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY;
  }
  
}
