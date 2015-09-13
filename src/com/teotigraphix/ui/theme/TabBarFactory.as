/**
 * Created by Teoti on 9/13/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.TabBar;
import feathers.controls.ToggleButton;
import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;

import flash.geom.Rectangle;

import starling.display.Quad;

public class TabBarFactory extends AbstractThemeFactory
{
    public static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
    public static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
    public static const TAB_SCALE9_GRID:Rectangle = new Rectangle(19, 19, 50, 50);

    public var tabDownSkinTextures:Scale9Textures;
    public var tabSelectedSkinTextures:Scale9Textures;
    public var tabSelectedDisabledSkinTextures:Scale9Textures;

    public function TabBarFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
        tabSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
        tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"),
                                                             TAB_SCALE9_GRID);
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
        var defaultSkin:Quad = new Quad(properties.gridSize, properties.gridSize, TAB_BACKGROUND_COLOR);
        tab.defaultSkin = defaultSkin;

        var downSkin:Scale9Image = new Scale9Image(tabDownSkinTextures, properties.scale);
        tab.downSkin = downSkin;

        var defaultSelectedSkin:Scale9Image = new Scale9Image(tabSelectedSkinTextures, properties.scale);
        tab.defaultSelectedSkin = defaultSelectedSkin;

        var disabledSkin:Quad = new Quad(properties.gridSize, properties.gridSize, TAB_DISABLED_BACKGROUND_COLOR);
        tab.disabledSkin = disabledSkin;

        var selectedDisabledSkin:Scale9Image = new Scale9Image(tabSelectedDisabledSkinTextures, properties.scale);
        tab.selectedDisabledSkin = selectedDisabledSkin;

        tab.defaultLabelProperties.elementFormat = theme.fonts.lightUIElementFormat;
        tab.defaultSelectedLabelProperties.elementFormat = theme.fonts.darkUIElementFormat;
        tab.disabledLabelProperties.elementFormat = theme.fonts.lightUIDisabledElementFormat;
        tab.selectedDisabledLabelProperties.elementFormat = theme.fonts.darkUIDisabledElementFormat;

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
