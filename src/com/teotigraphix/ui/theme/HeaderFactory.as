/**
 * Created by Teoti on 4/5/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Header;

import starling.display.Image;
import starling.textures.Texture;

public class HeaderFactory extends AbstractThemeFactory
{
    protected var headerBackgroundSkinTexture:Texture;

    public function HeaderFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        this.headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Header, setHeaderStyles);
    }

    public function setHeaderStyles(header:Header):void
    {
        header.minWidth = properties.gridSize;
        header.minHeight = properties.gridSize;
        header.padding = properties.smallGutterSize;
        header.gap = properties.smallGutterSize;
        header.titleGap = properties.smallGutterSize;

        var backgroundSkin:Image = new Image(this.headerBackgroundSkinTexture);
        backgroundSkin.width = properties.gridSize;
        backgroundSkin.height = properties.gridSize;
        header.backgroundSkin = backgroundSkin;
        header.titleProperties.elementFormat = theme.fonts.headerElementFormat;
    }
}
}
