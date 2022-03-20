public class Cluster {
    ArrayList<Pixel> pixels;
    Cluster(ArrayList<Pixel> pixels){
        this.pixels = pixels;
    }
    void draw(PImage image){
        color c = getAvgColor(image);
        for(Pixel p:pixels){
            set(p.x,p.y,c);
        }
    }
    color getAvgColor(PImage image){
        int redAvg=0;
        int greenAvg=0;
        int blueAvg=0;
        for(Pixel p:this.pixels){                
            int c = image.get(p.x,p.y);
            redAvg += (c >> 16 & 0xFF); 
            greenAvg += (c >> 8 & 0xFF);
            blueAvg += (c & 0xFF);            
        }
        int count = this.pixels.size();
        redAvg /= count;
        greenAvg /= count;
        blueAvg /= count;
        return color(redAvg,greenAvg,blueAvg);
    }
  
}
