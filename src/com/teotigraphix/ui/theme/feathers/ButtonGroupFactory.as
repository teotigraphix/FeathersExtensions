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

import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.ToggleButton;
import feathers.skins.SmartDisplayObjectStateValueSelector;

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
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.button.buttonUpSkinTextures;
        skinSelector.setValueForState(theme.button.buttonDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.setValueForState(theme.button.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
        if (button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            skinSelector.defaultSelectedValue = theme.button.buttonSelectedUpSkinTextures;
            skinSelector.setValueForState(theme.button.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
        }
        skinSelector.displayObjectProperties =
        {
            width: properties.gridSize,
            height: properties.gridSize,
            textureScale: properties.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;

        button.defaultLabelProperties.elementFormat = font.largeUIDarkElementFormat;
        button.disabledLabelProperties.elementFormat = font.largeUIDarkDisabledElementFormat;
        if (button is ToggleButton)
        {
            ToggleButton(button).selectedDisabledLabelProperties.elementFormat = font.largeUIDarkDisabledElementFormat;
        }

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