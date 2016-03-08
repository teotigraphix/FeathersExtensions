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

import feathers.controls.Button;
import feathers.controls.SimpleScrollBar;
import feathers.layout.Direction;

import starling.display.Image;
import starling.textures.Texture;

public class SimpleScrollBarFactory extends AbstractThemeFactory
{
    public static const SCROLL_BAR_THUMB_REGION1:int = 5;
    public static const SCROLL_BAR_THUMB_REGION2:int = 14;

    /**
     * @private
     * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
     */
    public static const THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String =
            "metal-works-mobile-horizontal-simple-scroll-bar-thumb";

    /**
     * @private
     * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
     */
    public static const THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String =
            "metal-works-mobile-vertical-simple-scroll-bar-thumb";

    public var verticalScrollBarThumbSkinTexture:Texture;
    public var horizontalScrollBarThumbSkinTexture:Texture;

    public function SimpleScrollBarFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        horizontalScrollBarThumbSkinTexture = getTexture("horizontal-scroll-bar-thumb-skin");
        verticalScrollBarThumbSkinTexture = getTexture("vertical-scroll-bar-thumb-skin");

    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(SimpleScrollBar, setSimpleScrollBarStyles);
        setStyle(Button, setHorizontalSimpleScrollBarThumbStyles, THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB);
        setStyle(Button, setVerticalSimpleScrollBarThumbStyles, THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB);
    }

    public function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar):void
    {
        if(scrollBar.direction == Direction.HORIZONTAL)
        {
            scrollBar.paddingRight = properties.scrollBarGutterSize;
            scrollBar.paddingBottom = properties.scrollBarGutterSize;
            scrollBar.paddingLeft = properties.scrollBarGutterSize;
            scrollBar.customThumbStyleName = THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
        }
        else
        {
            scrollBar.paddingTop = properties.scrollBarGutterSize;
            scrollBar.paddingRight = properties.scrollBarGutterSize;
            scrollBar.paddingBottom = properties.scrollBarGutterSize;
            scrollBar.customThumbStyleName = THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
        }
    }

    public function setHorizontalSimpleScrollBarThumbStyles(thumb:Button):void
    {
        var defaultSkin:Image = new Image(this.horizontalScrollBarThumbSkinTexture);
        defaultSkin.scale9Grid = SharedFactory.HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID;
        defaultSkin.width = properties.smallGutterSize;
        thumb.defaultSkin = defaultSkin;
        thumb.hasLabelTextRenderer = false;
    }

    public function setVerticalSimpleScrollBarThumbStyles(thumb:Button):void
    {
        var defaultSkin:Image = new Image(this.verticalScrollBarThumbSkinTexture);
        defaultSkin.scale9Grid = SharedFactory.VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID;
        defaultSkin.height = properties.smallGutterSize;
        thumb.defaultSkin = defaultSkin;
        thumb.hasLabelTextRenderer = false;
    }

}
}