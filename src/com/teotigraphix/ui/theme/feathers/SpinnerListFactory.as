/**
 * Created by Teoti on 9/5/2015.
 */
package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import flash.geom.Rectangle;

import feathers.controls.SpinnerList;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.layout.HorizontalAlign;
import feathers.layout.RelativePosition;

import starling.display.Image;
import starling.display.Quad;
import starling.textures.Texture;

public class SpinnerListFactory extends AbstractThemeFactory
{
    protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(3, 9, 1, 70);
    protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER:String = "metal-works-mobile-spinner-list-item-renderer";

    protected var spinnerListSelectionOverlaySkinTexture:Texture;

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
        spinnerListSelectionOverlaySkinTexture = getTexture("spinner-list-selection-overlay-skin");
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
        theme.scroller.setScrollerStyles(list);
        
        var backgroundSkin:Image = new Image(shared.backgroundDarkBorderSkinTexture);
        backgroundSkin.scale9Grid = SharedFactory.SMALL_BACKGROUND_SCALE9_GRID;
        list.backgroundSkin = backgroundSkin;
        
        var selectionOverlaySkin:Image = new Image(this.spinnerListSelectionOverlaySkinTexture);
        selectionOverlaySkin.scale9Grid = SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID;
        list.selectionOverlaySkin = selectionOverlaySkin;
        
        list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
        
        list.paddingTop = properties.borderSize;
        list.paddingBottom = properties.borderSize;
    }

    protected function setSpinnerListItemRendererStyles(renderer:DefaultListItemRenderer):void
    {
        var defaultSkin:Quad = new Quad(1, 1, 0xff00ff);
        defaultSkin.alpha = 0;
        renderer.defaultSkin = defaultSkin;
        
        //renderer.customLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_LABEL;
        //renderer.customIconLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ICON_LABEL;
        //renderer.customAccessoryLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ACCESSORY_LABEL;
        
        renderer.horizontalAlign = HorizontalAlign.LEFT;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.gap = properties.gutterSize;
        renderer.minGap = properties.gutterSize;
        renderer.iconPosition = RelativePosition.LEFT;
        renderer.accessoryGap = Number.POSITIVE_INFINITY;
        renderer.minAccessoryGap = properties.gutterSize;
        renderer.accessoryPosition = RelativePosition.RIGHT;
        renderer.minWidth = properties.gridSize;
        renderer.minHeight = properties.gridSize;
        renderer.minTouchWidth = properties.gridSize;
        renderer.minTouchHeight = properties.gridSize;
    }

}
}
