/**
 * Created by Teoti on 3/28/2015.
 */
package com.teotigraphix.ui.theme
{

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

    internal static const MODAL_OVERLAY_COLOR:uint = 0x29241e;
    internal static const MODAL_OVERLAY_ALPHA:Number = 0.8;

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
        theme.scrollers.setScrollerStyles(alert);

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
        group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
        group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
        group.distributeButtonSizes = false;
        group.gap = properties.smallGutterSize;
        group.padding = properties.smallGutterSize;
        group.customButtonStyleName = THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON;
    }

    protected function setAlertButtonGroupButtonStyles(button:Button):void
    {
        theme.buttons.setButtonStyles(button);
        button.minWidth = 2 * properties.controlSize;
    }

    protected function setAlertMessageTextRendererStyles(renderer:TextBlockTextRenderer):void
    {
        renderer.wordWrap = true;
        renderer.elementFormat = theme.fonts.lightElementFormat;
    }

    protected function setHeaderWithoutBackgroundStyles(header:Header):void
    {
        header.minWidth = properties.gridSize;
        header.minHeight = properties.gridSize;
        header.padding = properties.smallGutterSize;
        header.gap = properties.smallGutterSize;
        header.titleGap = properties.smallGutterSize;

        header.titleProperties.elementFormat = theme.fonts.headerElementFormat;
    }

    protected static function popUpOverlayFactory():DisplayObject
    {
        var quad:Quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
        quad.alpha = MODAL_OVERLAY_ALPHA;
        return quad;
    }

}
}
