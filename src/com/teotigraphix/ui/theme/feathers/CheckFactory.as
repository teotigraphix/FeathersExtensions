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
import com.teotigraphix.ui.theme.framework.FrameworkStyleNames;

import feathers.controls.ButtonState;
import feathers.controls.Check;
import feathers.layout.HorizontalAlign;
import feathers.skins.ImageSkin;

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

        checkUpIconTexture = atlas.getTexture("check-up-icon");
        checkDownIconTexture = atlas.getTexture("check-up-icon");
        checkDisabledIconTexture = atlas.getTexture("check-up-disabled-icon");
        checkSelectedUpIconTexture = atlas.getTexture("check-selected-up-icon");
        checkSelectedDownIconTexture = atlas.getTexture("check-selected-down-icon");
        checkSelectedDisabledIconTexture = atlas.getTexture("check-selected-disabled-icon");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Check, setStyles);
        setStyle(Check, setCheckDarkStyles, FrameworkStyleNames.CHECK_DARK);
    }

    public function setStyles(check:Check):void
    {
        var icon:ImageSkin = new ImageSkin(this.checkUpIconTexture);
        icon.selectedTexture = this.checkSelectedUpIconTexture;
        icon.setTextureForState(ButtonState.DOWN, this.checkDownIconTexture);
        icon.setTextureForState(ButtonState.DISABLED, this.checkDisabledIconTexture);
        icon.setTextureForState(ButtonState.DOWN_AND_SELECTED, this.checkSelectedDownIconTexture);
        icon.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.checkSelectedDisabledIconTexture);
        check.defaultIcon = icon;
        
        check.horizontalAlign = HorizontalAlign.LEFT;
        check.gap = properties.smallGutterSize;
        check.minWidth = properties.controlSize;
        check.minHeight = properties.controlSize;
        check.minTouchWidth = properties.gridSize;
        check.minTouchHeight = properties.gridSize;
    }

    public function setCheckDarkStyles(check:Check):void
    {
        setStyles(check);

        check.defaultLabelProperties.elementFormat = theme.fonts.darkUIElementFormat;
        check.disabledLabelProperties.elementFormat = theme.fonts.darkUIDisabledElementFormat;
        check.selectedDisabledLabelProperties.elementFormat = theme.fonts.darkUIDisabledElementFormat;

    }

}
}
