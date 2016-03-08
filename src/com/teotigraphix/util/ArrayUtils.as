package com.teotigraphix.util
{
public final class ArrayUtils
{
    
    public static function toArray(vector:*):Array
    {
        var result:Array = [];
        for(var i:int = 0; i < vector.length; i++)
        {
            result[result.length] = vector[i];
        }
        return result;          
    }
}
}