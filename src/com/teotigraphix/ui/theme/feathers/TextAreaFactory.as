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

import feathers.controls.TextArea;
import feathers.controls.TextInputState;
import feathers.controls.text.StageTextTextEditorViewPort;
import feathers.skins.ImageSkin;

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
        
        var skin:ImageSkin = new ImageSkin(shared.backgroundInsetSkinTexture);
        skin.setTextureForState(TextInputState.DISABLED, shared.backgroundDisabledSkinTexture);
        skin.setTextureForState(TextInputState.FOCUSED, shared.backgroundInsetFocusedSkinTexture);
        skin.scale9Grid = SharedFactory.DEFAULT_BACKGROUND_SCALE9_GRID;
        skin.width = properties.wideControlSize;
        skin.height = properties.wideControlSize;
        textArea.backgroundSkin = skin;
        
        textArea.textEditorFactory = textAreaTextEditorFactory;
    }
    
    /**
     * The text editor factory for a TextArea creates a
     * StageTextTextEditorViewPort.
     */
    protected static function textAreaTextEditorFactory():StageTextTextEditorViewPort
    {
        return new StageTextTextEditorViewPort();
    }
}
}
