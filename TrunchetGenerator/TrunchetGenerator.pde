import java.util.Random;

int PADDING = Constants.TILE_SIZE/2;
int MAX_LEVEL=4;
int mosaic_width = (int)((Constants.COLS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
int mosaic_height = (int) ((Constants.ROWS-1)*(Constants.TILE_SIZE*(1-2.0*Constants.TILE_PADDING_RATIO))+Constants.TILE_SIZE);
int w=mosaic_width+PADDING*2;
int h=mosaic_height+PADDING*2;
ArrayList<Tile> tiles;
void setup() {
  println("image: "+w+" x "+h);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  TileProviderSingleton.init(this);
  MyUtils.init(this);
  //size(3199,3199, SVG, "out.svg");
 size(3100,3100);
 smooth(8);
  tiles = new ArrayList<Tile>();
    for(int r=0;r<Constants.ROWS;r++){
      for(int c=0;c<Constants.COLS;c++){ 
        int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
        boolean negative=false;
        tiles.add(new Tile(r,c,imageIndex,negative,0,0,0));
      }
  }

  
  for(int i=0;i<MAX_LEVEL-1;i++){
    println("Generating level "+i+"...");
    ArrayList<Tile> newTiles = new ArrayList<Tile>();
    for(Tile t:tiles){
        if(new Random().nextDouble()>0.7){
            newTiles.addAll(t.split());
        }else{
            newTiles.add(t);
        }
    }
    tiles=newTiles;
  }

  println("Reordering...");
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
void draw() {
  println("Drawing...");
  background(255);
  translate(PADDING,PADDING);  
  for(Tile t : tiles){
  // for(int l=0;l<t.layer;l++)
  //   print("\t");
  // println("["+t .r+","+t.c+"]");
    t.draw();
  }

  // Exit the program
 save("out.png");
 println("Finished.");
  
 exit();
}
