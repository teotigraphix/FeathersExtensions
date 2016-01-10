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

import com.teotigraphix.ui.component.SimpleButton;
import com.teotigraphix.ui.component.UIToggleButton;
import com.teotigraphix.ui.theme.*;
import com.teotigraphix.ui.theme.framework.FrameworkStyleNames;

import feathers.controls.Button;
import feathers.controls.ToggleButton;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

import flash.text.engine.ElementFormat;

public class ButtonFactory extends AbstractThemeFactory
{
    public var buttonUpSkinTextures:Scale9Textures;
    public var buttonDownSkinTextures:Scale9Textures;
    public var buttonDisabledSkinTextures:Scale9Textures;
    public var buttonSelectedUpSkinTextures:Scale9Textures;
    public var buttonSelectedDisabledSkinTextures:Scale9Textures;

    public var buttonRaisedUpSkinTextures:Scale9Textures;
    public var buttonRaisedDownSkinTextures:Scale9Textures;
    public var buttonRaisedDisabledSkinTextures:Scale9Textures;
    public var buttonRaisedSelectedUpSkinTextures:Scale9Textures;
    public var buttonRaisedSelectedDisabledSkinTextures:Scale9Textures;

    public function ButtonFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        buttonUpSkinTextures = AssetMap.createScale9Textures("button-up-skin",
                                                             SharedFactory.BUTTON_SCALE9_GRID);
        buttonDownSkinTextures = AssetMap.createScale9Textures("button-down-skin",
                                                               SharedFactory.BUTTON_SCALE9_GRID);
        buttonDisabledSkinTextures = AssetMap.createScale9Textures("button-disabled-skin",
                                                                   SharedFactory.BUTTON_SCALE9_GRID);
        buttonSelectedUpSkinTextures = AssetMap.createScale9Textures("button-selected-up-skin",
                                                                     SharedFactory.BUTTON_SELECTED_SCALE9_GRID);
        buttonSelectedDisabledSkinTextures = AssetMap.createScale9Textures("button-selected-disabled-skin",
                                                                           SharedFactory.BUTTON_SELECTED_SCALE9_GRID);

        buttonRaisedUpSkinTextures = AssetMap.createScale9Textures("button-raised-up-skin",
                                                                   SharedFactory.BUTTON_SCALE9_GRID);
        buttonRaisedDownSkinTextures = AssetMap.createScale9Textures("button-raised-down-skin",
                                                                     SharedFactory.BUTTON_SCALE9_GRID);
        buttonRaisedDisabledSkinTextures = AssetMap.createScale9Textures("button-raised-disabled-skin",
                                                                         SharedFactory.BUTTON_SCALE9_GRID);
        buttonRaisedSelectedUpSkinTextures = AssetMap.createScale9Textures("button-raised-selected-up-skin",
                                                                     SharedFactory.BUTTON_SELECTED_SCALE9_GRID);
        buttonRaisedSelectedDisabledSkinTextures = AssetMap.createScale9Textures("button-raised-selected-disabled-skin",
                                                                           SharedFactory.BUTTON_SELECTED_SCALE9_GRID);
    }

    override public function initializeStyleProviders():void
    {
        setStyle(Button, setButtonStyles);
        setStyle(SimpleButton, setSimpleButtonStyles);
        setStyle(ToggleButton, setButtonStyles);
        setStyle(UIToggleButton, setButtonStyles);

        // Button Raised
        setStyle(Button, setButtonRaisedStyles, FrameworkStyleNames.THEME_BUTTON_RAISED);
        setStyle(ToggleButton, setToggleButtonRaisedStyles, FrameworkStyleNames.THEME_BUTTON_RAISED);
    }

    public function setBaseButtonStyles(button:Button):void
    {
        button.defaultLabelProperties.elementFormat = getFont();
        button.disabledLabelProperties.elementFormat = getDisabledFont();
        if (button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            ToggleButton(button).selectedDisabledLabelProperties.elementFormat = getSelectedDisabledFont();
        }

        //button.paddingTop = properties.smallGutterSize;
        //button.paddingBottom = properties.smallGutterSize;
        //button.paddingLeft = properties.gutterSize;
        //button.paddingRight = properties.gutterSize;
        //button.gap = properties.smallGutterSize;
        //button.minGap = properties.smallGutterSize;
        button.minWidth = button.minHeight = properties.controlSize;
        //button.minWidth = dp(64);
        button.height = dp(36);
        button.padding = dp(8);
        button.gap = dp(8);
        button.minTouchWidth = properties.gridSize;
        button.minTouchHeight = properties.gridSize;
    }

    public function setSimpleButtonStyles(button:SimpleButton):void
    {
        button.upSkin = AssetMap.createImage("button-up-skin");
        button.downSkin = AssetMap.createImage("button-down-skin");
        button.selectedSkin = AssetMap.createImage("button-selected-up-skin");
    }

    public function setButtonStyles(button:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = buttonUpSkinTextures;
        skinSelector.setValueForState(buttonDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.setValueForState(buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
        if (button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            // ME
            var toggleButton:ToggleButton = ToggleButton(button);
            toggleButton.defaultSelectedLabelProperties.elementFormat = getSelectedFont();
            toggleButton.selectedDisabledLabelProperties.elementFormat = getSelectedDisabledFont();

            skinSelector.defaultSelectedValue = buttonSelectedUpSkinTextures;
            skinSelector.setValueForState(buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
        }
        skinSelector.displayObjectProperties =
        {
            width: properties.controlSize,
            height: properties.controlSize,
            textureScale: theme.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;
        setBaseButtonStyles(button);
    }

    public function setButtonRaisedStyles(button:Button):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = buttonRaisedUpSkinTextures;
        skinSelector.setValueForState(buttonRaisedDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.setValueForState(buttonRaisedDisabledSkinTextures, Button.STATE_DISABLED, false);
        if (button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            // ME
            var toggleButton:ToggleButton = ToggleButton(button);
            toggleButton.defaultSelectedLabelProperties.elementFormat = getSelectedFont();
            toggleButton.selectedDisabledLabelProperties.elementFormat = getSelectedDisabledFont();

            skinSelector.defaultSelectedValue = buttonSelectedUpSkinTextures;
            skinSelector.setValueForState(buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
        }
        skinSelector.displayObjectProperties =
        {
            width: properties.controlSize,
            height: properties.controlSize,
            textureScale: theme.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;

        setBaseButtonStyles(button);
    }

    public function setToggleButtonRaisedStyles(button:ToggleButton):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = buttonRaisedUpSkinTextures;
        skinSelector.setValueForState(buttonRaisedDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.setValueForState(buttonRaisedDisabledSkinTextures, Button.STATE_DISABLED, false);
        if (button is ToggleButton)
        {
            //for convenience, this function can style both a regular button
            //and a toggle button
            // ME
            var toggleButton:ToggleButton = ToggleButton(button);
            toggleButton.defaultSelectedLabelProperties.elementFormat = getSelectedFont();
            toggleButton.selectedDisabledLabelProperties.elementFormat = getSelectedDisabledFont();

            skinSelector.defaultSelectedValue = buttonRaisedSelectedUpSkinTextures;
            skinSelector.setValueForState(buttonRaisedSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
        }
        skinSelector.displayObjectProperties =
        {
            width: properties.controlSize,
            height: properties.controlSize,
            textureScale: theme.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;

        setBaseButtonStyles(button);
    }

    /**
     * Regular button font, darkElementFormat.
     */
    protected function getFont():ElementFormat
    {
        return font.darkElementFormat;
    }

    /**
     * Regular disabled button font, lightElementFormat.
     */
    protected function getDisabledFont():ElementFormat
    {
        return font.disabledElementFormat;
    }

    /**
     * Selected font, darkUIElementFormat.
     */
    protected function getSelectedFont():ElementFormat
    {
        return font.darkUIElementFormat;
    }

    /**
     * Selected disabled font, darkUIDisabledElementFormat.
     */
    protected function getSelectedDisabledFont():ElementFormat
    {
        return font.darkUIDisabledElementFormat;
    }
}
}
