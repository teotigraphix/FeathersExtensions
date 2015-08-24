/**
 * Created by Teoti on 4/21/2015.
 */
package com.teotigraphix.util
{

public final class ColorUtils
{
    public static function rgbToHex(r:int, g:int, b:int):uint
    {
        var hex:uint = r << 16 | g << 8 | b;
        return hex;
    }
}
}
