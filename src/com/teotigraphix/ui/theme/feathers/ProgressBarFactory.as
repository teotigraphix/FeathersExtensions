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

package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import feathers.controls.ProgressBar;

import starling.display.Image;

public class ProgressBarFactory extends AbstractThemeFactory
{

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
        var backgroundSkin:Image = new Image(shared.backgroundSkinTexture);
        backgroundSkin.scale9Grid = SharedFactory.DEFAULT_SCALE9_GRID;
        
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

        var backgroundDisabledSkin:Image = new Image(shared.backgroundDisabledSkinTexture);
        backgroundDisabledSkin.scale9Grid = SharedFactory.DEFAULT_SCALE9_GRID;
        
        if (progress.direction == ProgressBar.DIRECTION_VERTICAL)
        {
            backgroundDisabledSkin.width = properties.smallControlSize;
            backgroundDisabledSkin.height = properties.wideControlSize;
        }
        else
        {
            backgroundDisabledSkin.width = properties.wideControlSize;
            backgroundDisabledSkin.height = properties.smallControlSize;
        }
        progress.backgroundDisabledSkin = backgroundDisabledSkin;

        var fillSkin:Image = new Image(theme.button.buttonUpSkinTexture);
        fillSkin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        
        if (progress.direction == ProgressBar.DIRECTION_VERTICAL)
        {
            fillSkin.width = properties.smallControlSize;
            fillSkin.height = properties.smallControlSize;
        }
        else
        {
            fillSkin.width = properties.smallControlSize;
            fillSkin.height = properties.smallControlSize;
        }
        progress.fillSkin = fillSkin;

        var fillDisabledSkin:Image = new Image(theme.button.buttonDisabledSkinTexture);
        fillDisabledSkin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        
        if (progress.direction == ProgressBar.DIRECTION_VERTICAL)
        {
            fillDisabledSkin.width = properties.smallControlSize;
            fillDisabledSkin.height = properties.smallControlSize;
        }
        else
        {
            fillDisabledSkin.width = properties.smallControlSize;
            fillDisabledSkin.height = properties.smallControlSize;
        }
        progress.fillDisabledSkin = fillDisabledSkin;
    }
}
}
