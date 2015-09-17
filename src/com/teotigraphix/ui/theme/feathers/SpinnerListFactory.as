/**
 * Created by Teoti on 9/5/2015.
 */
package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.*;

import feathers.controls.Button;
import feathers.controls.SpinnerList;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.display.Scale9Image;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

import flash.geom.Rectangle;

public class SpinnerListFactory extends AbstractThemeFactory
{
    protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(3, 9, 1, 70);
    protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER:String = "metal-works-mobile-spinner-list-item-renderer";

    protected var spinnerListSelectionOverlaySkinTextures:Scale9Textures;

    public function SpinnerListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeScale():void
    {
        super.initializeScale();
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
        spinnerListSelectionOverlaySkinTextures = new Scale9Textures(atlas.getTexture("spinner-list-selection-overlay-skin"),
                                                                     SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID);
    }

    override public function initializeGlobals():void
    {
        super.initializeGlobals();
    }

    override public function initializeStage():void
    {
        super.initializeStage();
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(SpinnerList, setSpinnerListStyles);
        //the spinner list has a custom item renderer name defined by the theme
        setStyle(DefaultListItemRenderer, setSpinnerListItemRendererStyles,
                 THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER);
    }

    //-------------------------
    // SpinnerList
    //-------------------------

    protected function setSpinnerListStyles(list:SpinnerList):void
    {
        theme.list.setListStyles(list);
        list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
        list.selectionOverlaySkin = new Scale9Image(this.spinnerListSelectionOverlaySkinTextures, properties.scale);
    }

    protected function setSpinnerListItemRendererStyles(renderer:DefaultListItemRenderer):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = theme.list.itemRendererUpSkinTextures;
        skinSelector.displayObjectProperties =
        {
            width: properties.gridSize,
            height: properties.gridSize,
            textureScale: properties.scale
        };
        renderer.stateToSkinFunction = skinSelector.updateValue;

        renderer.defaultLabelProperties.elementFormat = theme.fonts.largeLightElementFormat;
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

        renderer.accessoryLoaderFactory = theme.list.imageLoaderFactory;
        renderer.iconLoaderFactory = theme.list.imageLoaderFactory;
    }

}
}
