import java.util.Random;
class Tile{
  //coordinate nella finestra
  int x,y;
  //offset definito dal padre
  int offsetX,offsetY;
  //dimensione della tile
  //calcolata da Constants.TILE_SIZE e layer
  private int size;
  // riga,colonna nella griglia
  int r,c;
  // index dell'immagine della tile
  int tileImageIndex;
  // immagine della tile
  private PImage image;
  // colore
  color bgColor;
  //indica se usare la tile negatica o positiva
  boolean negative;
  //livello nella window (z index) 0 è il più basso
  int layer;

  ArrayList<Tile> children;

  Tile(int r, int c,int tileImageIndex,boolean negative,int layer,int offsetX,int offsetY){
    this.r=r;
    this.c=c;
    this.tileImageIndex=tileImageIndex;
    this.negative=negative;
    this.layer=layer;
    this.size=MyUtils.getSizeFromLayer(this.layer);
    this.offsetX=offsetX;
    this.offsetY=offsetY;
    this.x=(int)(c*(size*(1-2*Constants.TILE_PADDING_RATIO)))+offsetX;
    this.y=(int)(r*(size*(1-2*Constants.TILE_PADDING_RATIO)))+offsetY;
    this.bgColor=MyUtils.getColorFromPositionInWindow(x+size/2,y+size/2);
    this.image = TileProviderSingleton.getInstance().getImageByIndex(this.tileImageIndex,this.negative);
    this.children = new ArrayList<Tile>();
  }
  void draw(){
    tint(this.bgColor);
    image(this.image,x,y,this.size,this.size);
  }

  void drawTree(){
    if(this.children.size()>0){
      for(Tile c : children){
        c.drawTree();
      }
    }else{
      this.draw();
    }
  }

  void split(int depth){
    if(depth>=1){
      for(int rr=0;rr<2;rr++){ 
        for(int cc=0;cc<2;cc++){
          int childrenImageIndex=TileProviderSingleton.getInstance().getRandomIndex();
          int childOffsetX=(int)(x+size*Constants.TILE_PADDING_RATIO/2);
          int childOffsetY=(int)(y+size*Constants.TILE_PADDING_RATIO/2);
          Tile child =new Tile(rr,cc,childrenImageIndex,!negative,layer+1,childOffsetX,childOffsetY); 
          this.children.add(child);
        }
      }
      depth--;
      for(Tile c : this.children){
        c.split(depth);
      }
    }   
  }

  ArrayList<Tile> getFlattenTree(){
    ArrayList<Tile> tree=new ArrayList<Tile>();
    if(this.children.size()==0){
      tree.add(this.clone());
    }else{
      for( Tile t : this.children){
        tree.addAll(t.getFlattenTree());
      }
    }
    return tree;
  }

  /*
   * Clona senza figli
   */
  Tile clone(){
  return new Tile(r,c,tileImageIndex,negative,layer,offsetX,offsetY);
  }
}
