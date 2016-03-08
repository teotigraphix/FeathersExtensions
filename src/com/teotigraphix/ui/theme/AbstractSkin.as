package com.teotigraphix.ui.theme
{
import flash.display.Sprite;

public class AbstractSkin extends Sprite
{
    private var skinWidth:Number;
    private var skinHeight:Number;
    
    override public function get width():Number
    {
        return skinWidth;
    }
    
    override public function get height():Number
    {
        return skinHeight;
    }

    public function AbstractSkin()
    {
        super();
    }
    
    public function draw():void
    {
        
    }
    
    public function setSize(width:Number, height:Number):void
    {
        skinWidth = width;
        skinHeight = height;
    }
}
}