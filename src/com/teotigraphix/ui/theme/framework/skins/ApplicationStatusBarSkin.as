package com.teotigraphix.ui.theme.framework.skins
{
import com.teotigraphix.ui.theme.AbstractSkin;

import flash.display.Graphics;

public class ApplicationStatusBarSkin extends AbstractSkin 
{
    public var themeColor:uint;
    public var fillColor:uint = 0xDDDDDD;
    
    public function ApplicationStatusBarSkin()
    {
    }
    
    override public function draw():void
    {
        var g:Graphics = graphics;
        g.clear();
        
        g.beginFill(fillColor);
        g.drawRect(0, 0, width, height);
        g.endFill();
        
        g.beginFill(0x242424);
        g.drawRect(0, 0, width, 2);
        g.endFill();
    }
}
}