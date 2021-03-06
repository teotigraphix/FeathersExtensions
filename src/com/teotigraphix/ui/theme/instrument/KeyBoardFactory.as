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

package com.teotigraphix.ui.theme.instrument
{

import com.teotigraphix.ui.component.instrument.support.KeyBoardKey;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.AssetMap;

import feathers.controls.Label;

public class KeyBoardFactory extends AbstractThemeFactory
{

    public function KeyBoardFactory(theme:AbstractTheme)
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

        setStyle(Label, setKeyBoardKeyWhiteLabelStyles, "key-label-white");
        setStyle(Label, setKeyBoardKeyBlackLabelStyles, "key-label-black");

        setStyle(KeyBoardKey, setKeyBoardKeyStyles);
    }

    private function setKeyBoardKeyWhiteLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkUIElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    private function setKeyBoardKeyBlackLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.smallLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    private function setKeyBoardKeyStyles(key:KeyBoardKey):void
    {
        if (key.isFlat)
        {
            key.upSkin = AssetMap.createImage("key-black-up-skin");
            key.downSkin = AssetMap.createImage("key-black-down-skin");
            key.disabledSkin = AssetMap.createImage("key-black-disabled-skin");
        }
        else
        {
            key.upSkin = AssetMap.createImage("key-white-up-skin");
            key.downSkin = AssetMap.createImage("key-white-down-skin");
            key.disabledSkin = AssetMap.createImage("key-white-disabled-skin");
        }

    }
}
}
