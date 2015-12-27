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

import com.teotigraphix.app.command.StartupFactory;
import com.teotigraphix.app.ui.IBootstrapApplication;
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.IFrameworkModel;
import com.teotigraphix.model.impl.AbstractApplicationSettings;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.impl.FileServiceImpl;
import com.teotigraphix.service.impl.LoggerImpl;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.screen.IScreenLauncher;
import com.teotigraphix.ui.screen.IScreenNavigator;
import com.teotigraphix.ui.screen.IScreenProvider;
import com.teotigraphix.ui.screen.impl.NullScreenLauncher;
import com.teotigraphix.ui.screen.impl.ScreenProviderImpl;

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
    //----------------------------------
    // Framework
    //----------------------------------

    public var $loggerClass:Class = LoggerImpl;
    public var $fileServiceClass:Class = FileServiceImpl;
    public var $screenProviderClass:Class = ScreenProviderImpl;

    //----------------------------------
    // App Config
    //----------------------------------

    public var applicationDescriptorClass:Class = ApplicationDescriptor;
    public var applicationSettingsClass:Class = AbstractApplicationSettings;

    public var startupFactoryClass:Class = StartupFactory;
    public var startupCommand:Class;

    public var applicationModelAPI:Class;
    public var applicationModelClass:Class;

    //----------------------------------
    // App UI
    //----------------------------------

    public var navigator:IScreenNavigator;

    public var applicationClass:Class;
    public var applicationMediatorClass:Class;

    //----------------------------------
    // App Controller
    //----------------------------------

    public var screenLauncherClass:Class = NullScreenLauncher;
    public var commandLauncherClass:Class;
    public var uiControllerClass:Class;

    //----------------------------------
    // Tests
    //----------------------------------

    private var _flashDispatcher:IEventDispatcher;

    public function get flashDispatcher():IEventDispatcher
    {
        if (_flashDispatcher == null)
            _flashDispatcher = new EventDispatcher();
        return _flashDispatcher;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

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
        injector.mapSingletonOf(ApplicationDescriptor, applicationDescriptorClass);

        trace("    FrameworkContext.configureCore()");
        configureCore();
        trace("    FrameworkContext.configureApplication()");

        injector.mapValue(IScreenNavigator, navigator);
        configureApplication();
        mediatorMap.mapView(applicationClass, applicationMediatorClass);

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

    protected function configureCore():void
    {
        injector.mapValue(Juggler, Starling.juggler);

        injector.mapValue(IBootstrapApplication, contextView);

        injector.mapSingletonOf(ILogger, $loggerClass);
        injector.mapSingletonOf(IFileService, $fileServiceClass);
        injector.mapSingletonOf(IScreenProvider, $screenProviderClass);

        injector.mapSingletonOf(StartupFactory, startupFactoryClass);
        injector.mapSingletonOf(IApplicationSettings, applicationSettingsClass);
        injector.mapSingletonOf(IScreenLauncher, screenLauncherClass);
        injector.mapSingletonOf(ICommandLauncher, commandLauncherClass);
        injector.mapSingletonOf(IUIController, uiControllerClass);
    }

    protected function configureApplication():void
    {
        trace("    FrameworkContext.configureService()");
        configureService();

        trace("    FrameworkContext.configureModel()");
        configureModel();

        trace("    FrameworkContext Configure StartupCommand Class");
        commandMap.mapEvent(ContextEventType.STARTUP, startupCommand);

        trace("    FrameworkContext.configureController()");
        configureController();

        trace("    FrameworkContext.configureApplicationModel()");
        var model:IFrameworkModel = injector.instantiate(applicationModelClass);
        mapApplicationModel(model);

        trace("    FrameworkContext.configureView()");
        configureView();
    }

    protected function mapApplicationModel(model:IFrameworkModel):void
    {
        injector.mapValue(IFrameworkModel, model);
        injector.mapValue(applicationModelAPI, model);
    }

    /**
     * Map all services.
     *
     * Services only listen to their own operation/external service events.
     *
     * Return values should always be IStepCommand or IStepSequence so clients can chain calls.
     */
    protected function configureService():void
    {
    }

    /**
     * Map all models.
     *
     * Models never listen to outside events, only to their internal operations.
     *
     * Models dispatch context level events for global application messaging.
     *
     * Models generally act as a proxy to internal state that could be serialized and deserialized
     * during the application's runtime.
     */
    protected function configureModel():void
    {
    }

    /**
     * Map all controllers and executable Commands in the application.
     *
     * Controllers handle context events that may be sent by UI, model or service operations.
     *
     * Controllers are the mediator to non-view/screen model changes.
     *
     * Controllers also can call commands and/or have public API that set off app actions.
     */
    protected function configureController():void
    {
    }

    /**
     * Map all UI view/mediator relationships.
     */
    protected function configureView():void
    {
    }

    protected function startupComplete():void
    {
        trace("    FrameworkContext.dispatchEventWith(STARTUP)");
        // launches the startupCommandClass
        dispatchEventWith(ContextEventType.STARTUP);
    }
}
}
