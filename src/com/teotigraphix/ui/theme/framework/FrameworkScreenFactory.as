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

import com.teotigraphix.ui.screen.impl.dialog.GetStringDialog;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;

import feathers.controls.Label;
import feathers.controls.TextInput;

public class FrameworkScreenFactory extends AbstractThemeFactory
{

    public function FrameworkScreenFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeStyleProviders():void
    {
        // GetStringDialog
        setStyle(GetStringDialog, setGetStringDialogStyles);
        setStyle(Label, setGetStringDialog_titleStyles, GetStringDialog.STYLE_TITLE_LABEL);
        setStyle(TextInput, setGetStringDialog_stringStyles, GetStringDialog.STYLE_STRING_TEXT_INPUT);
    }

    //----------------------------------
    // GetStringDialog
    //----------------------------------

    private function setGetStringDialogStyles(dialog:GetStringDialog):void
    {
    }

    private function setGetStringDialog_titleStyles(label:Label):void
    {
        theme.label.setHeadingLabelStyles(label);
    }

    private function setGetStringDialog_stringStyles(textInput:TextInput):void
    {
        theme.textInput.setTextInputStyles(textInput);
    }

}
}
