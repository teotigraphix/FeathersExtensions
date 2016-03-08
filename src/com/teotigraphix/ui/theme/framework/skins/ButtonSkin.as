package com.teotigraphix.ui.theme.framework.skins
{
import com.teotigraphix.ui.theme.AbstractSkin;

import flash.display.Graphics;

public class ButtonSkin extends AbstractSkin
{
    public var fillColor:uint = 0xFFFFFF;
    
    public function ButtonSkin()
    {
        super();
        //button-raised-up-skin
        // 60x60 
    }
    
    override public function draw():void
    {
        var g:Graphics = graphics;
        g.clear();
        
        // shadow
        g.beginFill(0x000000, 0.01);
        g.drawRect(0, 0, width, height);
        g.endFill();
        
        g.beginFill(0x000000, 0.03);
        g.drawRect(1, 1, width - 2, height - 2);
        g.endFill();
        
        g.beginFill(0x000000, 0.05);
        g.drawRect(2, 2, width - 4, height - 4);
        g.endFill();
        
        // border
        g.beginFill(0x808080, 1);
        g.drawRect(3, 2, width - 6, height - 6);
        g.endFill();
        
        // fill
        g.beginFill(fillColor, 1);
        g.drawRect(5, 4, width - 10, height - 10);
        g.endFill();
    }
    
    
    
    

}
}