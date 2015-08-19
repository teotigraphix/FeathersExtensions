/**
 * Created by Teoti on 4/13/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.ProgressBar;
import feathers.display.Scale9Image;

import starling.textures.TextureAtlas;

public class ProgressBarFactory extends AbstractThemeFactory
{

    override public function get atlas():TextureAtlas
    {
        return super.atlas;
    }

    public function ProgressBarFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(ProgressBar, setProgressBarStyles);
    }

    protected function setProgressBarStyles(progress:ProgressBar):void
    {
        var backgroundSkin:Scale9Image = AssetMap.create9ScaleImage("background-skin", 5, 5, 22, 22);
        if (progress.direction == ProgressBar.DIRECTION_VERTICAL)
        {
            backgroundSkin.width = properties.smallControlSize;
            backgroundSkin.height = properties.wideControlSize;
        }
        else
        {
            backgroundSkin.width = properties.wideControlSize;
            backgroundSkin.height = properties.smallControlSize;
        }
        progress.backgroundSkin = backgroundSkin;

        //var backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
        //if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
        //{
        //    backgroundDisabledSkin.width = this.smallControlSize;
        //    backgroundDisabledSkin.height = this.wideControlSize;
        //}
        //else
        //{
        //    backgroundDisabledSkin.width = this.wideControlSize;
        //    backgroundDisabledSkin.height = this.smallControlSize;
        //}
        //progress.backgroundDisabledSkin = backgroundDisabledSkin;
        //
        //var fillSkin:Scale9Image = new Scale9Image(this.buttonUpSkinTextures, this.scale);
        //if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
        //{
        //    fillSkin.width = this.smallControlSize;
        //    fillSkin.height = this.smallControlSize;
        //}
        //else
        //{
        //    fillSkin.width = this.smallControlSize;
        //    fillSkin.height = this.smallControlSize;
        //}
        //progress.fillSkin = fillSkin;
        //
        //var fillDisabledSkin:Scale9Image = new Scale9Image(this.buttonDisabledSkinTextures, this.scale);
        //if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
        //{
        //    fillDisabledSkin.width = this.smallControlSize;
        //    fillDisabledSkin.height = this.smallControlSize;
        //}
        //else
        //{
        //    fillDisabledSkin.width = this.smallControlSize;
        //    fillDisabledSkin.height = this.smallControlSize;
        //}
        //progress.fillDisabledSkin = fillDisabledSkin;
    }
}
}
