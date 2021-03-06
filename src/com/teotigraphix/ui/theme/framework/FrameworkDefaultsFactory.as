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
package com.teotigraphix.ui.theme.framework
{

import com.teotigraphix.ui.component.HGroup;
import com.teotigraphix.ui.control.BackButtonControl;
import com.teotigraphix.ui.dialog.Dialog;
import com.teotigraphix.ui.dialog.FileDialog;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.FontFactory;
import com.teotigraphix.ui.theme.SharedFactory;

import flash.text.engine.CFFHinting;
import flash.text.engine.ElementFormat;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
import flash.text.engine.RenderingMode;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.TextInput;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.display.Quad;

public class FrameworkDefaultsFactory extends AbstractThemeFactory
{
    public var darkFormLabelElementFormat:ElementFormat;
    public var lightFormLabelElementFormat:ElementFormat;

    /**
     * The FTE FontDescription used for form item text of a normal weight.
     */
    public var regularFormFontDescription:FontDescription;

    public function FrameworkDefaultsFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
    }

    override public function initializeFonts():void
    {
        super.initializeFonts();

        regularFormFontDescription = new FontDescription(
                FontFactory.FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL,
                FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);

        darkFormLabelElementFormat = new ElementFormat(
                regularFormFontDescription, theme.fonts.largeFontSize, FontFactory.DARK_TEXT_COLOR);

        lightFormLabelElementFormat = new ElementFormat(
                regularFormFontDescription, theme.fonts.largeFontSize, FontFactory.LIGHT_TEXT_COLOR);
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        setStyle(Dialog, set_DialogStyles);
        setStyle(Label, set_Dialog_TitleLabel_Styles,  "dialog-title-label");
        
       
        setStyle(FileDialog, set_DialogStyles);
        
        setStyle(Button, setFormButtonStyles, FrameworkStyleNames.FORM_BUTTON);
        setStyle(Button, setFormOkButtonStyles, FrameworkStyleNames.FORM_OK_BUTTON);
        setStyle(Button, setFormCancelButtonStyles, FrameworkStyleNames.FORM_CANCEL_BUTTON);
        setStyle(BackButtonControl, setBackButtonStyles, FrameworkStyleNames.BACK_BUTTON);


        setStyle(Label, setFormLabelStyles, FrameworkStyleNames.FORM_LABEL);
        setStyle(Label, setFormLabelDarkStyles, FrameworkStyleNames.FORM_LABEL_DARK);

        setStyle(Label, setFormItemLabelStyles, FrameworkStyleNames.FORM_ITEM_LABEL);
        setStyle(Label, setFileExplorerTitleLabelStyles, FrameworkStyleNames.FILE_EXPLORER_TITLE_LABEL);


        setStyle(HGroup, theme_formButtonFooter, FrameworkStyleNames.DIALOG_BUTTON_FOOTER);

        setStyle(Label, theme_toolTipLabelStyles, FrameworkStyleNames.TOOL_TIP_LABEL);

        setStyle(TextInput, theme_textInputDarkStyles, FrameworkStyleNames.THEME_TEXT_INPUT_DARK);
        setStyle(Label, theme_formTitleDarkStyles, FrameworkStyleNames.THEME_FORM_TITLE_DARK);

        setStyle(HGroup, set_divider, FrameworkStyleNames.THEME_DIVIDER);

        setStyle(LayoutGroup, set_ApplicationActionBar, FrameworkStyleNames.APPLICATION_ACTION_BAR);
    }

    private function set_ApplicationActionBar(actionBar:LayoutGroup):void
    {
        HorizontalLayout(actionBar.layout).verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

        actionBar.minWidth = properties.gridSize;
        actionBar.minHeight = 48;//properties.gridSize;

        var hl:HorizontalLayout = actionBar.layout as HorizontalLayout;
        hl.paddingLeft = hl.paddingRight = 8; //properties.smallGutterSize;
        //actionBar.gap = properties.smallGutterSize;
        //actionBar.titleGap = properties.smallGutterSize;

        actionBar.backgroundSkin = create9ScaleImage("application-header-skin", 5, 5, 50, 50);
    }


    private function set_divider(group:HGroup):void
    {
        group. percentWidth = 100;
        var quad:Quad = new Quad(1, 1, 0xCCCCCC);
        group.backgroundSkin = quad;
    }

    
    //----------------------------------
    // Dialog
    //----------------------------------

    
    private function set_DialogStyles(dialog:Dialog):void
    {
        var border:Number = 0;
        
        var hl:HorizontalLayout = dialog.header.layout as HorizontalLayout;
        hl.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
        
        dialog.titleLabel.styleName = "dialog-title-label";
        dialog.minWidth = 300;
        
        var dl:VerticalLayout = dialog.contentContainer.layout as VerticalLayout;
        dl.padding = 24 + border;
        dl.gap = 20;
        dl.lastGap = 24;
        
        var fl:HorizontalLayout = dialog.footer.layout as HorizontalLayout;
        fl.padding = 8 + border;
        fl.gap = 8;
        fl.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
        
        /*
        Padding around content area: 24dp
        Padding between title and body text: 20dp
        Padding around buttons: 8dp
        Button height: 36dp
        Action area height: 52dp
        Dialog elevation: 24dp
        */

        
        dialog.backgroundSkin = create9ScaleImageFrom(
            FrameworkSkinNames.BACKGROUND_POPUP_SHADOW_SKIN, 
            SharedFactory.BACKGROUND_POPUP_SHADOW_SKIN_SCALE9_GRID);
    }
    
    private function set_Dialog_TitleLabel_Styles(label:Label):void
    {
        theme.label.setHeadingLabelStyles(label);
    }
    
    
    ////
    
    private function theme_textInputDarkStyles(textInput:TextInput):void
    {
        theme.textInput.setDarkTextInputStyles(textInput);
        textInput.padding = 8;
    }

    private function theme_formTitleDarkStyles(label:Label):void
    {
        theme.label.set_themeHeadingDarkStyles(label);
        label.padding =16;
    }

    public function theme_toolTipLabelStyles(label:Label):void
    {
        //theme.label.setLabelDarkStyles(label);
        label.padding = 8;
    }

    public function theme_formButtonFooter(group:HGroup):void
    {
        group.percentWidth = 100;
        group.padding = 8;
        group.gap = 8;
        group.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
        group.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
    }

    public function setFormButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        
        button.defaultLabelProperties.elementFormat = font.darkUIElementFormat;
        button.disabledLabelProperties.elementFormat = font.darkUIDisabledElementFormat;
        
        button.minWidth = 64;
        button.height = 36;
        button.paddingLeft = button.paddingRight = 8;
    }
    
    public function setFormOkButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        
        button.defaultLabelProperties.elementFormat = font.darkUIElementFormat;
        button.disabledLabelProperties.elementFormat = font.darkUIDisabledElementFormat;
        
        button.minWidth = 64;
        button.height = 36;
        button.paddingLeft = button.paddingRight = 8;
        button.label = "OK";
    }

    public function setFormCancelButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        
        button.defaultLabelProperties.elementFormat = font.darkUIElementFormat;
        button.disabledLabelProperties.elementFormat = font.darkUIDisabledElementFormat;
        
        button.minWidth = 64;
        button.height = 36;
        button.paddingLeft = button.paddingRight = 8;
        button.label = "CANCEL";
    }

    public function setBackButtonStyles(button:BackButtonControl):void
    {
        theme.button.setButtonStyles(button);
        button.stateToSkinFunction = null;
        button.defaultIcon = createImage("back-button-up-icon");
        button.downIcon = createImage("back-button-down-icon");
        button.hasLabelTextRenderer = false;

        button.paddingTop = 4;
        button.paddingBottom = 4;
        button.paddingLeft = 4;
        button.paddingRight = 4;
        button.gap = 0;
        button.minGap = 0;
        button.minWidth = button.minHeight = 0;
        button.minTouchWidth = 0;
        button.minTouchHeight = 0;
    }

    //

    private function setFormLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = lightFormLabelElementFormat;
        label.textRendererProperties.disabledElementFormat = lightFormLabelElementFormat;
    }

    private function setFormLabelDarkStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = darkFormLabelElementFormat;
        label.textRendererProperties.disabledElementFormat = darkFormLabelElementFormat;
    }

    private function setFormItemLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkElementFormat;
    }

    private function setFileExplorerTitleLabelStyles(label:Label):void
    {
        theme.label.setHeadingLabelStyles(label);
    }
}
}
