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
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.service.IApplicationService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepCommand;

import flash.events.Event;
import flash.events.IEventDispatcher;

import org.as3commons.async.command.CompositeCommandKind;
import org.as3commons.async.command.IAsyncCommand;
import org.as3commons.async.command.impl.CompositeCommand;
import org.as3commons.async.operation.event.OperationEvent;
import org.robotlegs.starling.base.ContextEventType;
import org.robotlegs.starling.mvcs.Command;

import starling.core.Starling;

public class AbstractStartupCommand extends Command
{
    [Inject]
    public var applicationService:IApplicationService;

    [Inject]
    public var projectService:IProjectService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var flashDispatcher:IEventDispatcher;

    private var _pendingProject:Project;

    public function AbstractStartupCommand()
    {
    }

    override public function execute():void
    {
        var composite:CompositeCommand = new CompositeCommand(CompositeCommandKind.SEQUENCE);
        addCommands(composite);
        composite.addCompleteListener(startupCompleteHandler);
        composite.execute();

        trace("    ApplicationStartupCommand.dispatchWith(STARTUP_COMPLETE)");
        dispatchWith(ContextEventType.STARTUP_COMPLETE);
    }

    protected function addCommands(sequence:CompositeCommand):void
    {
        var step1:IStepCommand = applicationService.startupCoreServices();
        step1.addCompleteListener(startupCoreServicesComplete);

        var step2:IAsyncCommand = projectService.loadLastProject();
        step2.addCompleteListener(loadLastProjectComplete);

        //var libraryAsync:IStepCommand = libraryModel.loadLibraryAsync();

        sequence.addCommand(step1);
        sequence.addCommand(step2);

        //sequence.addCommand(libraryAsync);
    }

    protected function dispatchApplicationComplete():void
    {
        if (Starling.juggler != null)
        {
            Starling.juggler.delayCall(delayedComplete, 1);
        }
        else
        {
            trace("    ApplicationStartupCommand.dispatchEventWith(APPLICATION_COMPLETE)");
            dispatchWith(ApplicationEventType.APPLICATION_COMPLETE);
            flashDispatcher.dispatchEvent(new Event(ApplicationEventType.APPLICATION_COMPLETE));
        }
    }

    protected function delayedComplete():void
    {
        trace("");
        trace("============================================================");
        trace("    [Next Frame] ApplicationStartupCommand.dispatchEventWith(APPLICATION_COMPLETE)");
        dispatchWith(ApplicationEventType.APPLICATION_COMPLETE);
    }

    protected function startupCoreServicesComplete(event:OperationEvent):void
    {
        trace("    ApplicationStartupCommand, startupCoreServicesComplete()")
    }

    protected function loadLastProjectComplete(event:OperationEvent):void
    {
        var project:Project = Project(event.result);
        _pendingProject = project;

        trace("    ApplicationStartupCommand, loadLastProjectComplete()")
    }

    protected function startupCompleteHandler(event:OperationEvent):void
    {
        trace("    ApplicationStartupCommand, startupCompleteHandler()");

        projectModel.project = _pendingProject;

        // XXX Subclasses dispatch when app load complete and ready to show UI
        //dispatchApplicationComplete();

        trace("    ApplicationStartupCommand, EXIT()")
    }
}
}
