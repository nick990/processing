import java.util.Random;
import java.text.DecimalFormat;



public ArrayList<Tile> getFlattenTree(ArrayList<Tile> firstLevel){
    ArrayList<Tile> flattenTree = new ArrayList<Tile>(); 
    for(Tile t:firstLevel)
      flattenTree.addAll(t.getFlattenTree());
    return flattenTree;
}

public void orderFlattenTree(ArrayList<Tile> tiles){
  for(int i=0;i<tiles.size();i++){
    for(int j=i+1;j<tiles.size();j++){
                Tile t_i = tiles.get(i);
                Tile t_j = tiles.get(j);                
                if(t_i.layer>t_j.layer){
                    Tile aux=t_i.clone();
                    tiles.set(i,t_j);
                    tiles.set(j,aux);
                }
      }
  }
}

PImage img;
int[][] avgColors;
PImage[][] imagesGrid;
int PADDING = Constants.TILE_SIZE/2;

public String getFileName(){
  return Constants.ROWS+"x"+Constants.COLS+"_tsize"+Constants.TILE_SIZE+"_th"+Constants.SPLIT_THRESHOLD+"_mintsize"+Constants.MIN_TILE_SIZE+"_indexes"+MyUtils.ArrayIntToString(Constants.TILES_INDEXES_VALID)+".png";
};

ArrayList<Tile> generate(){  
  ArrayList<Tile> tree = new ArrayList<Tile>();
  for(int r=0;r<Constants.ROWS;r++){
    for(int c=0;c<Constants.COLS;c++){
      PImage bgImage = imagesGrid[r][c];
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t = new Tile(r,c,imageIndex,negative,0,0,0,bgImage);
      t.generateSubTree();
      tree.add(t);
    }
  }
  ArrayList<Tile> flattenTree = getFlattenTree(tree);
  orderFlattenTree(flattenTree);
  return flattenTree;
}

void randomize(int size){
  TileProviderSingleton.getInstance().generateRandomIndexes(size);
  // Constants.SPLIT_THRESHOLD=new Random().nextInt(70)+20;
}

void settings(){
  img = loadImage("images/ermellino.jpeg");
  img.filter(GRAY);
  double imgRatio = (double)img.width/(double)img.height;
  Constants.ROWS = (int)(Constants.COLS/imgRatio);
  int treeWidth = (int)((Constants.COLS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  int treeHeigth = (int) ((Constants.ROWS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  // Constants.WIDTH = Constants.COLS*Constants.TILE_SIZE;
  // Constants.HEIGHT = Constants.ROWS*Constants.TILE_SIZE;
  Constants.WIDTH=treeWidth+PADDING*2;
  Constants.HEIGHT=treeHeigth+PADDING*2;
  setSize(Constants.WIDTH, Constants.HEIGHT);
  smooth(Constants.SMOOTH);  
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  avgColors = MyUtils.getAvgColorGrid(img,Constants.ROWS,Constants.COLS);
  imagesGrid = MyUtils.getSubimagesGrid(img,Constants.ROWS,Constants.COLS);
  Constants.init(this);
}
void draw() {
  // int offsetX = Constants.WIDTH/2-treeWidth/2;
  // int offsetY = Constants.HEIGHT/2-treeHeigth/2;
  background(255);
  translate(PADDING,PADDING);
 
    for(int j=0;j<20;j++){
      randomize(-1);
      println(j+" "+getFileName());
      ArrayList<Tile> tree = generate();
      for(int i=0;i<tree.size();i++){
        Tile t = tree.get(i);
        if(i%100==0)
          println((i+1)+"/"+tree.size());
        t.drawTree();
      }
      println("saving...");
      save("out/"+j+"_"+getFileName());
      println("saved");
    }
  
  exit();
}
