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

import com.teotigraphix.ui.theme.*;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.Header;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.core.PopUpManager;
import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;

import starling.display.DisplayObject;
import starling.display.Quad;

public class AlertFactory extends AbstractThemeFactory
{
    protected static const THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON:String = "metal-works-mobile-alert-button-group-button";

    protected var backgroundPopUpSkinTextures:Scale9Textures;

    public function AlertFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeScale():void
    {
        super.initializeScale();
    }

    override public function initializeDimensions():void
    {
        super.initializeDimensions();
    }

    override public function initializeFonts():void
    {
        super.initializeFonts();
    }

    override public function initializeTextures():void
    {
        this.backgroundPopUpSkinTextures = new Scale9Textures(AssetMap.getTexture("background-popup-skin"),
                                                              ThemeProperties.DEFAULT_SCALE9_GRID);
    }

    override public function initializeGlobals():void
    {
        PopUpManager.overlayFactory = popUpOverlayFactory;
    }

    override public function initializeStyleProviders():void
    {
        setStyle(Alert, setAlertStyles);
        setStyle(ButtonGroup, setAlertButtonGroupStyles, Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP);
        setStyle(Button, setAlertButtonGroupButtonStyles, THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON);
        setStyle(Header, setHeaderWithoutBackgroundStyles, Alert.DEFAULT_CHILD_STYLE_NAME_HEADER);
        setStyle(TextBlockTextRenderer, setAlertMessageTextRendererStyles, Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE);
    }

    protected function setAlertStyles(alert:Alert):void
    {
        theme.scroller.setScrollerStyles(alert);

        var backgroundSkin:Scale9Image = new Scale9Image(backgroundPopUpSkinTextures, theme.scale);
        alert.backgroundSkin = backgroundSkin;

        alert.paddingTop = 0;
        alert.paddingRight = properties.gutterSize;
        alert.paddingBottom = properties.smallGutterSize;
        alert.paddingLeft = properties.gutterSize;
        alert.gap = properties.smallGutterSize;
        alert.maxWidth = properties.popUpFillSize;
        alert.maxHeight = properties.popUpFillSize;
    }

    //see Panel section for Header styles

    protected function setAlertButtonGroupStyles(group:ButtonGroup):void
    {
        group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
        group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_RIGHT;
        group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
        group.distributeButtonSizes = false;
        group.gap = properties.smallGutterSize;
        group.padding = properties.smallGutterSize;
        group.customButtonStyleName = THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON;
    }

    protected function setAlertButtonGroupButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        button.minWidth = 2 * properties.controlSize;
    }

    protected function setAlertMessageTextRendererStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.wordWrap = true;
        renderer.elementFormat = theme.fonts.darkElementFormat;
    }

    protected function setHeaderWithoutBackgroundStyles(header:Header):void
    {
        header.minWidth = properties.gridSize;
        header.minHeight = properties.gridSize;
        header.padding = properties.smallGutterSize;
        header.gap = properties.smallGutterSize;
        header.titleGap = properties.smallGutterSize;

        header.titleProperties.elementFormat = theme.fonts.headerDarkElementFormat;
    }

    protected static function popUpOverlayFactory():DisplayObject
    {
        var quad:Quad = new Quad(100, 100, SharedFactory.MODAL_OVERLAY_COLOR);
        quad.alpha = SharedFactory.MODAL_OVERLAY_ALPHA;
        return quad;
    }

}
}
