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

package com.teotigraphix.app.config
{

import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.impl.FileServiceImpl;
import com.teotigraphix.service.impl.LoggerImpl;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.IScreenProvider;
import com.teotigraphix.ui.screen.core.AbstractScreenLauncher;
import com.teotigraphix.ui.screen.impl.NullScreenLauncher;
import com.teotigraphix.ui.screen.impl.ScreenProviderImpl;

import flash.errors.IllegalOperationError;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import org.robotlegs.starling.base.ContextEventType;
import org.robotlegs.starling.core.ICommandMap;
import org.robotlegs.starling.core.IInjector;
import org.robotlegs.starling.core.IMediatorMap;
import org.robotlegs.starling.core.IViewMap;
import org.robotlegs.starling.mvcs.Context;

import starling.animation.Juggler;
import starling.core.Starling;
import starling.display.DisplayObjectContainer;

public class FrameworkContext extends Context
{
    private var _flashDispatcher:IEventDispatcher;

    public function get flashDispatcher():IEventDispatcher
    {
        if (_flashDispatcher == null)
            _flashDispatcher = new EventDispatcher();
        return _flashDispatcher;
    }

    public function FrameworkContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
    {
        super(contextView, autoStartup);
    }

    // Called in the constructor
    override protected function mapInjections():void
    {
        //injector.mapValue(IReflector, reflector);
        //injector.mapValue(IInjector, injector);
        //injector.mapValue(EventDispatcher, eventDispatcher);
        //injector.mapValue(DisplayObjectContainer, contextView);
        //injector.mapValue(ICommandMap, commandMap);
        //injector.mapValue(IMediatorMap, mediatorMap);
        //injector.mapValue(IViewMap, viewMap);
        //injector.mapClass(IEventMap, EventMap)

        trace("FrameworkContext.mapInjections()");

        super.mapInjections();
    }

    override public function startup():void
    {
        injector.mapValue(IEventDispatcher, flashDispatcher);

        trace("    FrameworkContext.configureDescriptor()");
        configureDescriptor();
        trace("    FrameworkContext.configureCore()");
        configureCore();
        trace("    FrameworkContext.configureApplication()");
        configureApplication();
        trace("    FrameworkContext.startupComplete()");
        startupComplete();
    }

    public function getViewMap():IViewMap
    {
        return viewMap;
    }

    public function getMediatorMap():IMediatorMap
    {
        return mediatorMap;
    }

    public function getCommandMap():ICommandMap
    {
        return commandMap;
    }

    public function getInjector():IInjector
    {
        return injector;
    }

    protected function configureDescriptor():void
    {
        throw new IllegalOperationError("Implement FrameworkContext.configureDescriptor()");
    }

    protected function configureCore():void
    {
        injector.mapValue(Juggler, Starling.juggler);
        injector.mapSingletonOf(ILogger, LoggerImpl);
        injector.mapSingletonOf(IFileService, FileServiceImpl);
        injector.mapSingletonOf(IScreenProvider, ScreenProviderImpl);
        injector.mapSingletonOf(IScreenLauncher, NullScreenLauncher);
    }

    protected function configureApplication():void
    {
        throw new IllegalOperationError("Implement FrameworkContext.configureApplication()");
    }

    protected function startupComplete():void
    {
        trace("    FrameworkContext.dispatchEventWith(STARTUP)");
        dispatchEventWith(ContextEventType.STARTUP);
    }
}
}
