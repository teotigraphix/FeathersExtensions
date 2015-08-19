/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.SimpleScrollBar;

import starling.textures.TextureAtlas;

public class AbstractThemeFactory
{
    public var theme:AbstractTheme;
    public var properties:ThemeProperties;
    private var _atlas:TextureAtlas;

    public function get atlas():TextureAtlas
    {
        return _atlas;
    }

    public function set atlas(value:TextureAtlas):void
    {
        _atlas = value;
    }

    public function AbstractThemeFactory(theme:AbstractTheme)
    {
        this.theme = theme;
    }

    public function initializeScale():void
    {
    }

    public function initializeDimensions():void
    {
    }

    public function initializeFonts():void
    {
    }

    public function initializeTextures():void
    {
    }

    public function initializeGlobals():void
    {
    }

    public function initializeStage():void
    {
    }

    public function initializeStyleProviders():void
    {
    }

    protected function setStyle(clazz:Class, func:Function, name:String = null):void
    {
        if (name != null)
        {
            theme.getStyleProviderForClass(clazz).setFunctionForStyleName(name, func);
        }
        else
        {
            theme.getStyleProviderForClass(clazz).defaultStyleFunction = func;
        }
    }

    protected static function scrollBarFactory():SimpleScrollBar
    {
        return new SimpleScrollBar();
    }

}
}
