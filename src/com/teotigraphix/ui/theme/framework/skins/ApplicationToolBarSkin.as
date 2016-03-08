package com.teotigraphix.ui.theme.framework.skins
{
import com.teotigraphix.ui.theme.AbstractSkin;

import flash.display.Graphics;

public class ApplicationToolBarSkin extends AbstractSkin 
{
    public var themeColor:uint;
    public var fillColor:uint = 0xA8A8A8;
    
    public function ApplicationToolBarSkin()
    {
    }
    
    override public function draw():void
    {
        var g:Graphics = graphics;
        g.clear();
        
        g.beginFill(fillColor);
        g.drawRect(0, 0, width, height);
        g.endFill();
        
        g.beginFill(0x000000);
        g.drawRect(width - 2, 0, 2, height);
        g.endFill();
    }
}
}