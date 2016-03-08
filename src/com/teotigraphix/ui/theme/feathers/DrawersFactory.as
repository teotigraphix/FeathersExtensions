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

import feathers.controls.Drawers;

import starling.display.Quad;

public class DrawersFactory extends AbstractThemeFactory
{

    public function DrawersFactory(theme:AbstractTheme)
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

        setStyle(Drawers, setDrawersStyles);
    }

    public function setDrawersStyles(drawers:Drawers):void
    {
        var overlaySkin:Quad = new Quad(10, 10, SharedFactory.DRAWER_OVERLAY_COLOR);
        overlaySkin.alpha = SharedFactory.DRAWER_OVERLAY_ALPHA;
        drawers.overlaySkin = overlaySkin;
        
        var topDrawerDivider:Quad = new Quad(properties.borderSize, properties.borderSize, SharedFactory.DRAWER_OVERLAY_COLOR);
        drawers.topDrawerDivider = topDrawerDivider;
        
        var rightDrawerDivider:Quad = new Quad(properties.borderSize, properties.borderSize, SharedFactory.DRAWER_OVERLAY_COLOR);
        drawers.rightDrawerDivider = rightDrawerDivider;
        
        var bottomDrawerDivider:Quad = new Quad(properties.borderSize, properties.borderSize, SharedFactory.DRAWER_OVERLAY_COLOR);
        drawers.bottomDrawerDivider = bottomDrawerDivider;
        
        var leftDrawerDivider:Quad = new Quad(properties.borderSize, properties.borderSize, SharedFactory.DRAWER_OVERLAY_COLOR);
        drawers.leftDrawerDivider = leftDrawerDivider;
    }
}
}