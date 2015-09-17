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

import com.teotigraphix.ui.theme.*;

import feathers.controls.ScrollContainer;
import feathers.display.TiledImage;
import feathers.layout.HorizontalLayout;

public class ScrollContainerFactory extends AbstractThemeFactory
{

    public function ScrollContainerFactory(theme:AbstractTheme)
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

        setStyle(ScrollContainer, setScrollContainerStyles);
        setStyle(ScrollContainer, setToolbarScrollContainerStyles, ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR);
    }

    public function setScrollContainerStyles(container:ScrollContainer):void
    {
        theme.scroller.setScrollerStyles(container);
    }

    public function setToolbarScrollContainerStyles(container:ScrollContainer):void
    {
        theme.scroller.setScrollerStyles(container);
        if(!container.layout)
        {
            var layout:HorizontalLayout = new HorizontalLayout();
            layout.padding = properties.smallGutterSize;
            layout.gap = properties.smallGutterSize;
            layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            container.layout = layout;
        }
        container.minWidth = properties.gridSize;
        container.minHeight = properties.gridSize;

        var backgroundSkin:TiledImage = new TiledImage(theme.header.headerBackgroundSkinTexture, properties.scale);
        backgroundSkin.width = backgroundSkin.height = properties.gridSize;
        container.backgroundSkin = backgroundSkin;
    }
}
}