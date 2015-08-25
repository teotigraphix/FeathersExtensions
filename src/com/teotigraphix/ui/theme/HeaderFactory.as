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
