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

package com.teotigraphix.ui.mediator
{

import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.event.DeviceModelEventType;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.ui.screen.IOrientationAware;

import feathers.controls.StackScreenNavigator;
import feathers.controls.StackScreenNavigatorItem;

import org.robotlegs.starling.core.ICommandMap;
import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.mvcs.Mediator;

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

    /**
     * Usually the MainNavigator stack component.
     */
    [Inject]
    public var root:DisplayObjectContainer;

    private var _commands:Vector.<Class>;

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
        super.onRegister();

        mapCommands();
        initializeView();
        setupViewListeners();
        setupContextListeners();

        addContextListener(DeviceModelEventType.ORIENTATION_CHANGE, context_orientationChange);

        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
    }

    override public function onRemove():void
    {
        super.onRemove();

        for each (var command:Class in _commands)
        {
            commandMap.unmapEvent(command["ID"], command);
        }

        _commands = null;
    }

    /**
     * Maps mediator specific commands.
     *
     * @see #mapCommand()
     */
    protected function mapCommands():void
    {
    }

    protected function initializeView():void
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

    private function context_orientationChange(event:Event, model:IDeviceModel):void
    {
        onOrientationChange(deviceModel.isLandscape, deviceModel.isTablet);
    }
}
}
