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
import com.teotigraphix.ui.component.VGroup;
import com.teotigraphix.ui.control.BackButtonControl;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.FontFactory;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.TextInput;
import feathers.layout.HorizontalLayout;

import flash.text.engine.CFFHinting;
import flash.text.engine.ElementFormat;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
import flash.text.engine.RenderingMode;

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

        setStyle(Button, setFormOkButtonStyles, FrameworkStyleNames.FORM_OK_BUTTON);
        setStyle(Button, setFormCancelButtonStyles, FrameworkStyleNames.FORM_CANCEL_BUTTON);
        setStyle(BackButtonControl, setBackButtonStyles, FrameworkStyleNames.BACK_BUTTON);

        setStyle(Label, setFormLabelStyles, FrameworkStyleNames.FORM_LABEL);
        setStyle(Label, setFormItemLabelStyles, FrameworkStyleNames.FORM_ITEM_LABEL);
        setStyle(Label, setFileExplorerTitleLabelStyles, FrameworkStyleNames.FILE_EXPLORER_TITLE_LABEL);

        setStyle(LayoutGroup, theme_dialogContentGroup, FrameworkStyleNames.DIALOG_SCREEN_CONTENT);
        setStyle(HGroup, theme_formButtonFooter, FrameworkStyleNames.DIALOG_BUTTON_FOOTER);

        setStyle(Label, theme_toolTipLabelStyles, FrameworkStyleNames.TOOL_TIP_LABEL);

        setStyle(TextInput, theme_textInputDarkStyles, FrameworkStyleNames.THEME_TEXT_INPUT_DARK);
        setStyle(Label, theme_formTitleDarkStyles, FrameworkStyleNames.THEME_FORM_TITLE_DARK);
    }

    private function theme_dialogContentGroup(group:LayoutGroup):void
    {
        group.minWidth = dp(300);
        VGroup(group).padding = dp(2);
        group.backgroundSkin = create9ScaleImage('background-popup-skin', 4, 4, 24, 24);
    }

    private function theme_textInputDarkStyles(textInput:TextInput):void
    {
        theme.textInput.setDarkTextInputStyles(textInput);
        textInput.padding = dp(8);
    }

    private function theme_formTitleDarkStyles(label:Label):void
    {
        theme.label.set_themeHeadingDarkStyles(label);
        label.padding = dp(16);
    }

    public function theme_toolTipLabelStyles(label:Label):void
    {
        theme.label.setLabelDarkStyles(label);
        label.padding = dp(8);
    }

    public function theme_formButtonFooter(group:HGroup):void
    {
        group.percentWidth = 100;
        group.padding = dp(8);
        group.gap = dp(8);
        group.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
        group.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
    }

    public function setFormOkButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        button.minWidth = dp(64);
        button.height = dp(36);
        button.paddingLeft = button.paddingRight = dp(8);
        button.label = "OK";
    }

    public function setFormCancelButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        button.minWidth = dp(64);
        button.height = dp(36);
        button.paddingLeft = button.paddingRight = dp(8);
        button.label = "CANCEL";
    }

    public function setBackButtonStyles(button:BackButtonControl):void
    {
        theme.button.setButtonStyles(button);
        button.stateToSkinFunction = null;
        button.defaultIcon = createImage("back-button-up-icon");
        button.downIcon = createImage("back-button-down-icon");
        button.hasLabelTextRenderer = false;

        button.paddingTop = size(4);
        button.paddingBottom = size(4);
        button.paddingLeft = size(4);
        button.paddingRight = size(4);
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
