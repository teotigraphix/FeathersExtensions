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

import com.teotigraphix.ui.theme.*;

import com.teotigraphix.ui.component.Led;

import starling.display.Quad;

public class LedFactory extends AbstractThemeFactory
{

    public function LedFactory(theme:AbstractTheme)
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

        setStyle(Led, setLedStyles);
    }

    public function setLedStyles(led:Led):void
    {
        var focus:Quad = new Quad(25, 25, 0x009B00);
        var lit:Quad = new Quad(25, 25, 0x9F0000);
        var unlit:Quad = new Quad(25, 25, 0xE0E0E0);
        var highlight:Quad = new Quad(25, 25, 0x000000);
        led.focusedSkin = focus;
        led.litSkin = lit;
        led.unLitSkin = unlit;
        led.highlightSkin = highlight;
    }
}
}
