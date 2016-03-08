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

import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.ButtonState;
import feathers.controls.ToggleButton;
import feathers.skins.ImageSkin;

public class ButtonGroupFactory extends AbstractThemeFactory
{
    public function ButtonGroupFactory(theme:AbstractTheme)
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

        setStyle(ButtonGroup, setButtonGroupStyles);
        setStyle(Button, setButtonGroupButtonStyles, ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON);
        setStyle(ToggleButton, setButtonGroupButtonStyles, ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON);
    }

    public function setButtonGroupStyles(group:ButtonGroup):void
    {
        group.minWidth = properties.popUpFillSize;
        group.gap = properties.smallGutterSize;
    }

    public function setButtonGroupButtonStyles(button:Button):void
    {
        var skin:ImageSkin = new ImageSkin(theme.button.buttonUpSkinTexture);
        skin.setTextureForState(ButtonState.DOWN, theme.button.buttonDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, theme.button.buttonDisabledSkinTexture);
        if(button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            skin.selectedTexture = theme.button.buttonSelectedUpSkinTexture;
            skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, theme.button.buttonSelectedDisabledSkinTexture);
        }
        skin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        skin.width = properties.gridSize;
        skin.height = properties.gridSize;
        button.defaultSkin = skin;
        
        // TODO button.customLabelStyleName = ButtonFactory.THEME_STYLE_NAME_BUTTON_GROUP_BUTTON_LABEL;

        button.paddingTop = properties.smallGutterSize;
        button.paddingBottom = properties.smallGutterSize;
        button.paddingLeft = properties.gutterSize;
        button.paddingRight = properties.gutterSize;
        button.gap = properties.smallGutterSize;
        button.minGap = properties.smallGutterSize;
        button.minWidth = properties.gridSize;
        button.minHeight = properties.gridSize;
        button.minTouchWidth = properties.gridSize;
        button.minTouchHeight = properties.gridSize;
    }
}
}