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
    }

    public function setLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.lightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.disabledElementFormat;
    }

    public function setHeadingLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.largeLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.largeDisabledElementFormat;
    }

    public function setDetailLabelStyles(label:Label):void
    {
        label.textRendererProperties.elementFormat = theme.fonts.smallLightElementFormat;
        label.textRendererProperties.disabledElementFormat = theme.fonts.smallDisabledElementFormat;
    }
}
}
