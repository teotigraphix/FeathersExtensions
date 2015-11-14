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
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.service.async.StepSequence;

import flash.events.Event;
import flash.events.IEventDispatcher;

import org.as3commons.async.command.CompositeCommandKind;
import org.as3commons.async.command.impl.CompositeCommand;
import org.as3commons.async.operation.event.OperationEvent;
import org.robotlegs.starling.base.ContextEventType;
import org.robotlegs.starling.mvcs.Command;

import starling.core.Starling;

public class AbstractStartupCommand extends Command
{
    //--------------------------------------------------------------------------
    // Inject
    //--------------------------------------------------------------------------

    [Inject]
    public var projectService:IProjectService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var flashDispatcher:IEventDispatcher;

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
        var sequence:StepSequence = new StepSequence(CompositeCommandKind.SEQUENCE);
        addCommands(sequence);
        sequence.addCompleteListener(sequence_completeHandler);
        sequence.execute();

        trace("    ApplicationStartupCommand.dispatchWith(STARTUP_COMPLETE)");
        dispatchWith(ContextEventType.STARTUP_COMPLETE);
    }

    //--------------------------------------------------------------------------
    // Protected :: Methods
    //--------------------------------------------------------------------------

    protected function addCommands(sequence:CompositeCommand):void
    {
        var step1:IStepCommand = createStartCoreServicesCommand();
        step1.addCompleteListener(startupCoreServices_completeHandler);

        var step2:IStepCommand = createLoadLastProjectCommand();
        step2.addCompleteListener(loadLastProject_completeHandler);

        sequence.addCommand(step1);
        sequence.addCommand(step2);
    }

    protected function createStartCoreServicesCommand():IStepCommand
    {
        return injector.instantiate(StartupCoreServicesCommand);
    }

    protected function createLoadLastProjectCommand():IStepCommand
    {
        return projectService.loadLastProject();
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

    protected function startupCoreServices_completeHandler(event:OperationEvent):void
    {
        trace("    ApplicationStartupCommand, startupCoreServices_completeHandler()")
    }

    protected function loadLastProject_completeHandler(event:OperationEvent):void
    {
        var project:Project = Project(event.result);
        trace("    ApplicationStartupCommand, setting current Project");
        projectModel.project = project;

        trace("    ApplicationStartupCommand, loadLastProjectComplete()")
    }

    protected function sequence_completeHandler(event:OperationEvent):void
    {
        trace("    ApplicationStartupCommand, sequence_completeHandler()");

        // XXX Subclasses dispatch when app load complete and ready to show UI
        //dispatchApplicationComplete();

        trace("    ApplicationStartupCommand, EXIT()")
    }
}
}

import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IPreferenceService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.support.FileServiceImpl;
import com.teotigraphix.service.support.PreferenceServiceImpl;
import com.teotigraphix.service.support.ProjectServiceImpl;

class StartupCoreServicesCommand extends StepCommand
{
    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var preferenceService:IPreferenceService;

    [Inject]
    public var projectService:IProjectService;

    public function StartupCoreServicesCommand()
    {
    }

    override public function execute():*
    {
        logger.startup("StartupCoreServicesCommand", "execute()");

        // Creates the Documents/Application directory
        FileServiceImpl(fileService).startup();

        // Loads/creates binary application preferences map from fileService.preferenceBinFile
        PreferenceServiceImpl(preferenceService).startup();

        // Nothing yet
        ProjectServiceImpl(projectService).startup();

        complete(null);

        return null;
    }
}