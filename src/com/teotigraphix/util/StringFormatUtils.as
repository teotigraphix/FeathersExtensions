/**
 * Created by Teoti on 3/19/2015.
 */
package com.teotigraphix.util
{

public class StringFormatUtils
{
    private static var LEVELS:Array = [
        'bytes', 'Kb', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'
    ];

    public static function bytesToString(bytes:Number):String
    {
        var index:uint = Math.floor(Math.log(bytes) / Math.log(1024));
        return (bytes / Math.pow(1024, index)).toFixed(2) + LEVELS[index];
    }

    public static function formatCurrentTime(beat:int, bpm:Number):String
    {
        var minutesDecimal:Number = beat / int(bpm);
        var minutes:int = int(minutesDecimal);
        var seconds:int = int((minutesDecimal - int(minutesDecimal)) * 60);
        var sSeconds:String = seconds.toString();
        if (seconds < 10)
            sSeconds = "0" + seconds;
        return minutes + ":" + sSeconds;
    }
}
}
