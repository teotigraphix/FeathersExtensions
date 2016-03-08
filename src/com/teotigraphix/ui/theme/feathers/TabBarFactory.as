/**
 * Created by Teoti on 9/13/2015.
 */
package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import feathers.controls.ButtonState;
import feathers.controls.TabBar;
import feathers.controls.ToggleButton;
import feathers.skins.ImageSkin;

import starling.textures.Texture;

public class TabBarFactory extends AbstractThemeFactory
{
    
    public var tabUpSkinTexture:Texture;
    public var tabDownSkinTexture:Texture;
    public var tabDisabledSkinTexture:Texture;
    public var tabSelectedUpSkinTexture:Texture;
    public var tabSelectedDisabledSkinTexture:Texture;

    public function TabBarFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        tabUpSkinTexture = getTexture("tab-up-skin");
        tabDownSkinTexture = getTexture("tab-down-skin");
        tabDisabledSkinTexture = getTexture("tab-disabled-skin");
        tabSelectedUpSkinTexture = getTexture("tab-selected-up-skin");
        tabSelectedDisabledSkinTexture = getTexture("tab-selected-disabled-skin");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(TabBar, setTabBarStyles);
        setStyle(ToggleButton, setTabStyles, TabBar.DEFAULT_CHILD_STYLE_NAME_TAB);
    }

    public function setTabBarStyles(tabBar:TabBar):void
    {
        tabBar.distributeTabSizes = true;
    }

    public function setTabStyles(tab:ToggleButton):void
    {
        var skin:ImageSkin = new ImageSkin(tabUpSkinTexture);
        skin.selectedTexture = tabSelectedUpSkinTexture;
        skin.setTextureForState(ButtonState.DOWN, tabDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, tabDisabledSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, this.tabSelectedDisabledSkinTexture);
        skin.scale9Grid = SharedFactory.TAB_SCALE9_GRID;
        skin.width = properties.gridSize;
        skin.height = properties.gridSize;
        tab.defaultSkin = skin;
        
        //tab.customLabelStyleName = THEME_STYLE_NAME_TAB_LABEL;
        
        tab.paddingTop = properties.smallGutterSize;
        tab.paddingBottom = properties.smallGutterSize;
        tab.paddingLeft = properties.gutterSize;
        tab.paddingRight = properties.gutterSize;
        tab.gap = properties.smallGutterSize;
        tab.minGap = properties.smallGutterSize;
        tab.minWidth = tab.minHeight = properties.gridSize;
        tab.minTouchWidth = tab.minTouchHeight = properties.gridSize;
    }
}
}
