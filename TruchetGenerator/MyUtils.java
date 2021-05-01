import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

public class MyUtils{
    private static PApplet app;

    public static void init(PApplet app){
        MyUtils.app=app;
    }
    public static int getSizeFromLayer(int layer){
        return (int)(Constants.TILE_SIZE/(Math.pow(2,layer)));
    }
    public static int getColorFromPositionInGrid(int r, int c){
        double rComponent = (double)r/(double)Constants.ROWS;
        double cComponent = c/(double)Constants.COLS;
        int red = (int)(rComponent*255);
        int  green = (int)(cComponent*255);
        return app.color(red, green, 255/2);
    }
    public static int getColorFromPositionInWindow(int x,int y){
        double xComponent = (double)x/(double)app.width;
        double yComponent = y/(double)app.height;
        int red = (int)(yComponent*255);
        int  green = (int)(xComponent*255);
        return app.color(red, green, Constants.BLUE);
    }
    public static String ArrayIntToString(ArrayList<Integer> list){
        String s="";
        for(int i:list){
            s+=i+",";
        }
        return s;
    }
}