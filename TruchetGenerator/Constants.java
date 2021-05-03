import processing.core.*;
import java.util.ArrayList;

public class Constants{
    private static PApplet app;
    public static ArrayList<Integer> TILES_INDEXES_VALID;
    public static void init(PApplet app){
        Constants.app=app;
        Constants.TILES_INDEXES_VALID=new ArrayList<Integer>();
        Constants.TILES_INDEXES_VALID.add(0);
        Constants.TILES_INDEXES_VALID.add(4);
        Constants.TILES_INDEXES_VALID.add(9);
        Constants.TILES_INDEXES_VALID.add(7);
        Constants.TILES_INDEXES_VALID.add(10);
        Constants.TILES_INDEXES_VALID.add(13);
    }
    public static double TILE_PADDING_RATIO=1.0/5.0;
    public static int TILE_SIZE=500;
    public static int COLS=15;
    public static int ROWS=15;
    public static int CORNER=3;
    public static int LEVELS=2;
    public static Double SPLIT_RATE = 0.2;
    public static int BLUE=255/2;
    public static int SMOOTH=8;
    public static int WIDTH=200;
    public static int HEIGHT=200;
    public static int SPLIT_THRESHOLD=40;
    public static int MIN_TILE_SIZE=20;

}