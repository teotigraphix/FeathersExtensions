/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

import flash.geom.Rectangle;

public class ThemeProperties
{
    public static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);

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
        this.theme = theme;
    }

    public function initialize():void
    {
        gridSize = Math.round(88 * theme.scale);
        smallGutterSize = Math.round(11 * theme.scale);
        gutterSize = Math.round(22 * theme.scale);
        controlSize = Math.round(58 * theme.scale);
        smallControlSize = Math.round(22 * theme.scale);
        popUpFillSize = Math.round(552 * theme.scale);
        calloutBackgroundMinSize = Math.round(11 * theme.scale);
        scrollBarGutterSize = Math.round(4 * theme.scale);
        wideControlSize = gridSize * 3 + gutterSize * 2;

    }
}
}
