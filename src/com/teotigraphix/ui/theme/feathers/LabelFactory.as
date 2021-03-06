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
import com.teotigraphix.ui.theme.framework.FrameworkStyleNames;

import feathers.controls.Label;

public class LabelFactory extends AbstractThemeFactory
{
    public function LabelFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeTextures():void
    {
        super.initializeTextures();
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        
        setStyle(Label, setLabelStyles);
        setStyle(Label, setLabelStyles, Label.ALTERNATE_STYLE_NAME_HEADING);
        setStyle(Label, setLabelStyles, Label.ALTERNATE_STYLE_NAME_DETAIL);
        
        setStyle(Label, setLabelStyles, FrameworkStyleNames.LABEL_16_DARK);
        setStyle(Label, setLabelStyles, FrameworkStyleNames.LABEL_20_DARK);
        
        setStyle(Label, setLabelStyles, FrameworkStyleNames.LABEL_UI_DARK);
        
        setStyle(Label, setLabelStyles, FrameworkStyleNames.THEME_LABEL);
        setStyle(Label, setLabelStyles, FrameworkStyleNames.THEME_LABEL_HEADING);
        setStyle(Label, setLabelStyles, FrameworkStyleNames.THEME_LABEL_ACTION_BAR);
        setStyle(Label, setLabelStyles, FrameworkStyleNames.THEME_LABEL_SUB_HEADING);
        
//        setStyle(Label, setLabelStyles);
//        setStyle(Label, setHeadingLabelStyles, Label.ALTERNATE_STYLE_NAME_HEADING);
//        setStyle(Label, setDetailLabelStyles, Label.ALTERNATE_STYLE_NAME_DETAIL);
//
//        setStyle(Label, set_label16Dark, FrameworkStyleNames.LABEL_16_DARK);
//        setStyle(Label, set_label20Dark, FrameworkStyleNames.LABEL_20_DARK);
//
//        setStyle(Label, set_themeDarkRegular, FrameworkStyleNames.LABEL_UI_DARK);
//
//        setStyle(Label, set_Styles, FrameworkStyleNames.THEME_LABEL);
//        setStyle(Label, set_themeHeadingStyles, FrameworkStyleNames.THEME_LABEL_HEADING);
//        setStyle(Label, set_themeActionBarStyles, FrameworkStyleNames.THEME_LABEL_ACTION_BAR);
//        setStyle(Label, set_themeSubHeadingStyles, FrameworkStyleNames.THEME_LABEL_SUB_HEADING);
    }

    //--------------------------------------------------------------------------
    // Theme
    //--------------------------------------------------------------------------

    public function set_label16Dark(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkUIElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    public function set_label20Dark(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkUIElementFormat; // is 20
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    public function set_themeDarkRegular(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkUIElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    public function set_Styles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    /**
     * Headings for from title dialogs.
     */
    public function set_themeHeadingDarkStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.headerElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function set_themeHeadingStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function set_themeActionBarStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.largeLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.largeUILightDisabledElementFormat;
    }

    public function set_themeSubHeadingStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkUIElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.darkUIDisabledElementFormat;
    }

    ///////

    /**
     * lightElementFormat
     * @param label
     */
    public function setLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    /**
     * largeDarkElementFormat
     * @param label
     */
    public function setHeadingLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.headerElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.headerDisabledElementFormat;
    }

    /**
     * smallLightElementFormat
     * @param label
     */
    public function setDetailLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.smallLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.smallDisabledElementFormat;
    }
}
}
