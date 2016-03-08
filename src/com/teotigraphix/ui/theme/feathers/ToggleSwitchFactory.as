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
import feathers.controls.ToggleButton;
import feathers.controls.ToggleSwitch;
import feathers.controls.TrackLayoutMode;
import feathers.skins.ImageSkin;

public class ToggleSwitchFactory extends AbstractThemeFactory
{

    public function ToggleSwitchFactory(theme:AbstractTheme)
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

        setStyle(ToggleSwitch, setToggleSwitchStyles);
        setStyle(Button, theme.button.setSimpleButtonStyles, ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB);
        setStyle(ToggleButton, theme.button.setSimpleButtonStyles, ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB);
        setStyle(Button, setToggleSwitchTrackStyles, ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK);
    }

    public function setToggleSwitchStyles(toggle:ToggleSwitch):void
    {
        toggle.trackLayoutMode = TrackLayoutMode.SINGLE;

        toggle.defaultLabelProperties.elementFormat = font.lightUIElementFormat;
        toggle.onLabelProperties.elementFormat = font.selectedUIElementFormat;
        toggle.disabledLabelProperties.elementFormat = font.lightUIDisabledElementFormat;
    }

    //see Shared section for thumb styles

    public function setToggleSwitchTrackStyles(track:Button):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundSkinTexture);
        skin.disabledTexture = shared.backgroundDisabledSkinTexture;
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = Math.round(properties.controlSize * 2.5);
        skin.height = properties.controlSize;
        track.defaultSkin = skin;
        track.hasLabelTextRenderer = false;
    }
}
}

