package com.teotigraphix.ui.theme.framework.skins
{
import com.teotigraphix.ui.theme.AbstractSkin;

import flash.display.Graphics;

public class ActionBarSkin extends AbstractSkin 
{
    public var themeColor:uint;
    public var dropShadowHeight:Number = 5;
    
    public function ActionBarSkin()
    {
        super();
    }
    
    override public function draw():void
    {
        var g:Graphics = graphics;
        
        var fillHeight:Number = height - dropShadowHeight;
        
        g.clear();
        
        g.beginFill(themeColor);
        g.drawRect(0, 0, width, fillHeight);
        g.endFill();
        
        g.beginFill(0x242424, 0.7);
        g.drawRect(0, height - dropShadowHeight, width, 1);
        g.endFill();
        
        g.beginFill(0x242424, 0.6);
        g.drawRect(0, fillHeight + 1, width, 1);
        g.endFill();
        
        g.beginFill(0x242424, 0.5);
        g.drawRect(0, fillHeight + 2, width, 1);
        g.endFill();
        
        g.beginFill(0x242424, 0.4);
        g.drawRect(0, fillHeight + 3, width, 1); 
        g.endFill();
        
        g.beginFill(0x242424, 0.3);
        g.drawRect(0, fillHeight + 4, width, 1);
        g.endFill();
    }
}
}