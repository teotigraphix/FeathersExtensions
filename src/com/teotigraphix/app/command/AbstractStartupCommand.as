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
import com.teotigraphix.controller.command.AbstractCommand;
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

    [Inject]
    public var flashDispatcher:IEventDispatcher;

    [Inject]
    public var startupFactory:StartupFactory;

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
        var main:IStepSequence = sequence(startupFactory.createResult());
        addSteps(main);
        main.addCommand(startupFactory.createControllerStarupCommand());
        main.addCommand(startupFactory.createFirstRunSaveCommand());
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
        main.addCommand(startupFactory.createLoadLastProjectCommand());
        main.addCommand(startupFactory.createSetProjectCommand());
        main.addCommand(startupFactory.createLoadProjectPreferencesCommand());
        main.addCommand(startupFactory.createEmptyProjectTempDirectoryCommand());
        main.addCommand(startupFactory.createSessionRackStartupCommand());
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
            Starling.juggler.delayCall(delayedComplete, 1);
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
