class Tile{
  //coordinate nella finestra
  int x,y;
  //offset definito dal padre
  int offsetX,offsetY;
  //dimensione della tile
  //calcolata da Constants.TILE_SIZE e layer
  private int size;
  // riga,colonna nella griglai
  int r,c;
  // index dell'immagine della tile
  int imageIndex;
  // immagine della tile
  private PImage image;
  // colore
  private color bgColor;
  //indica se usare la tile negatica o positiva
  boolean negative;
  //livello nella window (z-index) 0 è il basso
  int layer;
  Tile(int r, int c,int imageIndex,boolean negative,int layer,int offsetX,int offsetY){
    this.r=r;
    this.c=c;
    this.imageIndex=imageIndex;
    this.negative=negative;
    this.layer=layer;
    this.size=MyUtils.getSizeFromLayer(this.layer);
    this.offsetX=offsetX;
    this.offsetY=offsetY;
    this.x=(int)(c*(size*(1-2*Constants.TILE_PADDING_RATIO)))+offsetX;
    this.y=(int)(r*(size*(1-2*Constants.TILE_PADDING_RATIO)))+offsetY;
    this.bgColor=MyUtils.getColorFromPoitionInWindow(x+size/2,y+size/2);
    this.image = TileProviderSingleton.getInstance().getImageByIndex(this.imageIndex,this.negative);
  }
  void draw(){
    tint(this.bgColor);
    image(this.image,x,y,this.size,this.size);
  }
  
 ArrayList<Tile> split(){
     ArrayList<Tile> children=new ArrayList<Tile>();
      for(int rr=0;rr<2;rr++){
          for(int cc=0;cc<2;cc++){
              int childrenImageIndex=TileProviderSingleton.getInstance().getRandomIndex();
              int childOffsetX=(int)(x+size*Constants.TILE_PADDING_RATIO/2);
              int childOffsetY=(int)(y+size*Constants.TILE_PADDING_RATIO/2);
              Tile child =new Tile(rr,cc,childrenImageIndex,!negative,layer+1,childOffsetX,childOffsetY); 
              children.add(child);
          }
      }
      return children;
  }
  Tile clone(){
  return new Tile(r,c,imageIndex,negative,layer,offsetX,offsetY);
  }
}
