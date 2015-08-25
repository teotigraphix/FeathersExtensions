////////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Michael Schmalle - Teoti Graphix, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License
//
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////

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
