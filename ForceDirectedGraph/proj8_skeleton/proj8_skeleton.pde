import java.util.*;
Frame myFrame = null;
String dataPathnodes = "data_miserables/nodes.csv";
String dataPathlinks = "data_miserables/links.csv";
void setup() {
  size(1000, 1000); 
  getdata();
}


void getdata(){
  
  ArrayList<GraphVertex> verts = new ArrayList<GraphVertex>();
  ArrayList<GraphEdge>   edges = new ArrayList<GraphEdge>();


  // TODO: PUT CODE IN TO LOAD THE GRAPH 
  Table table_nodes = new Table(dataPathnodes);
  Table table_links = new Table(dataPathlinks);
  
  for(int j=0; j<table_nodes.getRowCount(); j++){
	GraphVertex vert = new GraphVertex(table_nodes.getString(j,0), table_nodes.getInt(j,1), random(300,700), random(300,700));
    verts.add(vert);
  }
  for(int j=0; j<table_links.getRowCount(); j++){
    GraphVertex source = null;
    GraphVertex target = null;
    for(int k=0; k<verts.size(); k++){
		if(verts.get(k).getID().equals(table_links.getString(j,0))) source = verts.get(k);
        if(verts.get(k).getID().equals(table_links.getString(j,1))) target = verts.get(k);
    }
    GraphEdge edge = new GraphEdge(source, target, table_links.getInt(j,2)); 
    edges.add(edge);
  }

    myFrame = new ForceDirectedLayout( verts, edges );
}



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

// =========================================================================


class Table {
  int rowCountLocal;
  String[][] data;
  
  Table(String filename) {
    String[] rows = loadStrings(filename);
    
    data = new String[rows.length][];
    rowCountLocal = 0;
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }
      // split the row on the tabs
      String[] pieces = split(rows[i], ',');
      // copy to the table array
      data[rowCountLocal] = pieces;
      rowCountLocal++;
    }
  }
  
  int getRowCount() {
    return rowCountLocal;
  }
  
  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }
  
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }
  
  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }
}
