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

import com.teotigraphix.ui.component.SimpleButton;
import com.teotigraphix.ui.component.UIToggleButton;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.AssetMap;
import com.teotigraphix.ui.theme.CoreSkinNames;
import com.teotigraphix.ui.theme.SharedFactory;
import com.teotigraphix.ui.theme.framework.FrameworkStyleNames;
import com.teotigraphix.ui.theme.framework.skins.ButtonSkin;

import flash.display.DisplayObject;

import feathers.controls.Button;
import feathers.controls.ButtonState;
import feathers.controls.ToggleButton;
import feathers.controls.text.TextBlockTextRenderer;
import feathers.skins.ImageSkin;

import starling.textures.Texture;

public class ButtonFactory extends AbstractThemeFactory
{
    public var buttonUpSkinTexture:Texture;
    public var buttonDownSkinTexture:Texture;
    public var buttonDisabledSkinTexture:Texture;
    public var buttonSelectedUpSkinTexture:Texture;
    public var buttonSelectedDisabledSkinTexture:Texture;

    public var buttonRaisedUpSkinTexture:Texture;
    public var buttonRaisedDownSkinTexture:Texture;
    public var buttonRaisedDisabledSkinTexture:Texture;
    public var buttonRaisedSelectedUpSkinTexture:Texture;
    public var buttonRaisedSelectedDisabledSkinTexture:Texture;

    public function ButtonFactory(theme:AbstractTheme)
    {
        super(theme);
    }
    
    override public function initializeSkins(skins:Vector.<DisplayObject>):void
    {
        var buttonRaised:ButtonSkin = new ButtonSkin();
        buttonRaised.setSize(60, 60);
        buttonRaised.name = CoreSkinNames.BUTTON_RAISED_UP_SKIN;
        skins.push(buttonRaised);
        
        var buttonRaisedDown:ButtonSkin = new ButtonSkin();
        buttonRaisedDown.fillColor = 0x80DEEA;
        buttonRaisedDown.setSize(60, 60);
        buttonRaisedDown.name = CoreSkinNames.BUTTON_RAISED_DOWN_SKIN;
        skins.push(buttonRaisedDown);
        
        var buttonRaisedDisabled:ButtonSkin = new ButtonSkin();
        buttonRaisedDisabled.fillColor = 0xCCCCCC;
        buttonRaisedDisabled.setSize(60, 60);
        buttonRaisedDisabled.name = CoreSkinNames.BUTTON_RAISED_DISABLED_SKIN;
        skins.push(buttonRaisedDisabled);
        
        var buttonRaisedSelectedUp:ButtonSkin = new ButtonSkin();
        buttonRaisedSelectedUp.fillColor = 0x80DEEA;
        buttonRaisedSelectedUp.setSize(60, 60);
        buttonRaisedSelectedUp.name = CoreSkinNames.BUTTON_RAISED_SELECTED_UP_SKIN;
        skins.push(buttonRaisedSelectedUp);
        
        var buttonRaisedSelectedDisabled:ButtonSkin = new ButtonSkin();
        buttonRaisedSelectedDisabled.fillColor = 0xCCCCCC;
        buttonRaisedSelectedDisabled.setSize(60, 60);
        buttonRaisedSelectedDisabled.name = CoreSkinNames.BUTTON_RAISED_SELECTED_DISABLED_SKIN;
        skins.push(buttonRaisedSelectedDisabled);
    }
    
    override public function initializeTextures():void
    {
        buttonUpSkinTexture = getTexture(CoreSkinNames.BUTTON_UP_SKIN);
        buttonDownSkinTexture = getTexture(CoreSkinNames.BUTTON_DOWN_SKIN);
        buttonDisabledSkinTexture = getTexture(CoreSkinNames.BUTTON_DISABLED_SKIN);
        buttonSelectedUpSkinTexture = getTexture(CoreSkinNames.BUTTON_SELECTED_UP_SKIN);
        buttonSelectedDisabledSkinTexture = getTexture(CoreSkinNames.BUTTON_SELECTED_DISABLED_SKIN);
        
        buttonRaisedUpSkinTexture = getTexture(CoreSkinNames.BUTTON_RAISED_UP_SKIN, true);
        buttonRaisedDownSkinTexture = getTexture(CoreSkinNames.BUTTON_RAISED_DOWN_SKIN, true);
        buttonRaisedDisabledSkinTexture = getTexture(CoreSkinNames.BUTTON_RAISED_DISABLED_SKIN, true);
        buttonRaisedSelectedUpSkinTexture = getTexture(CoreSkinNames.BUTTON_RAISED_SELECTED_UP_SKIN, true);
        buttonRaisedSelectedDisabledSkinTexture = getTexture(CoreSkinNames.BUTTON_RAISED_SELECTED_DISABLED_SKIN, true);
    }

    override public function initializeStyleProviders():void
    {
        setStyle(Button, setButtonStyles);
        setStyle(SimpleButton, setSimpleButtonStyles);
        setStyle(ToggleButton, setButtonStyles);
        setStyle(UIToggleButton, setButtonStyles);

        // Button Raised
        setStyle(Button, setButtonRaisedStyles, FrameworkStyleNames.THEME_BUTTON_RAISED);
        setStyle(ToggleButton, setToggleButtonRaisedStyles, FrameworkStyleNames.THEME_BUTTON_RAISED);
        setStyle(TextBlockTextRenderer, setButtonLabelStyles, Button.DEFAULT_CHILD_STYLE_NAME_LABEL);
    }

    public function setBaseButtonStyles(button:Button):void
    {
        button.paddingTop = properties.smallGutterSize;
        button.paddingBottom = properties.smallGutterSize;
        button.paddingLeft = properties.gutterSize;
        button.paddingRight = properties.gutterSize;
        button.gap = properties.smallGutterSize;
        button.minGap = properties.smallGutterSize;
        button.minWidth = button.minHeight = properties.controlSize;
        button.minTouchWidth = properties.gridSize;
        button.minTouchHeight = properties.gridSize;
    }
    
    public function setButtonLabelStyles(textRenderer:TextBlockTextRenderer):void
    {
        textRenderer.elementFormat = font.darkUIElementFormat;
        textRenderer.disabledElementFormat = font.darkUIDisabledElementFormat;
    }
    
    public function setButtonStyles(button:Button):void
    {
        var skin:ImageSkin = new ImageSkin(buttonUpSkinTexture);
        skin.setTextureForState(ButtonState.DOWN, buttonDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, buttonDisabledSkinTexture);
        if(button is ToggleButton)
        {
            //for convenience, this function can style both a regular button 
            //and a toggle button
            skin.selectedTexture = buttonSelectedUpSkinTexture;
            skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, buttonSelectedDisabledSkinTexture);
        }
        skin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        skin.width = theme.properties.controlSize;
        skin.height = theme.properties.controlSize;
        button.defaultSkin = skin;
        setBaseButtonStyles(button);
    }

    public function setButtonRaisedStyles(button:Button):void
    {
        var skin:ImageSkin = new ImageSkin(buttonRaisedUpSkinTexture);
        skin.setTextureForState(ButtonState.DOWN, buttonRaisedDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, buttonRaisedDisabledSkinTexture);
        if(button is ToggleButton)
        {
            //for convenience, this function can style both a regular button 
            //and a toggle button
            skin.selectedTexture = buttonRaisedSelectedUpSkinTexture;
            skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, buttonRaisedSelectedDisabledSkinTexture);
        }
        skin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        skin.width = theme.properties.controlSize;
        skin.height = theme.properties.controlSize;
        button.defaultSkin = skin;
        setBaseButtonStyles(button);
        button.paddingBottom += 4; // shadow
    }

    public function setToggleButtonRaisedStyles(button:ToggleButton):void
    {
        var skin:ImageSkin = new ImageSkin(buttonRaisedUpSkinTexture);
        skin.setTextureForState(ButtonState.DOWN, buttonRaisedDownSkinTexture);
        skin.setTextureForState(ButtonState.DISABLED, buttonRaisedDisabledSkinTexture);
        if(button is ToggleButton)
        {
            //for convenience, this function can style both a regular button 
            //and a toggle button
            skin.selectedTexture = buttonRaisedSelectedUpSkinTexture;
            skin.setTextureForState(ButtonState.DISABLED_AND_SELECTED, buttonRaisedSelectedDisabledSkinTexture);
            
            var toggleButton:ToggleButton = ToggleButton(button);
            //toggleButton.defaultSelectedLabelProperties.elementFormat = getSelectedFont();
            //toggleButton.selectedDisabledLabelProperties.elementFormat = getSelectedDisabledFont();
        }
        skin.scale9Grid = SharedFactory.BUTTON_SCALE9_GRID;
        skin.width = theme.properties.controlSize;
        skin.height = theme.properties.controlSize;
        button.defaultSkin = skin;
        setBaseButtonStyles(button);
        button.paddingBottom += 4; // shadow
    }
    
    // TODO get rid of OR subclass the new SimpleButton
    public function setSimpleButtonStyles(button:SimpleButton):void
    {
        button.upSkin = AssetMap.createImage(CoreSkinNames.BUTTON_UP_SKIN);
        button.downSkin = AssetMap.createImage(CoreSkinNames.BUTTON_DOWN_SKIN);
        button.selectedSkin = AssetMap.createImage(CoreSkinNames.BUTTON_SELECTED_UP_SKIN);
    }
//    
//    /**
//     * Regular button font, darkElementFormat.
//     */
//    protected function getFont():ElementFormat
//    {
//        return font.darkElementFormat;
//    }
//
//    /**
//     * Regular disabled button font, lightElementFormat.
//     */
//    protected function getDisabledFont():ElementFormat
//    {
//        return font.disabledElementFormat;
//    }
//
//    /**
//     * Selected font, darkUIElementFormat.
//     */
//    protected function getSelectedFont():ElementFormat
//    {
//        return font.darkUIElementFormat;
//    }
//
//    /**
//     * Selected disabled font, darkUIDisabledElementFormat.
//     */
//    protected function getSelectedDisabledFont():ElementFormat
//    {
//        return font.darkUIDisabledElementFormat;
//    }
}
}
