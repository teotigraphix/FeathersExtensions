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

import flash.geom.Rectangle;

import starling.events.EventDispatcher;

public class ThemeProperties extends EventDispatcher
{
    public static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);

    private static var _gap:Number;
    private static var _gapx2:Number;
    private static var _padding:Number;
    
    private static var dispatcher:EventDispatcher;
    
    [Bindable("change")]
    public static function get gap():Number
    {
        return _gap;
    }

    public static function set gap(value:Number):void
    {
        _gap = value;
        dispatcher.dispatchEventWith("change");
    }
    
    [Bindable("change")]
    public static function get gapx2():Number
    {
        return _gapx2;
    }

    public static function set gapx2(value:Number):void
    {
        _gapx2 = value;
        dispatcher.dispatchEventWith("change");
    }
    
    [Bindable("change")]
    public static function get padding():Number
    {
        return _padding;
    }

    public static function set padding(value:Number):void
    {
        _padding = value;
        dispatcher.dispatchEventWith("change");
    }

    public var scale:Number;

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

    private var theme:AbstractTheme;

    public function ThemeProperties(theme:AbstractTheme)
    {
        dispatcher = this;
        
        this.theme = theme;
    }

    public function initialize():void
    {
        gap = AssetMap.dp(8);
        gapx2 = AssetMap.dp(11);
        padding = AssetMap.dp(11);

        gridSize = Math.round(88 * theme.scale);
        gutterSize = Math.round(22 * theme.scale);
        smallGutterSize = Math.round(11 * theme.scale);

        controlSize = Math.round(58 * theme.scale);
        smallControlSize = Math.round(22 * theme.scale);
        wideControlSize = gridSize * 3 + gutterSize * 2;

        popUpFillSize = Math.round(552 * theme.scale);
        calloutBackgroundMinSize = Math.round(11 * theme.scale);
        scrollBarGutterSize = Math.round(4 * theme.scale);
    }
}
}
