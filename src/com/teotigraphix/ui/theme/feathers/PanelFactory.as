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

import feathers.controls.Header;
import feathers.controls.Panel;
import feathers.controls.PanelScreen;
import feathers.display.Scale9Image;

public class PanelFactory extends AbstractThemeFactory
{

    public function PanelFactory(theme:AbstractTheme)
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

        setStyle(Panel, setPanelStyles);
        setStyle(Header, setHeaderWithoutBackgroundStyles, Panel.DEFAULT_CHILD_STYLE_NAME_HEADER);

        setStyle(PanelScreen, setPanelScreenStyles);
        setStyle(Header, setPanelScreenHeaderStyles, PanelScreen.DEFAULT_CHILD_STYLE_NAME_HEADER);
    }

    //-------------------------
    // Panel
    //-------------------------

    public function setPanelStyles(panel:Panel):void
    {
        theme.scroller.setScrollerStyles(panel);

        panel.backgroundSkin = new Scale9Image(shared.backgroundPopUpSkinTextures, properties.scale);

        panel.paddingTop = 0;
        panel.paddingRight = properties.smallGutterSize;
        panel.paddingBottom = properties.smallGutterSize;
        panel.paddingLeft = properties.smallGutterSize;
    }

    public function setHeaderWithoutBackgroundStyles(header:Header):void
    {
        header.minWidth = properties.gridSize;
        header.minHeight = properties.gridSize;
        header.padding = properties.smallGutterSize;
        header.gap = properties.smallGutterSize;
        header.titleGap = properties.smallGutterSize;

        header.titleProperties.elementFormat = font.headerElementFormat;
    }

    //-------------------------
    // PanelScreen
    //-------------------------

    public function setPanelScreenStyles(screen:PanelScreen):void
    {
        theme.scroller.setScrollerStyles(screen);
    }

    public function setPanelScreenHeaderStyles(header:Header):void
    {
        theme.header.setHeaderStyles(header);
        header.useExtraPaddingForOSStatusBar = true;
    }

}
}