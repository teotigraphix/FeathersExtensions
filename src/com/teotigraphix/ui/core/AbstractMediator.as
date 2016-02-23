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

import com.teotigraphix.app.event.ApplicationEventData;
import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.IProjectPreferencesProvider;
import com.teotigraphix.frameworks.project.IProjectState;
import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.event.DeviceModelEventType;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.ui.IOrientationAware;
import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.IUIFactory;
import com.teotigraphix.ui.IUIState;
import com.teotigraphix.ui.component.event.FrameworkEventType;

import feathers.controls.StackScreenNavigator;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.core.ICommandMap;
import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Mediator;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.events.Event;

public class AbstractMediator extends Mediator
{
    [Inject]
    public var injector:IInjector;

    [Inject]
    public var commandMap:ICommandMap;

    [Inject]
    public var logger:ILogger;

    [Inject]
    public var deviceModel:IDeviceModel;
    
    [Inject]
    public var uiController:IUIController;
    
    [Inject]
    public var uiState:IUIState;
    
    [Inject]
    public var uiFactory:IUIFactory;
    
    [Inject]
    public var screenLauncher:IScreenLauncher;
    
    [Inject]
    public var projectPreferencesProvider:IProjectPreferencesProvider;
    
    /**
     * Usually the MainNavigator stack component.
     */
    [Inject]
    public var root:DisplayObjectContainer;

    private var _controls:Vector.<Class>;
    private var _commands:Vector.<Class>;
    
    private var _isBackEnabled:Boolean;
    
    protected var isInitializing:Boolean = true;

    public function get isBackEnabled():Boolean
    {
        return _isBackEnabled;
    }

    public function set isBackEnabled(value:Boolean):void
    {
        _isBackEnabled = value;
        if (_isBackEnabled)
        {
            addContextListener(ApplicationEventType.BACK_CHANGED, context_backChangedHandler);
        }
        else
        {
            removeContextListener(ApplicationEventType.BACK_CHANGED, context_backChangedHandler);
        }
    }
    
    private function get screens():IScreenLauncher
    {
        return injector.getInstance(IScreenLauncher);
    }

    public function AbstractMediator()
    {
    }

    /**
     * Called creationComplete on the view.
     *
     * <p>The view's creationComplete handler is called before the onRegister() call.</p>
     */
    override public function onRegister():void
    {
        isInitializing = true;
        
        super.onRegister();

        mapCommands();
        initializeView();
        setupViewListeners();
        setupContextListeners();
        
        addContextListener(DeviceModelEventType.ORIENTATION_CHANGE, context_orientationChange);
        addContextListener(FrameworkEventType.SCREEN_REDRAW, context_screenRedrawHandler);
        addContextListener(ApplicationEventType.STATE_CHANGED, context_stateChangedHandler);
        
        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
        
        isInitializing = false;
    }
    
    override public function onRemove():void
    {
        super.onRemove();

        for each (var command:Class in _commands)
        {
            commandMap.unmapEvent(command["ID"], command);
        }

        for each (var control:Class in _controls)
        {
            mediatorMap.unmapView(control);
        }

        _commands = null;
        _controls = null;
    }

    /**
     * Maps mediator specific commands.
     *
     * @see #mapCommand()
     */
    protected function mapCommands():void
    {
    }

    /**
     * Maps mediator specific controls.
     *
     * @see #mapControl()
     */
    protected function mapControls():void
    {
    }

    protected function initializeView():void
    {
    }
    
    protected function refreshView():void
    {
    }
    
    protected function setupViewListeners():void
    {
    }

    protected function setupContextListeners():void
    {
    }

    protected function onOrientationChange(isLandscape:Boolean, isTablet:Boolean):void
    {
        if (viewComponent is IOrientationAware)
            IOrientationAware(viewComponent).orientationChange(isLandscape, isTablet);
    }
    
    protected function onBackChanged():void
    {
        screens.back();
    }
    
    protected function mapCommand(command:Class):void
    {
        if (_commands == null)
            _commands = new <Class>[];

        _commands.push(command);

        commandMap.mapEvent(command["ID"], command);
    }

    ///**
    // * Called once when the mediator is first mapped.
    // *
    // * @param mediatorClass The mediator class mapped.
    // */
    //protected function onMapView(mediatorClass:*):void
    //{
    //}

    protected final function mapControl(viewOrClassName:*, mediatorClass:*, screenID:String = null):void
    {
        if (_controls == null)
            _controls = new <Class>[];

        if (!mediatorMap.hasMapping(viewOrClassName))
        {
            _controls.push(viewOrClassName);

            mediatorMap.mapView(viewOrClassName, mediatorClass);
        }
    }

    /**
     * Maps a sub screen view to the mediator map once.
     *
     * @param viewOrClassName the view class to instantiate.
     * @param mediatorClass The mediator class to instantiate after a view has been added to the display list.
     * @param screenID Optonal screenID to add the view as a screen of the main navigator.
     * @return Whether the view was mapped(true), the first time, code can run that registers other things.
     */
    protected final function mapChildView(viewOrClassName:*, mediatorClass:*, screenID:String = null):Boolean
    {
        if (!mediatorMap.hasMapping(viewOrClassName))
        {
            mediatorMap.mapView(viewOrClassName, mediatorClass);
            if (screenID != null)
            {
                if (root is StackScreenNavigator)
                {
                    var item:StackScreenNavigatorItem = new StackScreenNavigatorItem(viewOrClassName);
                    StackScreenNavigator(root).addScreen(screenID, item);
                }
            }
            //onMapView(mediatorClass);
            return true;
        }
        return false;
    }
    
    private function context_backChangedHandler(event:Event):void
    {
        if (_isBackEnabled && !ApplicationEventData(event.data).isBackHandled)
        {
            onBackChanged();
        }
    }
    
    protected function context_stateChangedHandler(event:Event, state:IProjectState):void
    {
        refreshView();
    }
    
    private function context_screenRedrawHandler(event:Event, data:ScreenRedrawData):void
    {
        var doc:DisplayObjectContainer = data.activeScreen as DisplayObjectContainer;
        if (doc == data.activeScreen || doc.contains(getViewComponent() as DisplayObject))
        {
            initializeView();
        }
    }
    
    private function context_orientationChange(event:Event, model:IDeviceModel):void
    {
        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
    }
}
}
