class ClustersManager{
    ArrayList<Cluster> clusters;
    //Immagine che tiene traccia dei pixel già clusterizzati
    PImage img;
    color CLUSTERED_COLOR = color(255,255,255);
    color NOT_CLUSTERED_COLOR = color(0,0,0);
    ClustersManager(){
        this.clusters = new ArrayList<Cluster>();
        this.img = createImage(Globals.WIDTH, Globals.HEIGHT,RGB);
        int dimension = Globals.WIDTH * Globals.HEIGHT;
        this.img.loadPixels();
        for (int i = 0; i < dimension; i ++) { 
            this.img.pixels[i] = NOT_CLUSTERED_COLOR; 
        } 
        this.img.updatePixels();
    }
    //Aggiunge un cluster al manager
    public void add(Cluster cluster){
        this.clusters.add(cluster);
        for(Pixel pixel:cluster.pixels){
            this.img.set(pixel.x,pixel.y,CLUSTERED_COLOR);
        }
    }
    //Ritorna true se il pixel è già stato clusterizzato
    boolean isPixelAlreadyInCluster(Pixel pixel){
        color pixelColor = (int)this.img.get(pixel.x,pixel.y);
        return (pixelColor == CLUSTERED_COLOR);
    }
    void draw(PImage image){
        for(int i=0;i<clusters.size();i++){
            Cluster c = clusters.get(i);
            println((i+1)+"/"+clusters.size());
            c.draw(image);
            }
        // for(Cluster c:clusters){
        //     c.draw(image);
        // }
    }
}
