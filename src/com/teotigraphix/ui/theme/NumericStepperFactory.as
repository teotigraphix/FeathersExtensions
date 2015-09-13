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

package com.teotigraphix.ui.theme
{

import feathers.controls.Button;
import feathers.controls.NumericStepper;
import feathers.controls.TextInput;
import feathers.controls.text.TextBlockTextEditor;
import feathers.display.Scale9Image;

public class NumericStepperFactory extends AbstractThemeFactory
{

    public function NumericStepperFactory(theme:AbstractTheme)
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

        setStyle(NumericStepper, setNumericStepperStyles);
        setStyle(TextInput, setNumericStepperTextInputStyles, NumericStepper.DEFAULT_CHILD_STYLE_NAME_TEXT_INPUT);
        setStyle(Button, setNumericStepperButtonStyles, NumericStepper.DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON);
        setStyle(Button, setNumericStepperButtonStyles, NumericStepper.DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON);
    }

    public function setNumericStepperStyles(stepper:NumericStepper):void
    {
        stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL;
        stepper.incrementButtonLabel = "+";
        stepper.decrementButtonLabel = "-";
    }

    public function setNumericStepperTextInputStyles(input:TextInput):void
    {
        var backgroundSkin:Scale9Image = new Scale9Image(theme.shared.backgroundSkinTextures, properties.scale);
        backgroundSkin.width = properties.controlSize;
        backgroundSkin.height = properties.controlSize;
        input.backgroundSkin = backgroundSkin;

        var backgroundDisabledSkin:Scale9Image = new Scale9Image(theme.shared.backgroundDisabledSkinTextures,
                                                                 properties.scale);
        backgroundDisabledSkin.width = properties.controlSize;
        backgroundDisabledSkin.height = properties.controlSize;
        input.backgroundDisabledSkin = backgroundDisabledSkin;

        var backgroundFocusedSkin:Scale9Image = new Scale9Image(theme.shared.backgroundFocusedSkinTextures,
                                                                properties.scale);
        backgroundFocusedSkin.width = properties.controlSize;
        backgroundFocusedSkin.height = properties.controlSize;
        input.backgroundFocusedSkin = backgroundFocusedSkin;

        input.minWidth = input.minHeight = properties.controlSize;
        input.minTouchWidth = input.minTouchHeight = properties.gridSize;
        input.gap = properties.smallGutterSize;
        input.padding = properties.smallGutterSize;
        input.isEditable = false;
        input.textEditorFactory = stepperTextEditorFactory;
        input.textEditorProperties.elementFormat = theme.fonts.lightUIElementFormat;
        input.textEditorProperties.disabledElementFormat = theme.fonts.lightUIDisabledElementFormat;
        input.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
    }

    public function setNumericStepperButtonStyles(button:Button):void
    {
        theme.button.setButtonStyles(button);
        button.keepDownStateOnRollOut = true;
    }

    protected static function stepperTextEditorFactory():TextBlockTextEditor
    {
        //we're only using this text editor in the NumericStepper because
        //isEditable is false on the TextInput. this text editor is not
        //suitable for mobile use if the TextInput needs to be editable
        //because it can't use the soft keyboard or other mobile-friendly UI
        return new TextBlockTextEditor();
    }

}
}
