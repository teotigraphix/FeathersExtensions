/**
 * Created by Teoti on 3/23/2015.
 */
package com.teotigraphix.util
{

public final class MathUtils
{
    public static function randomIntRange(start:Number, end:Number):int
    {
        return int(randomNumberRange(start, end));
    }

    public static function randomNumberRange(start:Number, end:Number):Number
    {
        end++;
        return Math.floor(start + (Math.random() * (end - start)));
    }

}
}
