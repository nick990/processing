import processing.core.*;
import processing.data.*;
import java.util.ArrayList;
import java.util.Random;
import java.lang.Math.*;

public class MyUtils{
    private static PApplet app;

    public static void init(PApplet app){
        MyUtils.app=app;
    }
    public static int getSizeFromLayer(int layer){
        return (int)(Globals.TILE_SIZE/(Math.pow(2,layer)));
    }
    public static int getColorFromPositionInGrid(int r, int c){
        double rComponent = (double)r/(double)Globals.ROWS;
        double cComponent = c/(double)Globals.COLS;
        int red = (int)(rComponent*255);
        int  green = (int)(cComponent*255);
        return app.color(red, green, 255/2);
    }
    public static int getColorFromPositionInWindow(int x,int y){
        double xComponent = (double)x/((double)app.width*Globals.COLOR_FACTOR);
        double yComponent = y/((double)app.height*Globals.COLOR_FACTOR);
        int red = (int)(yComponent*255);
        int  green = (int)(xComponent*255);
        return app.color(red, green, Globals.BLUE);
    }
    public static String ArrayIntToString(ArrayList<Integer> list){
        String s="";
        for(int i:list){
            s+=i+",";
        }
        return s;
    }
    public static int[][] getAvgColorGrid(PImage img, int rows, int cols){
        int[][] grid = new int[rows][cols];
        int cellW=img.width/cols;
        int cellH=img.height/rows;
        for(int r=0;r<rows;r++){
            for(int c=0;c<cols;c++){
                int xStart=c*cellW;
                int xEnd=Math.min(img.width,xStart+cellW);
                int yStart=r*cellH;
                int yEnd=Math.min(img.height,yStart+cellH);
                int redAvg=0;
                int greenAvg=0;
                int blueAvg=0;
                int count=0;

                for(int x=xStart;x<xEnd;x++){
                    for(int y=yStart;y<yEnd;y++){
                        int color = img.get(x,y);
                        redAvg += (color >> 16 & 0xFF); 
                        greenAvg += (color >> 8 & 0xFF);
                        blueAvg += (color & 0xFF);
                        count++;
                    }
                }
                redAvg /= count;
                greenAvg /= count;
                blueAvg /= count;
                int avg=app.color(redAvg,greenAvg,blueAvg);
                grid[r][c]=avg;
            }
        }
        return grid;
    }

    public static PImage[][] getSubimagesGrid(PImage image,int rows, int cols){
        PImage[][] grid = new PImage[rows][cols];
        int cellW=image.width/cols;
        int cellH=image.height/rows;
        for(int r=0;r<rows;r++){
            for(int c=0;c<cols;c++){
                int xStart=c*cellW;
                int xEnd=Math.min(image.width,xStart+cellW);
                int width = xEnd-xStart;
                int yStart=r*cellH;
                int yEnd=Math.min(image.height,yStart+cellH);
                int height = yEnd-yStart;
                grid[r][c]=image.get(xStart,yStart,width,height);
            }
        }
        return grid;
    }

    public static int getAvgColor(PImage image){
        int redAvg=0;
        int greenAvg=0;
        int blueAvg=0;
        int count=image.width*image.height;
        for(int x=0;x<image.width;x++){
            for(int y=0;y<image.height;y++){
                int color = image.get(x,y);
                redAvg += (color >> 16 & 0xFF); 
                greenAvg += (color >> 8 & 0xFF);
                blueAvg += (color & 0xFF);
            }
        }
        redAvg /= count;
        greenAvg /= count;
        blueAvg /= count;
        return app.color(redAvg,greenAvg,blueAvg);
    }

    public static int colorDistance(int color1, int color2){
        int sum1=(color1 >> 16 & 0xFF)+(color1 >> 8 & 0xFF)+(color1 & 0xFF);
        int sum2=(color2 >> 16 & 0xFF)+(color2 >> 8 & 0xFF)+(color2 & 0xFF);
        // app.println(Math.abs(sum1-sum2));
        return Math.abs(sum1-sum2);
    }

    public static String getFileName(){
        String datetime = app.year()+"-"+app.month()+"-"+app.day()+"-"+app.hour()+"-"+app.minute()+"-"+app.second(); 
        return datetime+"_"+Globals.ROWS+"x"+Globals.COLS+"_lv"+Globals.LEVELS+"_tsize"+Globals.TILE_SIZE+"_rate"+Globals.SPLIT_RATE+"_color"+Globals.COLOR_FACTOR+"_indexes"+MyUtils.ArrayIntToString(Globals.TILES_INDEXES_VALID);
      };
      
}