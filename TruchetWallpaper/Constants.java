import processing.core.*;
import java.util.ArrayList;

public class Constants{
    private static PApplet app;
    public static ArrayList<Integer> TILES_INDEXES_VALID;
    public static void init(PApplet app){
        Constants.app=app;
        Constants.TILES_INDEXES_VALID=new ArrayList<Integer>();
    }
    public static int WIDTH=1440;
    public static int HEIGHT=3040;
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int COLS=8;
    public static int ROWS=3;
    public static int TILE_SIZE=300;    
    public static int CORNER=3;
    public static int LEVELS=2;
    public static Double SPLIT_RATE = 0.46;
    public static int BLUE=255/2;
    public static int SMOOTH=8;

}