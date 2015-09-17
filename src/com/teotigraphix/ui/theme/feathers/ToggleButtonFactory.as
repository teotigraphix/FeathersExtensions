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
import feathers.controls.ToggleButton;
import feathers.skins.SmartDisplayObjectStateValueSelector;

public class ToggleButtonFactory extends AbstractThemeFactory
{

    public function ToggleButtonFactory(theme:AbstractTheme)
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

        setStyle(ToggleButton, theme.button.setButtonStyles);
        setStyle(ToggleButton, setQuietButtonStyles, Button.ALTERNATE_NAME_QUIET_BUTTON);
    }

    public function setQuietButtonStyles(button:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = null;
        skinSelector.setValueForState(theme.button.buttonDownSkinTextures, Button.STATE_DOWN, false);
        if(button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            skinSelector.defaultSelectedValue = theme.button.buttonSelectedUpSkinTextures;
        }
        skinSelector.displayObjectProperties =
        {
            width: properties.controlSize,
            height: properties.controlSize,
            textureScale: properties.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;

        button.defaultLabelProperties.elementFormat = font.lightUIElementFormat;
        button.downLabelProperties.elementFormat = font.darkUIElementFormat;
        button.disabledLabelProperties.elementFormat = font.lightUIDisabledElementFormat;
        if(button is ToggleButton)
        {
            var toggleButton:ToggleButton = ToggleButton(button);
            toggleButton.defaultSelectedLabelProperties.elementFormat = font.darkUIElementFormat;
            toggleButton.selectedDisabledLabelProperties.elementFormat = font.darkUIDisabledElementFormat;
        }

        button.paddingTop = button.paddingBottom = properties.smallGutterSize;
        button.paddingLeft = button.paddingRight = properties.gutterSize;
        button.gap = properties.smallGutterSize;
        button.minGap = properties.smallGutterSize;
        button.minWidth = button.minHeight = properties.controlSize;
        button.minTouchWidth = button.minTouchHeight = properties.gridSize;
    }
}
}

