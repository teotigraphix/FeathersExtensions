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

import starling.events.EventDispatcher;

public class ThemeProperties extends EventDispatcher
{
    private static var dispatcher:EventDispatcher;

    /**
     * The size, in pixels, of major regions in the grid. Used for sizing
     * containers and larger UI controls.
     */
    public var gridSize:int;

    /**
     * The size, in pixels, of minor regions in the grid. Used for larger
     * padding and gaps.
     */
    public var gutterSize:int;

    /**
     * The size, in pixels, of smaller padding and gaps within the major
     * regions in the grid.
     */
    public var smallGutterSize:int;

    /**
     * The width, in pixels, of UI controls that span across multiple grid regions.
     */
    public var wideControlSize:int;

    /**
     * The size, in pixels, of a typical UI control.
     */
    public var controlSize:int;

    /**
     * The size, in pixels, of smaller UI controls.
     */
    public var smallControlSize:int;

    public var popUpFillSize:int;
    public var calloutBackgroundMinSize:int;
    public var scrollBarGutterSize:int;
    
    public var calloutArrowOverlapGap:int;
    public var borderSize:int;
    
    private var theme:AbstractTheme;

    public function ThemeProperties(theme:AbstractTheme)
    {
        dispatcher = this;
        
        this.theme = theme;
    }

    public function initialize():void
    {
        gridSize = 48;//44;
        smallGutterSize = 8;
        gutterSize = 16; //12;
        controlSize = 36;//28;
        smallControlSize = 12;
        popUpFillSize = 276;
        calloutBackgroundMinSize = 12;
        calloutArrowOverlapGap = -2;
        scrollBarGutterSize = 2;
        wideControlSize = gridSize * 3 + gutterSize * 2;
        borderSize = 1;
    }
}
}
