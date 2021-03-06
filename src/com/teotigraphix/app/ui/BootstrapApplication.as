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

package com.teotigraphix.app.ui
{

import flash.desktop.NativeApplication;
import flash.events.Event;

import feathers.core.DrawersApplication;
import feathers.events.FeathersEventType;

import org.robotlegs.starling.mvcs.Context;

import starling.events.Event;

/*

[Starling] Mask support requires 'depthAndStencil' to be enabled in the application descriptor.
[Starling] Initialization complete.
[Starling] Display Driver: DirectX9
new ApplicationContext()
CausticCoreDesktop extension context [object ExtensionContext]
BootstrapApplication.INITIALIZE()
BootstrapApplication.ADDED_TO_STAGE()
BootstrapNavigator.INITIALIZE()
BootstrapNavigator.ADDED_TO_STAGE()
    FrameworkContext.configureDescriptor()
    FrameworkContext.configureCore()
new CausticEngine()
CausticEngine.start()
ICausticCore.activate()
ICausticCore.initialize()
CausticCoreDesktopImpl isSupported true
CausticCoreDesktopImpl Initialize Success true
CausticCoreDesktopImpl Version 50397952
    FrameworkContext.configureApplication()
new MainMediator()
    FrameworkContext.startupComplete()
BootstrapNavigator.CREATION_COMPLETE()
MainMediator.onRegister()
BootstrapApplication.CREATION_COMPLETE()

============================================================
    [Next Frame] FrameworkContext.dispatchEventWith(STARTUP)
    ApplicationStartupCommand.dispatchWith(STARTUP_COMPLETE)
    ApplicationStartupCommand.dispatchWith(APPLICATION_COMPLETE)
    [Log] {MainMediator} , context_applicationCompleteHandler()
    [Log] {MainMediator} , Show initial screen

...

CausticEngine.stop()

private function setFocusListener():void
{
	stage.addEventListener(flash.events.Event.DEACTIVATE, deactivated);
}

private function deactivated(event:flash.events.Event):void
{
	stage.removeEventListener(flash.events.Event.DEACTIVATE, deactivated);
	stage.addEventListener(flash.events.Event.ACTIVATE, activated);

	starling.stop(true);  // <<<< TRUE
	Starling.current.nativeStage.frameRate = 0.1;
}

private function activated(event:flash.events.Event):void
{
	stage.addEventListener(flash.events.Event.DEACTIVATE, deactivated);
	stage.removeEventListener(flash.events.Event.ACTIVATE, activated);

	starling.start();
	Starling.current.nativeStage.frameRate = 60;
}
*/

public class BootstrapApplication extends DrawersApplication implements IBootstrapApplication
{
    private var _context:Context;

    public function get context():Context
    {
        return _context;
    }

    public function set context(value:Context):void
    {
        _context = value;
        _context.contextView = this;
    }

    public function BootstrapApplication()
    {
        addEventListener(starling.events.Event.ADDED, this_addedHandler);
        addEventListener(FeathersEventType.INITIALIZE, this_initializeHandler);
        addEventListener(FeathersEventType.CREATION_COMPLETE, this_creationCompleteHandler);
        addEventListener(starling.events.Event.ADDED_TO_STAGE, this_addedToStageHandler);
        addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this_removedToStageHandler);

        var application:NativeApplication = NativeApplication.nativeApplication;
        application.addEventListener(/*flash.events.Event.EXITING*/"exiting", closingHandler);
    }

    private function this_addedHandler(event:starling.events.Event):void
    {
        if (event.target != this)
            return;
        
        trace("BootstrapApplication.ADDED_TO_STAGE()");
        trace("Start context");
        context.startup();
        context.eventDispatcher.dispatchEventWith("showLoadingScreen");
        trace("<<<<<<<<<<<<<<<<<<<<<<< Start context");
    }

    private function this_initializeHandler(event:starling.events.Event):void
    {
        trace("BootstrapApplication.INITIALIZE()");
    }

    private function this_creationCompleteHandler(event:starling.events.Event):void
    {
        trace("BootstrapApplication.CREATION_COMPLETE()");
    }

    private function this_addedToStageHandler(event:starling.events.Event):void
    {
        trace("BootstrapApplication.ADDED_TO_STAGE()");
    }

    private function this_removedToStageHandler(event:starling.events.Event):void
    {
        trace("BootstrapApplication.REMOVED_FROM_STAGE()");
    }

    private function closingHandler(event:flash.events.Event):void
    {
    }
}
}
