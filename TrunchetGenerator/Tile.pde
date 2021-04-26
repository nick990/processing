class Tile{
  int x,y,size,r,c,imageIndex;
  color col;
  PImage image;
  TileProvider tileProvider;
  boolean negative;
  double paddingRatio;
  int layer;
  int offsetX,offsetY;
  Tile(int r, int c, int size,double paddingRatio,color col,int imageIndex,boolean negative,TileProvider tileProvider,int layer,int offsetX,int offsetY){
    this.r=r;
    this.c=c;
    this.size=size;
    this.x=(int)(c*(size*(1-2*paddingRatio)))+offsetX;
    this.y=(int)(r*(size*(1-2*paddingRatio)))+offsetY;
    this.col=col;
    this.paddingRatio=paddingRatio;
    this.imageIndex=imageIndex;
    this.tileProvider=tileProvider;
    this.negative=negative;
    this.image = this.tileProvider.getImageByIndex(this.imageIndex,this.negative);
    this.layer=layer;
    this.offsetX=offsetX;
    this.offsetY=offsetY;
  }
  void draw(){
    tint(this.col);
   image(this.image,x,y,this.size,this.size);
  }
  
 ArrayList<Tile> split(){
     ArrayList<Tile> children=new ArrayList<Tile>();
      for(int rr=0;rr<2;rr++){
          for(int cc=0;cc<2;cc++){
              //var childOffsetX=this.x+size*paddingRatio/2
              //var childOffsetY=this.y+size*paddingRatio/2
              int childrenImageIndex=tileProvider.getRandomIndex();
                int childOffsetX=(int)(x+size*paddingRatio/2);
                int childOffsetY=(int)(y+size*paddingRatio/2);
              Tile child =new Tile(rr,cc,size/2,paddingRatio,col,childrenImageIndex,!negative,tileProvider,layer+1,childOffsetX,childOffsetY); 
              children.add(child);
          }
      }
      return children;
  }
  Tile clone(){
  return new Tile(r,c,size,paddingRatio,col,imageIndex,negative,tileProvider,layer,offsetX,offsetY);
  }
}
