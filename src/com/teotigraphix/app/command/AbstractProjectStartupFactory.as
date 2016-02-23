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

public class AbstractProjectStartupFactory extends AbstractStartupFactory
{
    public function AbstractProjectStartupFactory()
    {
    }
    
    override public function createStartCoreServicesCommand():IStepCommand
    {
        return injector.instantiate(StartupCoreServicesCommand);
    }

    public function createLoadLastProjectCommand():IStepCommand
    {
        return injector.instantiate(LoadLastProjectCommand);
    }
    
    public function createLoadProjectPreferencesCommand():IStepCommand
    {
        return injector.instantiate(LoadProjectPreferences);
    }
    
    public function createSetProjectCommand():IStepCommand
    {
        return injector.instantiate(SetProjectCommand);
    }
    
    public function createFirstRunSaveCommand():ICommand
    {
        return injector.instantiate(FirstRunSaveCommand);
    }
    
    public function createEmptyProjectTempDirectoryCommand():ICommand
    {
        return injector.instantiate(EmptyProjectTempDirectoryCommand);
    }
}
}

import com.teotigraphix.app.command.StartupResult;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.frameworks.project.IProjectPreferencesProvider;
import com.teotigraphix.frameworks.project.IProjectState;
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

import flash.events.Event;
import flash.filesystem.File;

import org.as3commons.async.operation.event.OperationEvent;

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

        complete();

        return null;
    }
}

final class LoadLastProjectCommand extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;

    override public function execute():*
    {
        logger.startup("$Startup.LoadLastProjectCommand", "execute()");

        var command:IStepSequence = projectService.loadLastProjectAsync();
        command.addCompleteListener(this_completeHandler);
        command.execute();
    }

    private function this_completeHandler(event:OperationEvent):void
    {
        StartupResult(data).project = ProjectServiceResult(event.result).project;
        complete();
    }
}

final class LoadProjectPreferences extends StepCommand
{
    [Inject]
    public var model:ICoreModel;

    [Inject]
    public var provider:IProjectPreferencesProvider;
    
    override public function execute():*
    {
        logger.startup("LoadProjectPreferences", "execute()");

        var project:Project = StartupResult(data).project;
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

        provider.provided = preferences;

        complete(); 
        return null;
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
        complete();
    }
}

final class FirstRunSaveCommand extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;
    
    [Inject]
    public var projectModel:IProjectModel;
    
    override public function execute():*
    {
        logger.startup("FirstRunSaveCommand", "excute");
        
        var o:StartupResult = data as StartupResult;
        
        var project:Project = o.project;
        var state:IProjectState = project.state;
        
        if (state.isFirstRun)
        {
            logger.log("ApplicationStartupCommand.StartupStep", "Saving UnititledProject to disk");
            var sequence:IStepSequence = projectService.saveAsync(projectModel.project);
            sequence.addCompleteListener(this_completeHandler);
            sequence.execute();
        }
        else
        {
            complete();
        }
        
        return super.execute();
    }
    
    private function this_completeHandler(event:OperationEvent):void
    {
        complete();
    }
}

final class EmptyProjectTempDirectoryCommand extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;
    
    private var tempDirectory:File;
    
    override public function execute():*
    {
        logger.startup("EmptyProjectTempDirectoryCommand", "excute");
        
        var o:StartupResult = data as StartupResult;
        
        if (o.project.exists)
        {
            tempDirectory = o.project.tempDirectory;
            if (tempDirectory.exists)
            {
                logger.startup("EmptyProjectTempDirectoryCommand", "Deleting contents of .temp");
                tempDirectory.addEventListener(Event.COMPLETE, this_completeHandler);
                tempDirectory.deleteDirectoryAsync(true);
            }
            else
            {
                tempDirectory.createDirectory();
                complete();
            }
        }
        else
        {
            complete();
        }
        
        return super.execute();
    }
    
    private function this_completeHandler(event:Event):void
    {
        logger.startup("EmptyProjectTempDirectoryCommand", ".temp delete complete");
        tempDirectory.createDirectory();
        complete();
    }
}
