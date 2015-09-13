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

import feathers.controls.LayoutGroup;
import feathers.display.TiledImage;
import feathers.layout.HorizontalLayout;

public class LayoutGroupFactory extends AbstractThemeFactory
{

    public function LayoutGroupFactory(theme:AbstractTheme)
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

        setStyle(LayoutGroup, setToolbarLayoutGroupStyles, LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR);
    }

    public function setToolbarLayoutGroupStyles(group:LayoutGroup):void
    {
        if (!group.layout)
        {
            var layout:HorizontalLayout = new HorizontalLayout();
            layout.padding = properties.smallGutterSize;
            layout.gap = properties.smallGutterSize;
            layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            group.layout = layout;
        }
        group.minWidth = properties.gridSize;
        group.minHeight = properties.gridSize;

        var backgroundSkin:TiledImage = new TiledImage(theme.header.headerBackgroundSkinTexture, properties.scale);
        backgroundSkin.width = backgroundSkin.height = properties.gridSize;
        group.backgroundSkin = backgroundSkin;
    }
}
}
