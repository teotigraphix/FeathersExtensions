/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Scroller;

public class ScrollerFactory extends AbstractThemeFactory
{

    public function ScrollerFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeScale():void
    {
        super.initializeScale();
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
    }

    override public function initializeGlobals():void
    {
        super.initializeGlobals();
    }

    override public function initializeStage():void
    {
        super.initializeStage();
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();
    }

    public function setScrollerStyles(scroller:Scroller):void
    {
        scroller.horizontalScrollBarFactory = scrollBarFactory;
        scroller.verticalScrollBarFactory = scrollBarFactory;
    }
}
}
