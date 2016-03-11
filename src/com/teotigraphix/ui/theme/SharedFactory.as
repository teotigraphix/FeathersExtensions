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

import feathers.controls.Button;
import feathers.controls.ButtonState;
import feathers.controls.ImageLoader;
import feathers.controls.Scroller;
import feathers.controls.SimpleScrollBar;
import feathers.skins.ImageSkin;

import starling.display.DisplayObject;
import starling.textures.Texture;

public class SharedFactory extends AbstractThemeFactory
{
    public static const MODAL_OVERLAY_COLOR:uint = 0x29241e;

    // Background colors

    /**
     * The darkest most distant background.
     */
    public static const BACKGROUND_COLOR:uint = 0xF1F1F;

    /**
     * TextInput etc.
     */
    public static const BACKGROUND_COLOR_BLACK:uint = 0x262626;

    /**
     * Form backgrounds, etc.
     */
    public static const BACKGROUND_COLOR_LIGHT_GREY:uint = 0x8E8E8E;

    /**
     * Form backgrounds, etc.
     */
    public static const BACKGROUND_COLOR_MEDIUM_GREY:uint = 0x535353;

    /**
     * Header, footers etc.
     */
    public static const BACKGROUND_COLOR_DARK_GREY:uint = 0x3C3C3C;

    
    //I also recommend making sure that each value in the Rectangle is divisible by 2, 
    //if you can. The example above has a 1, but it would be better to increase the width 
    //of the image used for the skin by an extra pixel to make it a 2, if possible. 
    //Some devices may use 1.5x scaling, so that ensures that you'll be working with whole 
    //pixels. It can affect how crisply things render, but not always. 
    
//    protected static const DEFAULT_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 1);
//    protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 20);
//    protected static const SMALL_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 1);
//    protected static const BACK_BUTTON_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 1, 28);
//    protected static const FORWARD_BUTTON_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 1, 28);
//    protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(1, 1, 1, 42);
//    protected static const INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 40);
//    protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(7, 7, 1, 35);
//    protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(7, 2, 1, 35);
//    protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(7, 7, 1, 30);
//    protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(11, 11, 1, 22);
//    protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(2, 6, 1, 32);
//    protected static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(4, 0, 4, 5);
//    protected static const VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(0, 4, 5, 4);
//    
//    protected static const HEADER_SKIN_TEXTURE_REGION:Rectangle = new Rectangle(1, 1, 128, 64);
//    protected static const TAB_SKIN_TEXTURE_REGION:Rectangle = new Rectangle(1, 0, 22, 44);
    
    
    //public static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 22, 22);
    
    public static const BACKGROUND_POPUP_SHADOW_SKIN_SCALE9_GRID:Rectangle = new Rectangle(3, 3, 2, 2);
    
    
    
    
    // Alert
    public static const MODAL_OVERLAY_ALPHA:Number = 0.8;
    public static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(6, 6, 18, 18);

    // Button

    public static const DRAWER_OVERLAY_COLOR:uint = 0x29241e;

    // Drawers
    public static const DRAWER_OVERLAY_ALPHA:Number = 0.4;
    public static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;

    // GroupedList
    public static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;
    public static const LIST_BACKGROUND_COLOR:uint = 0xFFFFFF;//0x383430;

    // List
    public static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(2, 0, 1, 41);
    public static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
    public static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
    public static const TAB_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 25, 25);
    public static var PRIMARY_BACKGROUND_COLOR:uint = 0x4a4137;
    
    
    // ADDED
    public static const SMALL_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 1);
    public static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
    public static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(4, 0, 4, 5);
    public static const VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID:Rectangle = new Rectangle(0, 4, 5, 4);
    public static const DEFAULT_BACKGROUND_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 1);
    
    
    
    public var backgroundSkinTexture:Texture;
    public var backgroundInsetSkinTexture:Texture;
    public var backgroundDownSkinTexture:Texture;
    public var backgroundDisabledSkinTexture:Texture;
    public var backgroundFocusedSkinTexture:Texture;
    public var backgroundPopUpSkinTexture:Texture;

    // ADDED
    public var backgroundLightBorderSkinTexture:Texture; // ("background-light-border-skin0000"
    public var backgroundDarkBorderSkinTexture:Texture;
    public var backgroundInsetFocusedSkinTexture:Texture;
    public var backgroundInsetDisabledSkinTexture:Texture;
    
    public function SharedFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        backgroundSkinTexture = atlas.getTexture("background-skin"); //  ThemeProperties.DEFAULT_SCALE9_GRID
        backgroundInsetSkinTexture = atlas.getTexture("background-inset-skin");
        backgroundDownSkinTexture = atlas.getTexture("background-down-skin");
        backgroundDisabledSkinTexture = atlas.getTexture("background-disabled-skin");
        backgroundFocusedSkinTexture = atlas.getTexture("background-focused-skin");
        backgroundPopUpSkinTexture = atlas.getTexture("background-popup-skin");
        
        backgroundLightBorderSkinTexture = atlas.getTexture("background-light-border-skin0000");
        backgroundDarkBorderSkinTexture = atlas.getTexture("background-dark-border-skin0000");
        backgroundInsetFocusedSkinTexture = atlas.getTexture("background-inset-focused-skin0000");
        backgroundInsetDisabledSkinTexture = atlas.getTexture("background-inset-disabled-skin0000");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();
    }

    public function setScrollerStyles(scroller:Scroller):void
    {
        scroller.horizontalScrollBarFactory = scrollBarFactory;
        scroller.verticalScrollBarFactory = scrollBarFactory;
    }

    public function setSimpleButtonStyles(button:Button):void
    {
        var skin:ImageSkin = new ImageSkin(theme.button.buttonUpSkinTexture);
        skin.setTextureForState(ButtonState.DOWN, theme.button.buttonDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, theme.button.buttonDisabledSkinTexture);
        skin.scale9Grid = BUTTON_SCALE9_GRID;
        skin.width = theme.properties.controlSize;
        skin.height = theme.properties.controlSize;
        button.defaultSkin = skin;
        
        button.hasLabelTextRenderer = false;
        
        button.minWidth = button.minHeight = theme.properties.controlSize;
        button.minTouchWidth = button.minTouchHeight = theme.properties.gridSize;
    }

    public function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        return image;
    }

    /**
     * This theme's scroll bar type is SimpleScrollBar.
     */
    public static function scrollBarFactory():SimpleScrollBar
    {
        return new SimpleScrollBar();
    }

    /**
     * SmartDisplayObjectValueSelectors will use ImageLoader instead of
     * Image so that we can use extra features like pixel snapping.
     */
    public static function textureValueTypeHandler(value:Texture, oldDisplayObject:DisplayObject = null):DisplayObject
    {
        var displayObject:ImageLoader = oldDisplayObject as ImageLoader;
        if (!displayObject)
        {
            displayObject = new ImageLoader();
        }
        displayObject.source = value;
        return displayObject;
    }
}
}
