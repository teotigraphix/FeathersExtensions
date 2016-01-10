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
        setStyle(Label, setHeadingLabelStyles, Label.ALTERNATE_STYLE_NAME_HEADING);
        setStyle(Label, setDetailLabelStyles, Label.ALTERNATE_STYLE_NAME_DETAIL);

        setStyle(Label, set_Styles, FrameworkStyleNames.THEME_LABEL);
        setStyle(Label, set_themeHeadingStyles, FrameworkStyleNames.THEME_LABEL_HEADING);
        setStyle(Label, set_themeActionBarStyles, FrameworkStyleNames.THEME_LABEL_ACTION_BAR);
        setStyle(Label, set_themeSubHeadingStyles, FrameworkStyleNames.THEME_LABEL_SUB_HEADING);
    }

    //--------------------------------------------------------------------------
    // Theme
    //--------------------------------------------------------------------------

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
        label.textRendererProperties.elementFormat = theme.fonts.headerDarkElementFormat;
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
        label.textRendererProperties.elementFormat = theme.fonts.smallDarkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.smallDisabledElementFormat;
    }

    ///////

    /**
     * lightElementFormat
     * @param label
     */
    public function setLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.lightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function setLabelDarkStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.darkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    /**
     * largeLightElementFormat
     * @param label
     */
    public function setHeadingLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.largeLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.largeDisabledElementFormat;
    }

    /**
     * headerElementFormat
     * @param label
     */
    public function setHeading1LabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.headerElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.headerElementFormat;
    }

    /**
     * headerElementFormat
     * @param label
     */
    public function setHeading1DarkLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.headerDarkElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.headerDarkElementFormat;
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
