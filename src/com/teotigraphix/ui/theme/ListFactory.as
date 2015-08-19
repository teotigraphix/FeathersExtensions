/**
 * Created by Teoti on 4/10/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Button;
import feathers.controls.ImageLoader;
import feathers.controls.List;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

import flash.geom.Rectangle;

import starling.display.Quad;

public class ListFactory extends AbstractThemeFactory
{
    protected static const LIST_BACKGROUND_COLOR:uint = 0x383430;
    protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 2, 82);

    protected var itemRendererUpSkinTextures:Scale9Textures;
    protected var itemRendererSelectedSkinTextures:Scale9Textures;

    public function ListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        itemRendererUpSkinTextures = new Scale9Textures(atlas.getTexture("list-item-up-skin"),
                                                        ITEM_RENDERER_SCALE9_GRID);
        itemRendererSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-item-selected-skin"),
                                                              ITEM_RENDERER_SCALE9_GRID);
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(List, setListStyles);

        setStyle(DefaultGroupedListItemRenderer, setItemRendererStyles);
        setStyle(DefaultListItemRenderer, setItemRendererStyles);
    }

    protected function setListStyles(list:List):void
    {
        theme.scrollers.setScrollerStyles(list);
        var backgroundSkin:Quad = new Quad(properties.gridSize, properties.gridSize, LIST_BACKGROUND_COLOR);
        list.backgroundSkin = backgroundSkin;
    }

    protected function setItemRendererStyles(renderer:BaseDefaultItemRenderer):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = itemRendererUpSkinTextures;
        skinSelector.defaultSelectedValue = itemRendererSelectedSkinTextures;
        skinSelector.setValueForState(itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
        skinSelector.displayObjectProperties =
        {
            width: properties.gridSize,
            height: properties.gridSize,
            textureScale: theme.scale
        };
        renderer.stateToSkinFunction = skinSelector.updateValue;

        renderer.defaultLabelProperties.elementFormat = theme.fonts.largeLightElementFormat;
        renderer.downLabelProperties.elementFormat = theme.fonts.largeDarkElementFormat;
        renderer.defaultSelectedLabelProperties.elementFormat = theme.fonts.largeDarkElementFormat;
        renderer.disabledLabelProperties.elementFormat = theme.fonts.largeDisabledElementFormat;

        renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.gap = properties.gutterSize;
        renderer.minGap = properties.gutterSize;
        renderer.iconPosition = Button.ICON_POSITION_LEFT;
        renderer.accessoryGap = Number.POSITIVE_INFINITY;
        renderer.minAccessoryGap = properties.gutterSize;
        renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
        renderer.minWidth = properties.gridSize;
        renderer.minHeight = properties.gridSize;
        renderer.minTouchWidth = properties.gridSize;
        renderer.minTouchHeight = properties.gridSize;

        renderer.accessoryLoaderFactory = imageLoaderFactory;
        renderer.iconLoaderFactory = imageLoaderFactory;
    }

    protected function setItemRendererAccessoryLabelRendererStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.elementFormat = theme.fonts.lightElementFormat;
    }

    protected function setItemRendererIconLabelStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.elementFormat = theme.fonts.lightElementFormat;
    }

    protected function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        image.textureScale = theme.scale;
        return image;
    }
}
}
