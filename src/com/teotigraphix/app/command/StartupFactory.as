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

import com.teotigraphix.service.async.IStepCommand;

import org.as3commons.async.command.ICommand;
import org.robotlegs.starling.core.IInjector;

public class StartupFactory
{
    [Inject]
    public var injector:IInjector;

    public function StartupFactory()
    {
    }

    /**
     * Can override to add properties to the startup result.
     */
    public function createResult():StartupResult
    {
        return new StartupResult();
    }

    public function createPrintAppVersionCommand():IStepCommand
    {
        return injector.instantiate(PrintAppVersionStep);
    }

    public function createDebugSetupCommand():IStepCommand
    {
        return injector.instantiate(SetupDebugCommand);
    }

    public function createStartCoreServicesCommand():IStepCommand
    {
        return injector.instantiate(StartupCoreServicesCommand);
    }

    public function createLoadLastProjectCommand():IStepCommand
    {
        return injector.instantiate(LoadLastProjectCommand);
    }
    
    public function createSetProjectCommand():IStepCommand
    {
        return injector.instantiate(SetProjectCommand);
    }
    
    public function createLoadProjectPreferencesCommand():IStepCommand
    {
        return injector.instantiate(LoadProjectPreferences);
    }
    
    public function createControllerStarupCommand():IStepCommand
    {
        return injector.instantiate(ControllerStarupCommand);
    }
    
    public function createFirstRunSaveCommand():ICommand
    {
        return injector.instantiate(FirstRunSaveCommand);
    }
}
}

import com.teotigraphix.app.command.StartupResult;
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.ICoreModel;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.impl.AbstractApplicationSettings;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.impl.FileServiceImpl;
import com.teotigraphix.service.impl.ProjectServiceImpl;
import com.teotigraphix.service.impl.ProjectServiceResult;
import com.teotigraphix.util.Files;

import flash.filesystem.File;

import org.as3commons.async.operation.event.OperationEvent;

import starling.core.Starling;

class PrintAppVersionStep extends StepCommand
{
    [Inject]
    public var descriptor:ApplicationDescriptor;

    public function PrintAppVersionStep()
    {
    }

    override public function execute():*
    {
        logger.startup("App VERSION", "V {0}", descriptor.version.toString());
        finished();
        return null;
    }
}

class StartupCoreServicesCommand extends StepCommand
{
    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var applicationSettings:IApplicationSettings;

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
        AbstractApplicationSettings(applicationSettings).startup();

        // Nothing yet
        ProjectServiceImpl(projectService).startup();

        finished();

        return null;
    }
}

final class LoadLastProjectCommand extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;

    override public function execute():*
    {
        logger.startup("LoadLastProjectCommand", "execute()");

        var command:IStepSequence = projectService.loadLastProjectAsync();
        command.addCompleteListener(this_completeHandler);
        command.execute();
    }

    private function this_completeHandler(event:OperationEvent):void
    {
        StartupResult(data).project = ProjectServiceResult(event.result).project;
        finished();
    }
}

final class SetProjectCommand extends StepCommand
{
    [Inject]
    public var projectModel:IProjectModel;
    
    override public function execute():*
    {
        logger.startup("SetProjectCommand", "setting current Project on IProjectModel");
        projectModel.project = StartupResult(data).project;
        finished();
    }
}

final class LoadProjectPreferences extends StepCommand
{
    [Inject]
    public var model:ICoreModel;

    override public function execute():*
    {
        logger.startup("LoadProjectPreferences", "execute()");

        var project:Project = model.projectModel.project;
        var resource:File = project.findResource(".preferences");

        if (!injector.hasMapping(IProjectPreferences))
        {
            logger.startup("LoadProjectPreferences", "IProjectPreferences is not mapped");
            return;
        }

        var preferences:IProjectPreferences = injector.getInstance(IProjectPreferences);

        if (resource.exists)
        {
            logger.startup("LoadProjectPreferences", "deserialize {0} ", resource.nativePath);
            preferences = Files.deserialize(resource);
        }

        model.setPreferences(preferences);

        finished(); 
        return null;
    }
}

final class SetupDebugCommand extends StepCommand
{
    [Inject]
    public var model:ICoreModel;

    override public function execute():*
    {
        if (model.descriptor.isDebug)
        {
            logger.startup("SetupDebugCommand", "Debug mode on");
            Starling.current.showStatsAt();
        }
        else
        {
            logger.startup("SetupDebugCommand", "Debug mode off");
        }

        finished();
        return super.execute();
    }
}

final class ControllerStarupCommand extends StepCommand
{
    [Inject]
    public var model:ICoreModel;
    
    override public function execute():*
    {
        logger.startup("CreateControllerStarupCommand", "excute");
        eventDispatcher.dispatchEventWith(ApplicationEventType.CONTROLLER_STARTUP);
        finished();
        return super.execute();
    }
}


final class FirstRunSaveCommand extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;
    
    override public function execute():*
    {
        logger.startup("FirstRunSaveCommand", "excute");
        
        var o:StartupResult = data as StartupResult;
        
        if (!o.project.exists)
        {
            logger.log("ApplicationStartupCommand.StartupStep", "Saving UnititledProject to disk");
            var sequence:IStepSequence = projectService.saveAsync();
            sequence.addCompleteListener(this_completeHandler);
            sequence.execute();
        }
        else
        {
            finished();
        }
        
        return super.execute();
    }
    
    private function this_completeHandler(event:OperationEvent):void
    {
        complete();
    }
}












