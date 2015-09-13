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

import feathers.controls.Button;
import feathers.controls.Check;
import feathers.skins.SmartDisplayObjectStateValueSelector;

import starling.textures.Texture;

public class CheckFactory extends AbstractThemeFactory
{
    protected var checkUpIconTexture:Texture;
    protected var checkDownIconTexture:Texture;
    protected var checkDisabledIconTexture:Texture;
    protected var checkSelectedUpIconTexture:Texture;
    protected var checkSelectedDownIconTexture:Texture;
    protected var checkSelectedDisabledIconTexture:Texture;

    public function CheckFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        var backgroundSkinTexture:Texture = atlas.getTexture("background-skin");
        var backgroundDownSkinTexture:Texture = atlas.getTexture("background-down-skin");
        var backgroundDisabledSkinTexture:Texture = atlas.getTexture("background-disabled-skin");

        checkUpIconTexture = backgroundSkinTexture;
        checkDownIconTexture = backgroundDownSkinTexture;
        checkDisabledIconTexture = backgroundDisabledSkinTexture;
        checkSelectedUpIconTexture = atlas.getTexture("check-selected-up-icon");
        checkSelectedDownIconTexture = atlas.getTexture("check-selected-down-icon");
        checkSelectedDisabledIconTexture = atlas.getTexture("check-selected-disabled-icon");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Check, setCheckStyles);
    }
    public function setCheckStyles(check:Check):void
    {
        var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        iconSelector.defaultValue = checkUpIconTexture;
        iconSelector.defaultSelectedValue = checkSelectedUpIconTexture;
        iconSelector.setValueForState(checkDownIconTexture, Button.STATE_DOWN, false);
        iconSelector.setValueForState(checkDisabledIconTexture, Button.STATE_DISABLED, false);
        iconSelector.setValueForState(checkSelectedDownIconTexture, Button.STATE_DOWN, true);
        iconSelector.setValueForState(checkSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
        iconSelector.displayObjectProperties =
        {
            scaleX: properties.scale,
            scaleY: properties.scale
        };
        check.stateToIconFunction = iconSelector.updateValue;

        check.defaultLabelProperties.elementFormat = theme.fonts.lightUIElementFormat;
        check.disabledLabelProperties.elementFormat = theme.fonts.lightUIDisabledElementFormat;
        check.selectedDisabledLabelProperties.elementFormat = theme.fonts.lightUIDisabledElementFormat;

        check.gap = properties.smallGutterSize;
        check.minWidth = properties.controlSize;
        check.minHeight = properties.controlSize;
        check.minTouchWidth = properties.gridSize;
        check.minTouchHeight = properties.gridSize;
    }

}
}
