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

import feathers.controls.Button;
import feathers.controls.ImageLoader;
import feathers.controls.List;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.textures.Scale9Textures;

import starling.display.Quad;

public class ListFactory extends AbstractThemeFactory
{

    // Shared with SpinnerList etc.
    public var itemRendererUpSkinTextures:Scale9Textures;
    public var itemRendererSelectedSkinTextures:Scale9Textures;

    public function ListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        itemRendererUpSkinTextures = new Scale9Textures(atlas.getTexture("list-item-up-skin"),
                                                        SharedFactory.ITEM_RENDERER_SCALE9_GRID);
        itemRendererSelectedSkinTextures = new Scale9Textures(atlas.getTexture("list-item-selected-skin"),
                                                              SharedFactory.ITEM_RENDERER_SCALE9_GRID);
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(List, setListStyles);

        setStyle(DefaultGroupedListItemRenderer, setItemRendererStyles);
        setStyle(DefaultListItemRenderer, setItemRendererStyles);
    }

    public function setListStyles(list:List):void
    {
        theme.scroller.setScrollerStyles(list);
        var backgroundSkin:Quad = new Quad(properties.gridSize, properties.gridSize,
                                           SharedFactory.LIST_BACKGROUND_COLOR);
        list.backgroundSkin = backgroundSkin;
    }

    public function setItemRendererStyles(renderer:BaseDefaultItemRenderer):void
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

    public function setItemRendererAccessoryLabelRendererStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.elementFormat = theme.fonts.lightElementFormat;
    }

    public function setItemRendererIconLabelStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.elementFormat = theme.fonts.lightElementFormat;
    }

    public function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        image.textureScale = theme.scale;
        return image;
    }
}
}
