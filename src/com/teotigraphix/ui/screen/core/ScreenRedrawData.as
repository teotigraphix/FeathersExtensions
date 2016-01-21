package com.teotigraphix.ui.screen.core
{
import starling.display.DisplayObject;

public class ScreenRedrawData
{
    public var activeScreen:DisplayObject;
    
    public function ScreenRedrawData(activeScreen:DisplayObject)
    {
        this.activeScreen = activeScreen;
    }
}
}