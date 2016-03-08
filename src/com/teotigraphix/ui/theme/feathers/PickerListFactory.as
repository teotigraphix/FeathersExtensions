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

import feathers.controls.Button;
import feathers.controls.ButtonState;
import feathers.controls.List;
import feathers.controls.PickerList;
import feathers.controls.ToggleButton;
import feathers.controls.popups.CalloutPopUpContentManager;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.layout.RelativePosition;
import feathers.layout.VerticalLayout;
import feathers.skins.ImageSkin;

import starling.textures.Texture;

public class PickerListFactory extends AbstractThemeFactory
{
    public static const THEME_STYLE_NAME_PICKER_LIST_ITEM_RENDERER:String = "metal-works-mobile-picker-list-item-renderer";

    public var pickerListButtonIconTexture:Texture;
    public var pickerListButtonIconDisabledTexture:Texture;
    public var pickerListItemSelectedIconTexture:Texture;

    public function PickerListFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();

        pickerListButtonIconTexture = atlas.getTexture("picker-list-icon");
        pickerListButtonIconDisabledTexture = atlas.getTexture("picker-list-icon-disabled");
        pickerListItemSelectedIconTexture = atlas.getTexture("picker-list-item-selected-icon");
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(PickerList, setPickerListStyles);
        setStyle(Button, setPickerListButtonStyles, PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON);
        setStyle(ToggleButton, setPickerListButtonStyles, PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON);
    }

    public function setPickerListStyles(list:PickerList):void
    {
        //if (DeviceCapabilities.isTablet(Starling.current.nativeStage))
        //{
            list.popUpContentManager = new CalloutPopUpContentManager();
        //}
        //else
        //{
        //    var centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
        //    centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
        //            centerStage.marginLeft = properties.gutterSize;
        //    list.popUpContentManager = centerStage;
        //}

        var layout:VerticalLayout = new VerticalLayout();
        layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.useVirtualLayout = true;
        layout.gap = 0;
        layout.padding = 0;
        list.listProperties.layout = layout;
        list.listProperties.verticalScrollPolicy = List.SCROLL_POLICY_ON;

        //if (DeviceCapabilities.isTablet(Starling.current.nativeStage))
        //{
            list.listProperties.minWidth = properties.popUpFillSize;
            list.listProperties.maxHeight = properties.popUpFillSize;
        //}
        //else
        //{
        //    var backgroundSkin:Scale9Image = create9ScaleImage("background-popup-skin", 4, 4, 22, 22);
        //    backgroundSkin.width = properties.gridSize;
        //    backgroundSkin.height = properties.gridSize;
        //    list.listProperties.backgroundSkin = backgroundSkin;
        //    list.listProperties.padding = properties.smallGutterSize;
        //}

        //list.listProperties.customItemRendererStyleName = THEME_STYLE_NAME_PICKER_LIST_ITEM_RENDERER;
    }

    public function setPickerListButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);

        var icon:ImageSkin = new ImageSkin(this.pickerListButtonIconTexture);
        icon.selectedTexture = pickerListItemSelectedIconTexture;
        icon.setTextureForState(ButtonState.DISABLED, this.pickerListButtonIconDisabledTexture);
        button.defaultIcon = icon;
        
        button.gap = Number.POSITIVE_INFINITY;
        button.minGap = properties.gutterSize;
        button.iconPosition = RelativePosition.RIGHT;
    }

    public function setPickerListItemRendererStyles(renderer:BaseDefaultItemRenderer):void
    {
//        var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
//        skinSelector.defaultValue = theme.list.itemRendererUpSkinTextures;
//        skinSelector.setValueForState(theme.list.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
//        skinSelector.displayObjectProperties =
//        {
//            width: properties.gridSize,
//            height: properties.gridSize,
//            textureScale: properties.scale
//        };
//        renderer.stateToSkinFunction = skinSelector.updateValue;
//
//        var defaultSelectedIcon:Image = new Image(this.pickerListItemSelectedIconTexture);
//        defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = properties.scale;
//        renderer.defaultSelectedIcon = defaultSelectedIcon;
//
//        var defaultIcon:Quad = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
//        defaultIcon.alpha = 0;
//        renderer.defaultIcon = defaultIcon;
//
//        renderer.defaultLabelProperties.elementFormat = font.largeLightElementFormat;
//        renderer.downLabelProperties.elementFormat = font.largeDarkElementFormat;
//        renderer.disabledLabelProperties.elementFormat = font.largeDisabledElementFormat;
//
//        renderer.itemHasIcon = false;
//        renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
//        renderer.paddingTop = properties.smallGutterSize;
//        renderer.paddingBottom = properties.smallGutterSize;
//        renderer.paddingLeft = properties.gutterSize;
//        renderer.paddingRight = properties.gutterSize;
//        renderer.gap = Number.POSITIVE_INFINITY;
//        renderer.minGap = properties.gutterSize;
//        renderer.iconPosition = Button.ICON_POSITION_RIGHT;
//        renderer.accessoryGap = Number.POSITIVE_INFINITY;
//        renderer.minAccessoryGap = properties.gutterSize;
//        renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
//        renderer.minWidth = properties.gridSize;
//        renderer.minHeight = properties.gridSize;
//        renderer.minTouchWidth = properties.gridSize;
//        renderer.minTouchHeight = properties.gridSize;
    }
}
}