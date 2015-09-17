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
import feathers.controls.Radio;
import feathers.skins.SmartDisplayObjectStateValueSelector;

import starling.textures.Texture;

public class RadioFactory extends AbstractThemeFactory
{
    public var radioUpIconTexture:Texture;
    public var radioDownIconTexture:Texture;
    public var radioDisabledIconTexture:Texture;
    public var radioSelectedUpIconTexture:Texture;
    public var radioSelectedDownIconTexture:Texture;
    public var radioSelectedDisabledIconTexture:Texture;

    public function RadioFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        radioUpIconTexture = shared.backgroundSkinTexture;
        radioDownIconTexture = shared.backgroundDownSkinTexture;
        radioDisabledIconTexture = shared.backgroundDisabledSkinTexture;
        radioSelectedUpIconTexture = atlas.getTexture("radio-selected-up-icon");
        radioSelectedDownIconTexture = atlas.getTexture("radio-selected-down-icon");
        radioSelectedDisabledIconTexture = atlas.getTexture("radio-selected-disabled-icon");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Radio, setRadioStyles);
    }

    protected function setRadioStyles(radio:Radio):void
    {
        var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        iconSelector.defaultValue = radioUpIconTexture;
        iconSelector.defaultSelectedValue = radioSelectedUpIconTexture;
        iconSelector.setValueForState(radioDownIconTexture, Button.STATE_DOWN, false);
        iconSelector.setValueForState(radioDisabledIconTexture, Button.STATE_DISABLED, false);
        iconSelector.setValueForState(radioSelectedDownIconTexture, Button.STATE_DOWN, true);
        iconSelector.setValueForState(radioSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
        iconSelector.displayObjectProperties =
        {
            scaleX: properties.scale,
            scaleY: properties.scale
        };
        radio.stateToIconFunction = iconSelector.updateValue;

        radio.defaultLabelProperties.elementFormat = font.lightUIElementFormat;
        radio.disabledLabelProperties.elementFormat = font.lightUIDisabledElementFormat;
        radio.selectedDisabledLabelProperties.elementFormat = font.lightUIDisabledElementFormat;

        radio.horizontalAlign = Radio.HORIZONTAL_ALIGN_LEFT;
        radio.gap = properties.smallGutterSize;
        radio.minWidth = properties.controlSize;
        radio.minHeight = properties.controlSize;
        radio.minTouchWidth = properties.gridSize;
        radio.minTouchHeight = properties.gridSize;
    }
}
}