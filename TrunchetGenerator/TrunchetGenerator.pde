import processing.svg.*;
import java.util.Random;

int TILE_SIZE=500;
double TILE_PADDING_RATIO = 1.0/5.0;
int COLS=10;
int ROWS=10;
int PADDING = TILE_SIZE/2;
int mosaic_width = (int)((COLS-1)*(TILE_SIZE*(1-2.0*TILE_PADDING_RATIO))+TILE_SIZE);
int mosaic_height = (int) ((ROWS-1)*(TILE_SIZE*(1-2.0*TILE_PADDING_RATIO))+TILE_SIZE);
int w=mosaic_width+PADDING*2;
int h=mosaic_height+PADDING*2;
ArrayList<Tile> tiles;
void setup() {
  println("image: "+w+" x "+h);
  println("mosaic: "+mosaic_width+" x "+mosaic_height);
  TileProviderSingleton.init(this);
  //size(3199,3199, SVG, "out.svg");
 size(3699,3699);
 smooth(8);
  tiles = new ArrayList<Tile>();
    for(int r=0;r<ROWS;r++){
      for(int c=0;c<COLS;c++){
        //println("["+r+","+c+",]");
        double rComponent = (double)r/(double)ROWS;
        double cComponent = c/(double)COLS;
        int red = (int)(rComponent*255);
        int  green = (int)(cComponent*255);
        color col = color(red, green, 255/2);
        int imageIndex=TileProviderSingleton.getInstance().getRandomIndex();
        boolean negative=false;
        tiles.add(new Tile(r,c,TILE_SIZE,TILE_PADDING_RATIO,col,imageIndex,negative,0,0,0));
      }
  }

  
  int MAX_LEVEL=3;
  for(int i=0;i<MAX_LEVEL;i++){
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
    for(int j=i+1;i<tiles.size();i++){
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
    t.draw();
  }

  // Exit the program
 save("out.png");
 println("Finished.");
  
 exit();
}
