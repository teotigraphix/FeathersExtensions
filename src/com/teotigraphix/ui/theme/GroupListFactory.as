/**
 * Created by Teoti on 8/28/2015.
 */
package com.teotigraphix.ui.theme
{

import feathers.controls.Button;
import feathers.controls.GroupedList;
import feathers.controls.ImageLoader;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.layout.VerticalLayout;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

import flash.geom.Rectangle;

import starling.display.Quad;

public class GroupListFactory extends AbstractThemeFactory
{
    protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;
    protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;
    // TODO
    protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 2, 82);
    protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
    protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
    protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);

    protected var itemRendererUpSkinTextures:Scale9Textures;
    protected var itemRendererSelectedSkinTextures:Scale9Textures;
    protected var insetItemRendererFirstUpSkinTextures:Scale9Textures;
    protected var insetItemRendererFirstSelectedSkinTextures:Scale9Textures;
    protected var insetItemRendererLastUpSkinTextures:Scale9Textures;
    protected var insetItemRendererLastSelectedSkinTextures:Scale9Textures;
    protected var insetItemRendererSingleUpSkinTextures:Scale9Textures;
    protected var insetItemRendererSingleSelectedSkinTextures:Scale9Textures;

    public function GroupListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        this.itemRendererUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-up-skin"),
                                                             ITEM_RENDERER_SCALE9_GRID);
        this.itemRendererSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-selected-skin"),
                                                                   ITEM_RENDERER_SCALE9_GRID);
        this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-up-skin"),
                                                                       INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
        this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-selected-skin"),
                                                                             INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
        this.insetItemRendererLastUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-up-skin"),
                                                                      INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
        this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-selected-skin"),
                                                                            INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
        this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-up-skin"),
                                                                        INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
        this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-selected-skin"),
                                                                              INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);

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
        theme.scrollers.setScrollerStyles(list);
        var backgroundSkin:Quad = new Quad(properties.gridSize, properties.gridSize, ListFactory.LIST_BACKGROUND_COLOR);
        list.backgroundSkin = backgroundSkin;
    }

    //see List section for item renderer styles

    protected function setGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR);

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightUIElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.lightUIDisabledElementFormat;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.smallGutterSize + properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;

        renderer.contentLoaderFactory = this.imageLoaderFactory;
    }

    protected function setGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
    {
        renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);

        renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
        renderer.contentLabelProperties.elementFormat = theme.fonts.lightElementFormat;
        renderer.contentLabelProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
        renderer.paddingTop = renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.smallGutterSize + properties.gutterSize;
        renderer.paddingRight = properties.gutterSize;

        renderer.contentLoaderFactory = this.imageLoaderFactory;
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
                                                             defaultSkinTextures:Scale9Textures,
                                                             selectedAndDownSkinTextures:Scale9Textures):void
    {
        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
        skinSelector.defaultValue = defaultSkinTextures;
        skinSelector.defaultSelectedValue = selectedAndDownSkinTextures;
        skinSelector.setValueForState(selectedAndDownSkinTextures, Button.STATE_DOWN, false);
        skinSelector.displayObjectProperties =
        {
            width: properties.gridSize,
            height: properties.gridSize,
            textureScale: properties.scale
        };
        renderer.stateToSkinFunction = skinSelector.updateValue;

        renderer.defaultLabelProperties.elementFormat = theme.fonts.largeLightElementFormat;
        renderer.downLabelProperties.elementFormat = theme.fonts.largeDarkElementFormat;
        renderer.defaultSelectedLabelProperties.elementFormat = theme.fonts.largeDarkElementFormat;
        renderer.disabledLabelProperties.elementFormat = theme.fonts.largeDisabledElementFormat;

        renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
        renderer.paddingTop = properties.smallGutterSize;
        renderer.paddingBottom = properties.smallGutterSize;
        renderer.paddingLeft = properties.gutterSize + properties.smallGutterSize;
        renderer.paddingRight = properties.gutterSize;
        renderer.gap = properties.gutterSize;
        renderer.minGap = properties.gutterSize;
        renderer.iconPosition = Button.ICON_POSITION_LEFT;
        renderer.accessoryGap = Number.POSITIVE_INFINITY;
        renderer.minAccessoryGap = properties.gutterSize;
        renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
        renderer.minWidth = renderer.minHeight = properties.gridSize;
        renderer.minTouchWidth = renderer.minTouchHeight = properties.gridSize;

        renderer.accessoryLoaderFactory = this.imageLoaderFactory;
        renderer.iconLoaderFactory = this.imageLoaderFactory;
    }

    protected function setInsetGroupedListMiddleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, this.itemRendererUpSkinTextures,
                                                   this.itemRendererSelectedSkinTextures);
    }

    protected function setInsetGroupedListFirstItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererFirstUpSkinTextures,
                                                   this.insetItemRendererFirstSelectedSkinTextures);
    }

    protected function setInsetGroupedListLastItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererLastUpSkinTextures,
                                                   this.insetItemRendererLastSelectedSkinTextures);
    }

    protected function setInsetGroupedListSingleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
    {
        this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererSingleUpSkinTextures,
                                                   this.insetItemRendererSingleSelectedSkinTextures);
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

        renderer.contentLoaderFactory = this.imageLoaderFactory;
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

        renderer.contentLoaderFactory = this.imageLoaderFactory;
    }

    // TODO
    protected function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        image.textureScale = properties.scale;
        return image;
    }
}
}
