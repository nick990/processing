
    public void pauseVideo(VideoExport video, int framesCount){
        for(int i=0;i<framesCount;i++)
            video.saveFrame();
    }
    public String getFileName(){
        String datetime = year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second(); 
        return datetime+"_"+Globals.ROWS+"x"+Globals.COLS+"_lv"+Globals.LEVELS+"_tsize"+Globals.TILE_SIZE+"_rate"+nf((float)Globals.SPLIT_RATE,1,2)+"_color"+nf((float)Globals.COLOR_FACTOR,1,2)+"_indexes"+MyUtils.ArrayIntToString(Globals.TILES_INDEXES_VALID);
      }

    public int getColorFromPositionInWindow(int x,int y){
        double xComponent = (double)x/((double)width*Globals.COLOR_FACTOR);
        double yComponent = y/((double)height*Globals.COLOR_FACTOR);
        int red = (int)(yComponent*255);
        int  green = (int)(xComponent*255);
        return color(red, green, Globals.BLUE);
    }

