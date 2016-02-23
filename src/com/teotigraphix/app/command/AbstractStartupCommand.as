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

package com.teotigraphix.app.command
{

import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.controller.command.core.AbstractCommand;
import com.teotigraphix.service.async.IStepSequence;

import flash.events.Event;
import flash.events.IEventDispatcher;

import org.as3commons.async.operation.event.OperationEvent;

import starling.core.Starling;

public class AbstractStartupCommand extends AbstractCommand
{
    //--------------------------------------------------------------------------
    // Inject
    //--------------------------------------------------------------------------

    public function get flashDispatcher():IEventDispatcher 
    {
        return injector.getInstance(IEventDispatcher); 
    }
    
    [Inject]
    public var startupFactory:IStartupFactory;    
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function AbstractStartupCommand()
    {
    }

    //--------------------------------------------------------------------------
    // Overridden :: Methods
    //--------------------------------------------------------------------------

    override public function execute():void
    {
        var main:IStepSequence;
        main = sequence(startupFactory.createResult());
        addSteps(main);
        
        var factory:AbstractProjectStartupFactory = startupFactory as AbstractProjectStartupFactory;
        if (factory != null)
        {
            main.addCommand(factory.createControllerStarupCommand());
            main.addCommand(factory.createFirstRunSaveCommand());
        }
        
        main.addCompleteListener(sequence_completeHandler);
        main.execute();
    }

    //--------------------------------------------------------------------------
    // Protected :: Methods
    //--------------------------------------------------------------------------

    protected function addSteps(main:IStepSequence):void
    {
        main.addCommand(startupFactory.createPauseForUICreationCompleteCommand());
        main.addCommand(startupFactory.createPrintAppVersionCommand());
        main.addCommand(startupFactory.createDebugSetupCommand());
        main.addCommand(startupFactory.createStartCoreServicesCommand());
        addBeforeProjectSteps(main);
        
        var factory:AbstractProjectStartupFactory = startupFactory as AbstractProjectStartupFactory;
        if (factory != null)
        {
            main.addCommand(factory.createLoadLastProjectCommand());
            main.addCommand(factory.createLoadProjectPreferencesCommand());
            main.addCommand(factory.createSetProjectCommand());
            main.addCommand(factory.createEmptyProjectTempDirectoryCommand());
        }
    }
    
    protected function addBeforeProjectSteps(main:IStepSequence):void
    {
    }
    
    protected function sequence_completeHandler(event:OperationEvent):void
    {
        logger.startup("AbstractStartupCommand", "sequence_completeHandler()");
        dispatchApplicationComplete();
        logger.startup("AbstractStartupCommand", "EXIT");
    }
    
    protected function dispatchApplicationComplete():void
    {
        if (Starling.juggler != null)
        {
            Starling.juggler.delayCall(delayedComplete, 0.01);
        }
        else
        {
            logger.startup("AbstractStartupCommand", "dispatchWith(APPLICATION_COMPLETE)");
            dispatchWith(ApplicationEventType.APPLICATION_COMPLETE);
            flashDispatcher.dispatchEvent(new Event(ApplicationEventType.APPLICATION_COMPLETE));
        }
    }

    protected function delayedComplete():void
    {
        logger.startup("", "");
        logger.startup("", "============================================================");
        logger.startup("AbstractStartupCommand", "[Next Frame]");
        dispatchWith(ApplicationEventType.APPLICATION_COMPLETE);
    }
}
}
