class Pixel{
    int x,y;
    
    Pixel(int x,int y){
        this.x = x;
        this.y = y;
    }
    
    public boolean isEqual(Pixel other){
        return (this.x == other.x && this.y == other.y);
    }
}