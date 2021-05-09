import java.util.Random;
class Tile{
  //coordinate nella finestra
  int x,y;
  //offset definito dal padre
  int offsetX,offsetY;
  //dimensione della tile
  //calcolata da Globals.TILE_SIZE e layer
  private int size;
  // riga,colonna nella griglia
  int r,c;
  // index dell'immagine della tile
  int tileImageIndex;
  // immagine della tile
  private PImage image;
  // colore di BG
  color bgColor;
  // immagine di BG
  private PImage bgImage;
  private color bgImageColor;
  //indica se usare la tile negatica o positiva
  boolean negative;
  //livello nella window (z index) 0 è il più basso
  int layer;

  ArrayList<Tile> children;

  Tile(int r, int c,int tileImageIndex,boolean negative,int layer,int offsetX,int offsetY,PImage bgImage){
    this.r=r;
    this.c=c;
    this.tileImageIndex=tileImageIndex;
    this.negative=negative;
    this.layer=layer;
    this.size=MyUtils.getSizeFromLayer(this.layer);
    this.offsetX=offsetX;
    this.offsetY=offsetY;
    this.x=(int)(c*(size*(1-2*Globals.TILE_PADDING_RATIO)))+offsetX;
    this.y=(int)(r*(size*(1-2*Globals.TILE_PADDING_RATIO)))+offsetY;
    this.image = TileProviderSingleton.getInstance().getImageByIndex(this.tileImageIndex,this.negative);
    this.children = new ArrayList<Tile>();
    this.bgImage = bgImage;
    if(this.bgImage != null)
      this.bgImageColor=MyUtils.getAvgColor(this.bgImage);
    this.bgColor=getColorFromPositionInMosaic(x+size/2,y+size/2);
  }

  void draw(boolean tint,VideoExport video){
    if(tint){
      if(this.bgImage!=null){
        if(this.layer>=Globals.LAYER_COLOR_TH)
          tint(this.bgImageColor);
        else{
         this.bgImage.filter(GRAY); 
         tint(MyUtils.getAvgColor(this.bgImage));
        }
      }
      else
        tint(this.bgColor);
    }
    image(this.image,x,y,this.size,this.size);
    noTint();
    if(video != null){
      if(this.layer==1)
        pauseVideo(video,20);
      else if(this.layer==2)
        pauseVideo(video,10);
      else if(this.layer==3)
        pauseVideo(video,5);
      else if(new Random().nextDouble()>0.4)
        pauseVideo(video,1);
    }
  }
  
  void draw(boolean tint){
    draw(tint, null);
  }

  void draw(){
    draw(true);
  }

  void drawTree(boolean tint,VideoExport video){
    if(this.children.size()>0){
      for(Tile c : children){
        c.drawTree(tint,video);
      }
    }else{
      this.draw(tint,video);
    }
  }
  void drawTree(boolean tint){
    drawTree(tint,null);
  }
  void drawTree(){
    drawTree(true);
  }

  void split(int depth){
    if(depth>=1){
      PImage[][] childrenBgImages=new PImage[2][2];
      if(this.bgImage!=null)
        childrenBgImages=MyUtils.getSubimagesGrid(this.bgImage,2,2);
      for(int rr=0;rr<2;rr++){ 
        for(int cc=0;cc<2;cc++){
          int childrenImageIndex=TileProviderSingleton.getInstance().getRandomIndex();
          int childOffsetX=(int)(x+size*Globals.TILE_PADDING_RATIO/2);
          int childOffsetY=(int)(y+size*Globals.TILE_PADDING_RATIO/2);
          PImage childImage=childrenBgImages[rr][cc];
          Tile child =new Tile(rr,cc,childrenImageIndex,!negative,layer+1,childOffsetX,childOffsetY,childImage); 
          this.children.add(child);
        }
      }
      depth--;
      for(Tile c : this.children){
        c.split(depth);
      }
    }   
  }

  boolean needSplit(){
    if(this.bgImage==null)
      return false;
    if(this.layer >= Globals.LEVELS-1)
      return false;
    int[][] colors = MyUtils.getAvgColorGrid(this.bgImage,2,2);
    for(int r=0;r<2;r++){
      for(int c=0;c<2;c++){
        if(MyUtils.colorDistance(this.bgImageColor,colors[r][c])>Globals.SPLIT_THRESHOLD)
          return true;
      }
    }
    return false;
  }

  void generateSubTree(){
    if(needSplit()){
      split(1);
      for(Tile t:this.children){
        t.generateSubTree();
      }
    }
  }



  /*
  * Ritorna il flatten tree della tile
  * Complete significa che mantiene tutti i livelli, altrimenti solo l'ultimo
   */
  ArrayList<Tile> getFlattenTree(boolean complete){
    ArrayList<Tile> tree=new ArrayList<Tile>();
    if(complete){
      tree.add(this.clone());
      for( Tile t : this.children){
        tree.addAll(t.getFlattenTree(true));
      }
    }else{
      if(this.children.size()==0){
        tree.add(this.clone());
      }else{
        for( Tile t : this.children){
          tree.addAll(t.getFlattenTree());
        }
      }
    }
    return tree;
  }

  ArrayList<Tile> getFlattenTree(){
    return getFlattenTree(false);
  }

  /*
   * Clona senza figli
   */
  Tile clone(){
    return new Tile(r,c,tileImageIndex,negative,layer,offsetX,offsetY,this.bgImage);
  }

  /*
   * Clona senza figli e cambiando l'immagine Tile
   */
  Tile cloneWithRandomTile(){
    int newTileImageIndex=this.tileImageIndex;
    if(Globals.TILES_INDEXES_VALID.size()>1){
      while(newTileImageIndex==this.tileImageIndex)
        newTileImageIndex = TileProviderSingleton.getInstance().getRandomIndex();
    }
    return new Tile(r,c,newTileImageIndex,negative,layer,offsetX,offsetY,this.bgImage);
  }
}
