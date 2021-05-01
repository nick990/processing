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


public String getFileName(){
  return "out/"+Constants.ROWS+"x"+Constants.COLS+"_tsize"+Constants.TILE_SIZE+"_lv"+Constants.LEVELS+".png";
};

ArrayList<Tile> generate(int rows,int cols, int x, int y){  
  ArrayList<Tile> tree = new ArrayList<Tile>();
  for(int r=0;r<rows;r++){
    for(int c=0;c<cols;c++){ 
      int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
      boolean negative=false;
      Tile t = new Tile(r,c,imageIndex,negative,0,x,y);
      tree.add(t);
      int depth = new Random().nextInt(Constants.LEVELS+1);
      t.split(depth);
    }
  }
  ArrayList<Tile> flattenTree = getFlattenTree(tree);
  orderFlattenTree(flattenTree);
  return flattenTree;
  }


void settings(){
  setSize(Constants.WIDTH, Constants.HEIGHT);
  smooth(Constants.SMOOTH);  
}

void setup() {
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  Constants.init(this);
}
void draw() {
  background(0);
  int treeWidth = (int)((Constants.COLS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  int treeHeigth = (int) ((Constants.ROWS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
  int offsetX = Constants.WIDTH/2-treeWidth/2;
  int offsetY = Constants.HEIGHT/2-treeHeigth/2;
  ArrayList<Tile> tree = generate(Constants.ROWS,Constants.COLS,offsetX,offsetY);
  for(int i=0;i<tree.size();i++){
    Tile t = tree.get(i);
    println((i+1)+"/"+tree.size());
    t.drawTree();
  }
  save(getFileName());
  exit();
}
