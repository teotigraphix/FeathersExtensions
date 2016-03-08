/**
 * Created by Teoti on 8/28/2015.
 */
package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import flash.geom.Rectangle;

import feathers.controls.ButtonState;
import feathers.controls.GroupedList;
import feathers.controls.ImageLoader;
import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.layout.HorizontalAlign;
import feathers.layout.RelativePosition;
import feathers.layout.VerticalLayout;
import feathers.skins.ImageSkin;

import starling.display.Quad;
import starling.textures.Texture;

public class GroupedListFactory extends AbstractThemeFactory
{
    // TODO
    public static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 2, 82);
    public static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
    public static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
    public static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);

    protected var itemRendererUpSkinTexture:Texture;
    protected var itemRendererSelectedSkinTexture:Texture;
    protected var insetItemRendererFirstUpSkinTexture:Texture;
    protected var insetItemRendererFirstSelectedSkinTexture:Texture;
    protected var insetItemRendererLastUpSkinTexture:Texture;
    protected var insetItemRendererLastSelectedSkinTexture:Texture;
    protected var insetItemRendererSingleUpSkinTexture:Texture;
    protected var insetItemRendererSingleSelectedSkinTexture:Texture;

    public function GroupedListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        itemRendererUpSkinTexture = getTexture("list-item-up-skin");
        itemRendererSelectedSkinTexture = getTexture("list-item-selected-skin");
        insetItemRendererFirstUpSkinTexture = getTexture("list-inset-item-first-up-skin");
        insetItemRendererFirstSelectedSkinTexture = getTexture("list-inset-item-first-selected-skin");
        insetItemRendererLastUpSkinTexture = getTexture("list-inset-item-last-up-skin");
        insetItemRendererLastSelectedSkinTexture = getTexture("list-inset-item-last-selected-skin");
        insetItemRendererSingleUpSkinTexture = getTexture("list-inset-item-single-up-skin");
        insetItemRendererSingleSelectedSkinTexture = getTexture("list-inset-item-single-selected-skin");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(GroupedList, setGroupedListStyles);
        setStyle(GroupedList, setInsetGroupedListStyles, GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST);

        //header and footer renderers for grouped list
        setStyle(DefaultGroupedListHeaderOrFooterRenderer, setGroupedListHeaderRendererStyles);
        setStyle(DefaultGroupedListHeaderOrFooterRenderer,
                 setGroupedListFooterRendererStyles,
                 GroupedList.DEFAULT_CHILD_STYLE_NAME_FOOTER_RENDERER);
        setStyle(DefaultGroupedListHeaderOrFooterRenderer,
                 setInsetGroupedListHeaderRendererStyles,
                 GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER);
        setStyle(DefaultGroupedListHeaderOrFooterRenderer,
                 setInsetGroupedListFooterRendererStyles,
                 GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER);

    }

    protected function setGroupedListStyles(list:GroupedList):void
    {
        theme.scroller.setScrollerStyles(list);
        var backgroundSkin:Quad = new Quad(properties.gridSize, properties.gridSize,
                                           SharedFactory.LIST_BACKGROUND_COLOR);
        list.backgroundSkin = backgroundSkin;
    }

    //see List section for item renderer styles

    protected function setGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        renderer.backgroundSkin = new Quad(1, 1, SharedFactory.GROUPED_LIST_HEADER_BACKGROUND_COLOR);

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightUIElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.lightUIDisabledElementFormat;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.smallGutterSize + properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;

        renderer.contentLoaderFactory = imageLoaderFactory;
    }

    protected function setGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        renderer.backgroundSkin = new Quad(1, 1, SharedFactory.GROUPED_LIST_FOOTER_BACKGROUND_COLOR);

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
        renderer.paddingTop = renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.smallGutterSize + properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;

        renderer.contentLoaderFactory = imageLoaderFactory;
    }

    protected function setInsetGroupedListStyles(list:GroupedList):void
    {
        list.customItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER;
        list.customFirstItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER;
        list.customLastItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER;
        list.customSingleItemRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER;
        list.customHeaderRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER;
        list.customFooterRendererStyleName = GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER;

        var layout:VerticalLayout = new VerticalLayout();
        layout.useVirtualLayout = true;
        layout.padding = properties.smallGutterSize;
        layout.gap = 0;
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
        list.layout = layout;
    }

    protected function setInsetGroupedListItemRendererStyles(renderer:DefaultGroupedListItemRenderer, 
                                                             defaultSkinTexture:Texture, 
                                                             selectedAndDownSkinTexture:Texture, 
                                                             scale9Grid:Rectangle):void
    {
        var skin:ImageSkin = new ImageSkin(defaultSkinTexture);
        skin.selectedTexture = selectedAndDownSkinTexture;
        skin.setTextureForState(ButtonState.DOWN, selectedAndDownSkinTexture);
        skin.scale9Grid = scale9Grid;
        skin.width = properties.gridSize;
        skin.height = properties.gridSize;
        renderer.defaultSkin = skin;
        
        renderer.horizontalAlign = HorizontalAlign.LEFT;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize + properties.smallGutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.gap = properties.gutterSize;
        renderer.minGap = properties.gutterSize;
        renderer.iconPosition = RelativePosition.LEFT;
        renderer.accessoryGap = Number.POSITIVE_INFINITY;
        renderer.minAccessoryGap = properties.gutterSize;
        renderer.accessoryPosition = RelativePosition.RIGHT;
        renderer.minWidth = renderer.minHeight = properties.gridSize;
        renderer.minTouchWidth = renderer.minTouchHeight = properties.gridSize;
    }

    protected function setInsetGroupedListMiddleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, itemRendererUpSkinTexture,
                                                   itemRendererSelectedSkinTexture,
                                                   ITEM_RENDERER_SCALE9_GRID);
    }

    protected function setInsetGroupedListFirstItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, insetItemRendererFirstUpSkinTexture,
                                                   insetItemRendererFirstSelectedSkinTexture,
                                                   INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
    }

    protected function setInsetGroupedListLastItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, insetItemRendererLastUpSkinTexture,
                                                   insetItemRendererLastSelectedSkinTexture,
                                                   INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
    }

    protected function setInsetGroupedListSingleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, insetItemRendererSingleUpSkinTexture,
                                                   insetItemRendererSingleSelectedSkinTexture,
                                                   INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
    }

    protected function setInsetGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        var defaultSkin:Quad = new Quad(1, 1, 0xff00ff);
        defaultSkin.alpha = 0;
        renderer.backgroundSkin = defaultSkin;

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightUIElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.lightUIDisabledElementFormat;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize + properties.smallGutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.minWidth = properties.controlSize;
        renderer.minHeight = properties.controlSize;

        renderer.contentLoaderFactory = imageLoaderFactory;
    }

    protected function setInsetGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        var defaultSkin:Quad = new Quad(1, 1, 0xff00ff);
        defaultSkin.alpha = 0;
        renderer.backgroundSkin = defaultSkin;

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize + properties.smallGutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.minWidth = properties.controlSize;
        renderer.minHeight = properties.controlSize;

        renderer.contentLoaderFactory = imageLoaderFactory;
    }

    // TODO
    protected function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        return image;
    }
}
}
