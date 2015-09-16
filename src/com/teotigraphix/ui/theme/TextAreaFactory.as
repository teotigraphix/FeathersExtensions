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

import feathers.controls.TextArea;
import feathers.skins.SmartDisplayObjectStateValueSelector;

public class TextAreaFactory extends AbstractThemeFactory
{

    public function TextAreaFactory(theme:AbstractTheme)
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

        setStyle(TextArea, setTextAreaStyles);
    }

    public function setTextAreaStyles(textArea:TextArea):void
    {
        theme.scroller.setScrollerStyles(textArea);

        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = shared.backgroundInsetSkinTextures;
        skinSelector.setValueForState(shared.backgroundDisabledSkinTextures, TextArea.STATE_DISABLED);
        skinSelector.setValueForState(shared.backgroundFocusedSkinTextures, TextArea.STATE_FOCUSED);
        skinSelector.displayObjectProperties =
        {
            width: properties.wideControlSize,
            height: properties.wideControlSize,
            textureScale: properties.scale
        };
        textArea.stateToSkinFunction = skinSelector.updateValue;

        textArea.textEditorProperties.textFormat = font.scrollTextTextFormat;
        textArea.textEditorProperties.disabledTextFormat = font.scrollTextDisabledTextFormat;
        textArea.textEditorProperties.padding = properties.smallGutterSize;
    }
}
}