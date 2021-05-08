
    public static void pauseVideo(VideoExport video, int framesCount){
        for(int i=0;i<framesCount;i++)
            video.saveFrame();
    }
