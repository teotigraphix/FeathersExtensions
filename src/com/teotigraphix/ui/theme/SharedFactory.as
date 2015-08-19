/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Button;
import feathers.controls.Scroller;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

public class SharedFactory extends AbstractThemeFactory
{

    public var backgroundSkinTextures:Scale9Textures;
    public var backgroundInsetSkinTextures:Scale9Textures;
    public var backgroundDisabledSkinTextures:Scale9Textures;
    public var backgroundFocusedSkinTextures:Scale9Textures;

    public function SharedFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        backgroundSkinTextures = new Scale9Textures(AssetMap.getTexture("background-skin"),
                                                    ThemeProperties.DEFAULT_SCALE9_GRID);
        backgroundDisabledSkinTextures = new Scale9Textures(AssetMap.getTexture("background-disabled-skin"),
                                                            ThemeProperties.DEFAULT_SCALE9_GRID);
        backgroundInsetSkinTextures = new Scale9Textures(AssetMap.getTexture("background-inset-skin"),
                                                         ThemeProperties.DEFAULT_SCALE9_GRID);
        // XXX wrong skin
        backgroundFocusedSkinTextures = new Scale9Textures(AssetMap.getTexture("background-disabled-skin"),
                                                           ThemeProperties.DEFAULT_SCALE9_GRID);
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
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.buttons.buttonUpSkinTextures;
        skinSelector.setValueForState(theme.buttons.buttonDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.setValueForState(theme.buttons.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
        skinSelector.displayObjectProperties =
        {
            width: theme.properties.controlSize,
            height: theme.properties.controlSize,
            textureScale: theme.scale
        };
        button.stateToSkinFunction = skinSelector.updateValue;
        button.hasLabelTextRenderer = false;

        button.minWidth = button.minHeight = theme.properties.controlSize;
        button.minTouchWidth = button.minTouchHeight = theme.properties.gridSize;
    }
}
}
