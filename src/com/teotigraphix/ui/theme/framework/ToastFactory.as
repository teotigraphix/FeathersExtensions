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

package com.teotigraphix.ui.theme.framework
{

import com.teotigraphix.ui.component.Toast;
import com.teotigraphix.ui.theme.*;

import feathers.controls.Label;

public class ToastFactory extends AbstractThemeFactory
{

    public function ToastFactory(theme:AbstractTheme)
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

        setStyle(Toast, setStyles);
        setStyle(Label, set_messageStyle, Toast.STYLE_MESSAGE);
    }

    private function setStyles(toast:Toast):void
    {
        toast.backgroundSkin = AssetMap.create9ScaleImage("background-popup-shadow-skin", 8, 8, 16, 16);
    }

    private function set_messageStyle(label:Label):void
    {
        //theme.label.setLabelDarkStyles(label);
    }

}
}
