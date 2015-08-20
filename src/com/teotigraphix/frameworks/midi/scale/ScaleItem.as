/**
 * Created by Teoti on 3/15/2015.
 */
package com.teotigraphix.frameworks.midi.scale
{

public class ScaleItem
{
    private var _scaleID:int;
    private var _name:String;
    private var _matrix:Vector.<int>;

    private var _chromaticMatrix:Vector.<int>;

    public function get scaleID():int
    {
        return _scaleID;
    }

    public function get name():String
    {
        return _name;
    }

    public function get label():String
    {
        return _name;
    }

    public function get matrix():Vector.<int>
    {
        return _matrix;
    }

    //public function get chromaticMatrix():Vector.<int>
    //{
    //    return _chromaticMatrix;
    //}

    public function ScaleItem(scaleID:int,
                              name:String = null,
                              matrix:Vector.<int> = null,
                              chromaticMatrix:Vector.<int> = null)
    {
        _scaleID = scaleID;
        _name = name;
        _matrix = matrix;
        _chromaticMatrix = chromaticMatrix;
    }
}
}
