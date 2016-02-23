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
package com.teotigraphix.ui.core
{

import com.teotigraphix.controller.core.AbstractController;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.async.StepSequence;
import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.IUIState;
import com.teotigraphix.ui.component.IScreenNavigator;
import com.teotigraphix.ui.component.event.FrameworkEventType;
import com.teotigraphix.ui.control.BackButtonControl;
import com.teotigraphix.ui.control._mediators.BackButtonControlMediator;
import com.teotigraphix.ui.event.ScreenLauncherEventType;
import com.teotigraphix.ui.template.LoadingScreen;
import com.teotigraphix.ui.template.MainScreen;
import com.teotigraphix.ui.template._mediators.LoadingScreenMediator;
import com.teotigraphix.ui.template._mediators.MainScreenMediator;
import com.teotigraphix.ui.template.main.ApplicationActionBar;
import com.teotigraphix.ui.template.main.ApplicationActions;
import com.teotigraphix.ui.template.main.ApplicationLogoControl;
import com.teotigraphix.ui.template.main.ApplicationStatusBar;
import com.teotigraphix.ui.template.main.ApplicationToolBar;
import com.teotigraphix.ui.template.main.ProjectNameControl;
import com.teotigraphix.ui.template.main.ScreenToolBar;
import com.teotigraphix.ui.template.main.StatusToolBar;
import com.teotigraphix.ui.template.main.TransportToolBar;
import com.teotigraphix.ui.template.main._mediators.ApplicationActionBarMediator;
import com.teotigraphix.ui.template.main._mediators.ApplicationActionsMediator;
import com.teotigraphix.ui.template.main._mediators.ApplicationLogoControlMediator;
import com.teotigraphix.ui.template.main._mediators.ApplicationStatusBarMediator;
import com.teotigraphix.ui.template.main._mediators.ApplicationToolBarMediator;
import com.teotigraphix.ui.template.main._mediators.ProjectNameControlMediator;
import com.teotigraphix.ui.template.main._mediators.ScreenToolBarMediator;
import com.teotigraphix.ui.template.main._mediators.StatusToolBarMediator;
import com.teotigraphix.ui.template.main._mediators.TransportToolBarMediator;

import flash.errors.IllegalOperationError;
import flash.utils.getDefinitionByName;

import avmplus.getQualifiedClassName;

import feathers.controls.IScreen;
import feathers.controls.StackScreenNavigator;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.base.MediatorMap;
import org.robotlegs.starling.core.IMediatorMap;
import org.robotlegs.starling.core.IReflector;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.events.Event;

use namespace sdk_internal;

public class AbstractScreenLauncher extends AbstractController implements IScreenLauncher
{
    /**
     * data - screenID
     */
    public static const EVENT_SELECTED_CONTENT_INDEX_CHANGED:String = "selectedContentIndexChanged";

    public static const LOAD:String = "load";
    public static const SETTINGS:String = "settings";
    public static const MAIN:String = "main";
    
    //--------------------------------------------------------------------------
    // Private :: Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var _mediatorMap:IMediatorMap;

    [Inject]
    public var _navigator:IScreenNavigator;

    [Inject]
    public var root:DisplayObjectContainer;

    [Inject]
    public var reflector:IReflector;

    private var _popupMediatorMap:IMediatorMap;
    private var _applicationScreenID:String;

    protected var rootScreen:String;
    
    private var _uiState:IUIState;
    
    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    /**
     * Returns whether the Back button is enabled for a screen or certain UI state such as
     * a popup etc.
     */
    public function get isBackEnabled():Boolean
    {
        return false;
    }

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // isBackEnabled
    //----------------------------------

    public function get applicationScreenID():String 
    {
        return _applicationScreenID;
    }

    private var _contentNavigator:StackScreenNavigator;
    private var _contentScreenID:String;
    
    //----------------------------------
    // contentNavigator
    //----------------------------------
    
    public function get contentNavigator():StackScreenNavigator
    {
        return _contentNavigator;
    }
    
    public function set contentNavigator(value:StackScreenNavigator):void
    {
        _contentNavigator = value;
        
        if (_contentNavigator != null)
        {
            configureContent(_contentNavigator);
            configureContentControls(_mediatorMap);
        }
    }
    
    public function get contentScreenID():String
    {
        return _contentScreenID;
    }
    
    public function AbstractScreenLauncher()
    {
        rootScreen = MAIN;
    }

    override protected function onRegister():void
    {
        super.onRegister();
        
        addContextListener(ScreenLauncherEventType.SELECTED_CONTENT_INDEX_CHANGED, 
            context_selectedContentIndexChangedHandler);
        
        _popupMediatorMap = new MediatorMap(root.stage, injector, reflector);

        configureFramework(_navigator);
        configure(_navigator);
        configureControls(_mediatorMap);
        configurePopUpControls(_popupMediatorMap);
    }
    
    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------
    
    public function goToSettings():void
    {
        setApplicationScreen(SETTINGS);
    }
    
    public function goToLoad():void
    {
        setApplicationScreen(LOAD);
    }
    
    public function goToMain():void
    {
        setApplicationScreen(MAIN);
    }
    
    public function backTo(screenID:String):void
    {
        for (var i:int = 0; i < 10; i++)
        {
            var lastScreen:IScreen = IScreen(_navigator.popScreen());

            if (_navigator.activeScreenID == screenID)
            {
                setInternalScreenID(_navigator.activeScreenID);
                break;
            }
        }
    }

    public function back():void
    {
        if (rootScreen == _navigator.activeScreenID)
        {
            throw new IllegalOperationError("Already at root, back() cannot be called");
        }
        
        if (rootScreen == _navigator.activeScreenID && !sdk_internal::inExitAlert)
        {
            var sequence:StepSequence = new StepSequence();
            sequence.addCommand(injector.instantiate(ShowAlertExitStep));
            sequence.execute();
        }
        else
        {
            var lastScreen:IScreen = IScreen(_navigator.popScreen());
            logger.log("AbstractScreenLauncher", "Back screen [{0}] created as {1}", _navigator.activeScreenID,
                       lastScreen);

            setInternalScreenID(_navigator.activeScreenID);
        }
    }

    public function redraw():void
    {
        dispatchWith(FrameworkEventType.SCREEN_REDRAW, false, new ScreenRedrawData(_navigator.activeScreen));
    }
    
    protected function configureFramework(navigator:IScreenNavigator):void
    {
    }

    protected function configure(navigator:IScreenNavigator):void
    {
        var main:MainScreen = new MainScreen();
        
        navigator.addScreen(LOAD, create(LoadingScreen, LoadingScreenMediator));
        navigator.addScreen(MAIN, create(main, MainScreenMediator));
        //navigator.addScreen(SETTINGS, create(SettingsScreen, SettingsScreenMediator));
    }

    protected function configureControls(mediatorMap:IMediatorMap):void
    {
        mediatorMap.mapView(BackButtonControl, BackButtonControlMediator);
        
        // ActionBar
        mediatorMap.mapView(ApplicationActionBar, ApplicationActionBarMediator);
        mediatorMap.mapView(ApplicationActions, ApplicationActionsMediator);
        mediatorMap.mapView(ScreenToolBar, ScreenToolBarMediator);
        mediatorMap.mapView(ProjectNameControl, ProjectNameControlMediator);
        mediatorMap.mapView(ApplicationLogoControl, ApplicationLogoControlMediator);
        
        mediatorMap.mapView(ApplicationStatusBar, ApplicationStatusBarMediator);
        mediatorMap.mapView(ApplicationToolBar, ApplicationToolBarMediator);
        mediatorMap.mapView(TransportToolBar, TransportToolBarMediator);
        mediatorMap.mapView(StatusToolBar, StatusToolBarMediator);
    }

    protected function configurePopUpControls(mediatorMap:IMediatorMap):void
    {
    }

    //----------------------------------
    // contentNavigator
    //----------------------------------
    
    protected function configureContent(navigator:StackScreenNavigator):void
    {
    }
    
    protected function configureContentControls(mediatorMap:IMediatorMap):void
    {
    }
    
    protected function create(screen:Object,
                              mediatorClass:Class,
                              pushEvents:Object = null,
                              popEvent:String = null,
                              properties:Object = null):StackScreenNavigatorItem
    {
        if (mediatorClass != null)
        {
            _mediatorMap.mapView(screen, mediatorClass);
            if (screen is DisplayObject)
            {
                var clazz:Class = getDefinitionByName(getQualifiedClassName(screen)) as Class
                injector.mapValue(clazz, screen);
            }
        }

        var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(screen, pushEvents, popEvent, properties);
        return item;
    }

    /**
     * Resets the correct screenID from a back/pop event.
     *
     * @param screenID The current screen id.
     */
    protected function setInternalScreenID(screenID:String):void
    {
        _applicationScreenID = screenID;
    }

    sdk_internal var inExitAlert:Boolean = false;

    /**
     * Sets the current screenID for the application and passes the optional screen data to be
     * set int he IScreenProvider.
     *
     * @param screenID The String screenID.
     */
    sdk_internal function setApplicationScreen(screenID:String):IScreen
    {
        if (_applicationScreenID == screenID)
            return null;

        setInternalScreenID(screenID);

        logger.log("AbstractScreenLauncher", "creating screen [{0}]", screenID);
        var screen:IScreen = IScreen(_navigator.pushScreen(_applicationScreenID));
        injector.injectInto(screen);

        logger.log("AbstractScreenLauncher", "screen [{0}] created as {1}", screenID, screen);
        //dispatchWith(ApplicationModelEventType.APPLICATION_SCREEN_CHANGE, false, data);
        return screen;
    }
    
    sdk_internal function setContentScreen(screenID:String):IScreen
    {
        if (_contentScreenID == screenID)
            return null;
        
        _contentScreenID = screenID;
        
        logger.log("ScreenLauncher", "creating content screen [{0}]", screenID);
        var screen:IScreen = IScreen(_contentNavigator.pushScreen(_contentScreenID));
        injector.injectInto(screen);
        
        logger.log("ScreenLauncher", "content screen [{0}] created as {1}", screenID, screen);
        
        dispatchWith(EVENT_SELECTED_CONTENT_INDEX_CHANGED, false, screenID);
        
        return screen;
    }
    
    //--------------------------------------------------------------------------
    // Handlers
    //--------------------------------------------------------------------------
    
    private function context_selectedContentIndexChangedHandler(event:Event, index:int):void
    {
        _uiState = injector.getInstance(IUIState);
        
        var screenID:String = _uiState.applicationToolBarDataProvider.getItemAt(index).screenID;
        setContentScreen(screenID);
    }
}
}

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.core.AbstractScreenLauncher;

import flash.desktop.NativeApplication;

import feathers.controls.Alert;
import feathers.data.ListCollection;

import starling.events.Event;

use namespace sdk_internal;

final class ShowAlertExitStep extends StepCommand
{
    [Inject]
    public var screenLauncher:IScreenLauncher;

    override public function execute():*
    {
        AbstractScreenLauncher(screenLauncher).sdk_internal::inExitAlert = true;

        var alert:Alert = Alert.show("Are you sure you want to exit application?",
                                     "Exit Caustic Guide",
                                     new ListCollection([
                                         {label: "YES"}, {label: "NO"}
                                     ]));
        alert.addEventListener(Event.CLOSE, alert_closeHandler);
        return super.execute();
    }

    private function alert_closeHandler(event:Event):void
    {
        AbstractScreenLauncher(screenLauncher).sdk_internal::inExitAlert = false;

        if (event.data.label == "YES")
        {
            NativeApplication.nativeApplication.exit();
        }
        complete();
    }
}