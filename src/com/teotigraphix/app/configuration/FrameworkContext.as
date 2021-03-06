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

package com.teotigraphix.app.configuration
{

import com.teotigraphix.app.command.AbstractProjectStartupFactory;
import com.teotigraphix.app.command.IStartupFactory;
import com.teotigraphix.app.command.UncaughtErrorCommand;
import com.teotigraphix.app.ui.BootstrapNavigator;
import com.teotigraphix.app.ui.IBootstrapApplication;
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.frameworks.midi.scale.ScaleData;
import com.teotigraphix.frameworks.midi.scale.ScaleItem;
import com.teotigraphix.frameworks.project.AbstractProjectConfigurator;
import com.teotigraphix.frameworks.project.IProjectConfigurator;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.frameworks.project.IProjectPreferencesProvider;
import com.teotigraphix.frameworks.project.IProjectStateProvider;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.frameworks.project.ProjectPreferencesProvider;
import com.teotigraphix.frameworks.project.ProjectStateProvider;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.ICoreModel;
import com.teotigraphix.model.IDeviceModel;
import com.teotigraphix.model.ISaveStrategy;
import com.teotigraphix.model.impl.AbstractApplicationSettings;
import com.teotigraphix.model.impl.DeviceModelImpl;
import com.teotigraphix.model.strategy.SaveStrategy;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.impl.FileServiceImpl;
import com.teotigraphix.service.impl.LoggerImpl;
import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.component.IScreenNavigator;
import com.teotigraphix.ui.state.ProjectPreferencesTemplateUI;

import flash.display.LoaderInfo;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.UncaughtErrorEvent;
import flash.net.registerClassAlias;

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
    registerClassAlias("$.0", Version);
    registerClassAlias("$.1", Project);
    registerClassAlias("$.2", IProjectPreferences);
    registerClassAlias("$.3", ProjectPreferencesTemplateUI);
    
    
    registerClassAlias("$.00", ScaleData);
    registerClassAlias("$.01", ScaleItem);
    
    //----------------------------------
    // Minimal Impl
    //----------------------------------

    public var applicationDescriptorClass:Class = ApplicationDescriptor;
    public var applicationSettingsClass:Class = AbstractApplicationSettings; // IFileService, ApplicationDescriptor
    public var $loggerClass:Class = LoggerImpl; // NO DEPS
    public var _fileServiceClass:Class = FileServiceImpl; // ApplicationDescriptor DEP
    public var $deviceModelClass:Class = DeviceModelImpl; // NO DEPS
    public var startupCommand:Class;

    //----------------------------------
    // Framework
    //----------------------------------

    //----------------------------------
    // App Config
    //----------------------------------

    public var startupFactoryClass:Class = AbstractProjectStartupFactory;

    public var applicationModelAPI:Class;
    public var applicationModelClass:Class;
    public var projectConfiguratorClass:Class = AbstractProjectConfigurator;
    
    //----------------------------------
    // App UI
    //----------------------------------

    private var _navigator:IScreenNavigator;

    public function get navigator():IScreenNavigator
    {
        return _navigator;
    }

    public function set navigator(value:IScreenNavigator):void
    {
        _navigator = value;
        if (_navigator is BootstrapNavigator)
        {
            BootstrapNavigator(_navigator).eventDispatcher = this;
        }
    }

    public var applicationClass:Class;
    public var applicationMediatorClass:Class;

    //----------------------------------
    // App Controller
    //----------------------------------

    public var screenLauncherClass:Class;
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

    /*
    Requirements

    - applicationDescriptorClass
    - navigator
    - applicationClass, applicationMediatorClass

     */

    /**
     * Template startup method.
     *
     * - #configureCore()
     * - #configureApplication()
     * - #startupComplete()
     */
    override public function startup():void
    {
        injector.mapValue(IEventDispatcher, flashDispatcher);

        trace("    FrameworkContext.configureDescriptor()");
        injector.mapSingletonOf(ApplicationDescriptor, applicationDescriptorClass);
        injector.mapSingletonOf(IApplicationPermissions, ApplicationPermissions);
        
        trace("    FrameworkContext.configureCore()");
        configureCoreNonDependencies();

        trace("    FrameworkContext.configureCore()");
        configureCore();

        if (navigator != null)
        {
            injector.mapValue(IScreenNavigator, navigator);
        }
        else
        {
            trace("    FrameworkContext [IScreenNavigator] NOT FOUND!!!");
        }

        trace("    FrameworkContext.configureApplication()");
        configureApplication();

        if (applicationClass != null && applicationMediatorClass != null)
        {
            mediatorMap.mapView(applicationClass, applicationMediatorClass);
        }
        else
        {
            trace("    FrameworkContext [applicationMediatorClass] NOT FOUND!!!");
        }

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

    protected function configureCoreNonDependencies():void
    {
        injector.mapValue(Juggler, Starling.juggler);
        injector.mapValue(IBootstrapApplication, contextView); 

        injector.mapSingletonOf(ILogger, $loggerClass);
        injector.mapSingletonOf(IFileService, _fileServiceClass);
        injector.mapSingletonOf(IApplicationSettings, applicationSettingsClass);
        injector.mapSingletonOf(IDeviceModel, $deviceModelClass);
        
        injector.mapSingletonOf(IProjectPreferencesProvider, ProjectPreferencesProvider);
        injector.mapSingletonOf(IProjectStateProvider, ProjectStateProvider);
        injector.mapSingletonOf(IProjectConfigurator, projectConfiguratorClass);
        
        if (Starling.current != null)
        {
            var loaderInfo:LoaderInfo = Starling.current.nativeStage.loaderInfo
            Starling.current.nativeStage.loaderInfo.content.loaderInfo.uncaughtErrorEvents.addEventListener(
                UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorEvents_uncaughtErrorEventHandler);
            
            commandMap.mapEvent(UncaughtErrorEvent.UNCAUGHT_ERROR, UncaughtErrorCommand);
        }
    }

    protected function configureCore():void
    {
        injector.mapSingletonOf(ISaveStrategy, SaveStrategy);
        
        injector.mapSingletonOf(IStartupFactory, startupFactoryClass);
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
        if (applicationModelClass != null)
        {
            var model:Object = injector.instantiate(applicationModelClass);
            if (model is ICoreModel)
            {
                injector.mapValue(ICoreModel, model);
            }
            
            if (applicationModelAPI != null) 
            {
                injector.mapValue(applicationModelAPI, model);
            }
        }

        trace("    FrameworkContext.configureView()");
        configureView();
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
    
    private function uncaughtErrorEvents_uncaughtErrorEventHandler(event:UncaughtErrorEvent):void
    {
        event.preventDefault();
        trace("    FrameworkContext.uncaughtErrorEvents_uncaughtErrorEventHandler()", event);
        var error:* = event.error;
        if(error is Error)
        {
            var errorError:Error = Error(error);
            dispatchEventWith(UncaughtErrorEvent.UNCAUGHT_ERROR, false, errorError.message);
        }
        else
        {
            dispatchEventWith(UncaughtErrorEvent.UNCAUGHT_ERROR, false, error);
        }
    }
}
}
