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

import feathers.controls.TextInput;
import feathers.skins.SmartDisplayObjectStateValueSelector;

import starling.textures.SubTexture;
import starling.textures.Texture;

public class TextInputFactory extends AbstractThemeFactory
{
    protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
    protected static const DARK_TEXT_COLOR:uint = 0x1a1816;
    protected static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;

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

        setStyle(TextInput, setTextInputStyles);
        setStyle(TextInput, setSearchTextInputStyles, TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
    }

    //-------------------------
    // TextInput
    //-------------------------

    public function setTextInputStyles(input:TextInput):void
    {
        this.setBaseTextInputStyles(input);
    }

    public function setDarkTextInputStyles(input:TextInput):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundInsetSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
        skinSelector.setValueForState(theme.shared.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
        skinSelector.displayObjectProperties =
        {
            width: properties.wideControlSize,
            height: properties.controlSize,
            textureScale: properties.scale
        };
        input.stateToSkinFunction = skinSelector.updateValue;

        input.minWidth = properties.controlSize;
        input.minHeight = properties.controlSize;
        input.minTouchWidth = properties.gridSize;
        input.minTouchHeight = properties.gridSize;
        input.gap = properties.smallGutterSize;
        input.padding = properties.smallGutterSize;

        input.textEditorProperties.fontFamily = "Helvetica";
        input.textEditorProperties.fontSize = theme.fonts.regularFontSize;
        input.textEditorProperties.color = DARK_TEXT_COLOR;
        input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;

        input.promptProperties.elementFormat = theme.fonts.darkElementFormat;
        input.promptProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function setBaseTextInputStyles(input:TextInput):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.shared.backgroundInsetSkinTextures;
        skinSelector.setValueForState(theme.shared.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
        skinSelector.setValueForState(theme.shared.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
        skinSelector.displayObjectProperties =
        {
            width: properties.wideControlSize,
            height: properties.controlSize,
            textureScale: properties.scale
        };
        input.stateToSkinFunction = skinSelector.updateValue;

        input.minWidth = properties.controlSize;
        input.minHeight = properties.controlSize;
        input.minTouchWidth = properties.gridSize;
        input.minTouchHeight = properties.gridSize;
        input.gap = properties.smallGutterSize;
        input.padding = properties.smallGutterSize;

        input.textEditorProperties.fontFamily = "Helvetica";
        input.textEditorProperties.fontSize = theme.fonts.regularFontSize;
        input.textEditorProperties.color = LIGHT_TEXT_COLOR;
        input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;

        input.promptProperties.elementFormat = theme.fonts.lightElementFormat;
        input.promptProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    protected function setSearchTextInputStyles(input:TextInput):void
    {
        this.setBaseTextInputStyles(input);

        var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        iconSelector.setValueTypeHandler(SubTexture, SharedFactory.textureValueTypeHandler);
        iconSelector.defaultValue = searchIconTexture;
        iconSelector.setValueForState(searchIconDisabledTexture, TextInput.STATE_DISABLED, false);
        iconSelector.displayObjectProperties =
        {
            textureScale: properties.scale,
            snapToPixels: true
        };
        input.stateToIconFunction = iconSelector.updateValue;
    }

}
}
