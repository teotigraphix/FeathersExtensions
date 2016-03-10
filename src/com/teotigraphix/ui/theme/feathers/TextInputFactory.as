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
import com.teotigraphix.ui.theme.FontFactory;
import com.teotigraphix.ui.theme.SharedFactory;
import com.teotigraphix.ui.theme.framework.FrameworkStyleNames;

import feathers.controls.TextInput;
import feathers.controls.TextInputState;
import feathers.layout.VerticalAlign;
import feathers.skins.ImageSkin;

import starling.textures.Texture;

public class TextInputFactory extends AbstractThemeFactory
{
    public var searchIconTexture:Texture;
    public var searchIconDisabledTexture:Texture;

    public function TextInputFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        searchIconTexture = atlas.getTexture("search-icon");
        searchIconDisabledTexture = atlas.getTexture("search-icon-disabled");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(TextInput, setStyles);
        setStyle(TextInput, setDarkStyles, FrameworkStyleNames.TEXT_INPUT_DARK);
        setStyle(TextInput, setSearchTextInputStyles, TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
    }

    //-------------------------
    // TextInput
    //-------------------------

    public function setStyles(input:TextInput):void
    {
        setBaseTextInputStyles(input);
        setDarkStyles(input);
    }

    public function setDarkStyles(input:TextInput):void
    {
        setBaseTextInputStyles(input);

        input.textEditorProperties.fontFamily = "Helvetica";
        input.textEditorProperties.fontSize = theme.fonts.regularFontSize;
        input.textEditorProperties.color = FontFactory.DARK_TEXT_COLOR;
        input.textEditorProperties.disabledColor = FontFactory.DARK_DISABLED_TEXT_COLOR;

        input.promptProperties.elementFormat = theme.fonts.darkUIElementFormat;
        input.promptProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    public function setDarkTextInputStyles(input:TextInput):void
    {
        setBaseTextInputStyles(input);
    }

    public function setBaseTextInputStyles(input:TextInput):void
    {
        var skin:ImageSkin = new ImageSkin(shared.backgroundInsetSkinTexture);
        skin.setTextureForState(TextInputState.DISABLED, shared.backgroundInsetDisabledSkinTexture);
        skin.setTextureForState(TextInputState.FOCUSED, shared.backgroundInsetFocusedSkinTexture);
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.wideControlSize;
        skin.height = properties.controlSize;
        input.backgroundSkin = skin;
        
        input.minWidth = properties.controlSize;
        input.minHeight = properties.controlSize;
        input.minTouchWidth = properties.gridSize;
        input.minTouchHeight = properties.gridSize;
        input.gap = properties.smallGutterSize;
        input.padding = properties.smallGutterSize;
        input.verticalAlign = VerticalAlign.MIDDLE;
    }

    protected function setSearchTextInputStyles(input:TextInput):void
    {
//        this.setBaseTextInputStyles(input);
//
//        var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
//        iconSelector.setValueTypeHandler(SubTexture, SharedFactory.textureValueTypeHandler);
//        iconSelector.defaultValue = searchIconTexture;
//        iconSelector.setValueForState(searchIconDisabledTexture, TextInput.STATE_DISABLED, false);
//        iconSelector.displayObjectProperties =
//        {
//            textureScale: properties.scale,
//            snapToPixels: true
//        };
//        input.stateToIconFunction = iconSelector.updateValue;
    }

}
}
