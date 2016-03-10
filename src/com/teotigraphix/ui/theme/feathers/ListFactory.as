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

package com.teotigraphix.ui.theme.feathers
{

import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import feathers.controls.ButtonState;
import feathers.controls.ImageLoader;
import feathers.controls.List;
import feathers.controls.ToggleButton;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.layout.HorizontalAlign;
import feathers.layout.RelativePosition;
import feathers.skins.ImageSkin;

import starling.display.Quad;
import starling.textures.Texture;

public class ListFactory extends AbstractThemeFactory
{

    // Shared with SpinnerList etc.
    public var itemRendererUpSkinTexture:Texture;
    public var itemRendererSelectedSkinTexture:Texture;

    public function ListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        itemRendererUpSkinTexture = getTexture("list-item-up-skin");
        itemRendererSelectedSkinTexture = getTexture("list-item-selected-skin");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(List, setListStyles);

        setStyle(DefaultGroupedListItemRenderer, setItemRendererStyles);
        setStyle(DefaultListItemRenderer, setItemRendererStyles);
        
        setStyle(TextBlockTextRenderer, setItemRendererLabelStyles, BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_LABEL);
        setStyle(TextBlockTextRenderer, setItemRendererAccessoryLabelStyles, BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LABEL);
        setStyle(TextBlockTextRenderer, setItemRendererIconLabelStyles, BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ICON_LABEL);
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
        var skin:ImageSkin = new ImageSkin(itemRendererUpSkinTexture);
        skin.selectedTexture = itemRendererSelectedSkinTexture;
        skin.setTextureForState(ButtonState.DOWN, itemRendererSelectedSkinTexture);
        skin.scale9Grid = SharedFactory.ITEM_RENDERER_SCALE9_GRID;
        skin.width = properties.gridSize;
        skin.height = properties.gridSize;
        renderer.defaultSkin = skin;
        
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
    
    public function setItemRendererLabelStyles(textRenderer:TextBlockTextRenderer):void
    {
        textRenderer.elementFormat = font.largeDarkElementFormat;
        textRenderer.disabledElementFormat = font.largeDisabledElementFormat;
        textRenderer.selectedElementFormat = font.largeDarkElementFormat;
        textRenderer.setElementFormatForState(ToggleButton.STATE_DOWN, font.largeDarkElementFormat);
    }
    
    public function setItemRendererAccessoryLabelStyles(textRenderer:TextBlockTextRenderer):void
    {
        textRenderer.elementFormat = font.lightElementFormat;
        textRenderer.disabledElementFormat = font.disabledElementFormat;
        textRenderer.selectedElementFormat = font.darkElementFormat;
        textRenderer.setElementFormatForState(ToggleButton.STATE_DOWN, font.darkElementFormat);
    }
    
    public function setItemRendererIconLabelStyles(textRenderer:TextBlockTextRenderer):void
    {
        textRenderer.elementFormat = font.lightElementFormat;
        textRenderer.disabledElementFormat = font.disabledElementFormat;
        textRenderer.selectedElementFormat = font.darkElementFormat;
        textRenderer.setElementFormatForState(ToggleButton.STATE_DOWN, font.darkElementFormat);
    }

    public function imageLoaderFactory():ImageLoader
    {
        var image:ImageLoader = new ImageLoader();
        return image;
    }
}
}
