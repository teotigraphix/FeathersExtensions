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

import com.teotigraphix.ui.template.main.ApplicationActionBar;
import com.teotigraphix.ui.template.main.ApplicationStatusBar;
import com.teotigraphix.ui.template.main.toolbar.ApplicationContentToolBar;
import com.teotigraphix.ui.template.main.toolbar.ApplicationToolBar;
import com.teotigraphix.ui.theme.AbstractTheme;
import com.teotigraphix.ui.theme.AbstractThemeFactory;
import com.teotigraphix.ui.theme.framework.skins.ActionBarSkin;
import com.teotigraphix.ui.theme.framework.skins.ApplicationContentToolBarSkin;
import com.teotigraphix.ui.theme.framework.skins.ApplicationStatusBarSkin;
import com.teotigraphix.ui.theme.framework.skins.ApplicationToolBarSkin;

import flash.display.DisplayObject;

import feathers.controls.Button;
import feathers.controls.ToggleButton;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

public class AbstractApplicationTemplateFactory extends AbstractThemeFactory
{
    public function AbstractApplicationTemplateFactory(theme:AbstractTheme)
    {
        super(theme);
    }

    override public function initializeSkins(skins:Vector.<DisplayObject>):void
    {
        var actionBar:ActionBarSkin = new ActionBarSkin();
        actionBar.setSize(60, 60);
        actionBar.name = FrameworkSkinNames.APPLICATION_HEADER_SKIN;
        actionBar.themeColor = theme.themeColor;
        
        var toolBar:ApplicationToolBarSkin = new ApplicationToolBarSkin();
        toolBar.setSize(48, 48);
        toolBar.name = FrameworkSkinNames.APPLICATION_TOOL_BAR_BACKGROUND_SKIN;
        toolBar.themeColor = theme.themeColor;
        
        var statusBar:ApplicationStatusBarSkin = new ApplicationStatusBarSkin();
        statusBar.setSize(48, 48);
        statusBar.name = FrameworkSkinNames.APPLICATION_STATUS_BAR_BACKGROUND_SKIN;
        statusBar.themeColor = theme.themeColor;
        
        var contentToolBar:ApplicationContentToolBarSkin = new ApplicationContentToolBarSkin();
        contentToolBar.setSize(48, 48);
        contentToolBar.name = FrameworkSkinNames.APPLICATION_CONTENT_BAR_BACKGROUND_SKIN;
        contentToolBar.themeColor = theme.themeColor;
        
        
        
        skins[skins.length] = actionBar;
        skins[skins.length] = toolBar;
        skins[skins.length] = contentToolBar;
        skins[skins.length] = statusBar;
    }

    override public function initializeStyleProviders():void
    {
        super.initializeStyleProviders();

        // ActionBar
        setStyle(ApplicationActionBar, setStyles);
        
        setStyle(ToggleButton, set_actionsButtonStyle, FrameworkStyleNames.ACTIONS_BUTTON);
        setStyle(Button, set_saveButtonStyle, FrameworkStyleNames.SAVE_BUTTON);
        setStyle(Button, set_logoStyle, FrameworkStyleNames.LOGO_BUTTON);
        
        // StatusBar
        setStyle(ApplicationStatusBar, set_statusBarStyles);
        
        // ToolBar
        setStyle(ApplicationToolBar, set_applicationToolBarStyle);
        setStyle(ApplicationContentToolBar, set_applicationContentToolBarStyle);
    }

    protected function set_applicationToolBarStyle(toolBar:ApplicationToolBar):void
    {
        toolBar.backgroundSkin = create9ScaleImage(
            FrameworkSkinNames.APPLICATION_TOOL_BAR_BACKGROUND_SKIN, 4, 4, 40, 40, true);
        
        var vl:VerticalLayout = toolBar.layout as VerticalLayout;
        vl.verticalAlign = "middle";
        vl.horizontalAlign = "center";
        vl.gap = 16;
        vl.padding = 8;
    }
    
    protected function set_applicationContentToolBarStyle(toolBar:ApplicationContentToolBar):void
    {
        toolBar.backgroundSkin = create9ScaleImage(
            FrameworkSkinNames.APPLICATION_CONTENT_BAR_BACKGROUND_SKIN, 4, 4, 40, 40, true);
        
        var vl:VerticalLayout = toolBar.layout as VerticalLayout;
        vl.verticalAlign = "middle";
        vl.horizontalAlign = "center";
        vl.gap = 16;
        vl.padding = 8;
    }
    
    protected function setStyles(actionBar:ApplicationActionBar):void
    {
        actionBar.backgroundSkin = create9ScaleImage(FrameworkSkinNames.APPLICATION_HEADER_SKIN, 5, 5, 50, 50, true);
        var hl:HorizontalLayout = actionBar.layout as HorizontalLayout;
        //header.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        hl.padding = 8;
        hl.gap = 16;
    }
    
    protected function set_statusBarStyles(statusBar:ApplicationStatusBar):void
    {
        statusBar.backgroundSkin = create9ScaleImage(
            FrameworkSkinNames.APPLICATION_STATUS_BAR_BACKGROUND_SKIN, 4, 4, 40, 40, true);
        
        statusBar.minHeight = 40;
        
        var hl:HorizontalLayout = statusBar.layout as HorizontalLayout;
        hl.padding = 4;
        hl.gap = 8;
    }    
    
    protected function set_actionsButtonStyle(button:ToggleButton):void
    {
        button.hasLabelTextRenderer = false;
        button.stateToSkinFunction = null;
        button.defaultIcon = createImage(FrameworkSkinNames.ACTIONS_UP_ICON);
        button.defaultSelectedIcon = createImage(FrameworkSkinNames.ACTIONS_SELECTED_ICON);
    }
    
    protected function set_saveButtonStyle(button:Button):void
    {
        button.hasLabelTextRenderer = false;
        button.stateToSkinFunction = null;
        button.defaultIcon = createImage(FrameworkSkinNames.ACTION_SAVE_ENABLED_ICON);
        button.disabledIcon = createImage(FrameworkSkinNames.ACTION_SAVE_DISABLED_ICON);
    }

    protected function set_logoStyle(button:Button):void
    {
        button.hasLabelTextRenderer = false;
        button.stateToSkinFunction = null;
        button.defaultIcon = createImage(FrameworkSkinNames.LOGO_60);
    }
}
}
