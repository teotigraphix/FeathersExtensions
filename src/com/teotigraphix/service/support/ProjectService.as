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

package com.teotigraphix.service.support
{

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.IProjectState;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.service.*;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.util.IDUtils;

import flash.filesystem.File;

use namespace sdk_internal;

public class ProjectService extends AbstractService implements IProjectService
{
    private static const TAG:String = "ProjectService";

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var descriptor:ApplicationDescriptor;

    public function ProjectService()
    {
    }

    public function startup():void
    {
        logger.startup(TAG, "startup()");
    }

    public function loadLastProject():IStepCommand
    {
        return injector.instantiate(LoadLastProjectCommand);
    }

    public function loadProjectAsync(file:File):IStepCommand
    {
        var command:LoadProjectCommand = new LoadProjectCommand(file);
        injector.injectInto(command);
        return command;
    }

    public function createProjectAsync(name:String, path:String):IStepCommand
    {
        var command:CreateProjectCommand = new CreateProjectCommand(name, path);
        injector.injectInto(command);
        return command;
    }

    public function saveAsync():IStepCommand
    {
        return injector.instantiate(SaveProjectCommand);
    }

    sdk_internal function save():void
    {
        var project:Project = projectModel.project;
        project.workingDirectory.createDirectory();
        project.workingTempDirectory.createDirectory();

        fileService.serialize(project, project.workingFile);
    }

    sdk_internal function createProject(name:String, path:String):Project
    {
        var project:Project = injector.instantiate(Project);
        var state:IProjectState = injector.getInstance(IProjectState);

        project.initialize(state,
                           IDUtils.createUID(),
                           path,
                           name,
                           descriptor.extension,
                           descriptor.version);
        return project;
    }
}
}

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.event.ProjectModelEventType;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.IPreferenceService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.support.ProjectService;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;
import org.as3commons.async.operation.event.OperationEvent;

import starling.events.EventDispatcher;

class CreateProjectCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var logger:ILogger;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var projectService:IProjectService;

    private var _name:String;
    private var _path:String;

    public function CreateProjectCommand(name:String, path:String)
    {
        _name = name;
        _path = path;
    }

    override public function execute():*
    {
        // previous UI interaction will have already asked to save the old project
        // unload last project
        projectModel.project = ProjectService(projectService).sdk_internal::createProject(_name, _path);

        var command:IAsyncCommand = projectService.saveAsync();
        command.addCompleteListener(onSaveCompleteHandler);
        command.execute();

        return null;
    }

    private function onSaveCompleteHandler(event:OperationEvent):void
    {
        complete(projectModel.project);
    }

}

class LoadProjectCommand extends StepCommand implements IAsyncCommand
{
    private static const TAG:String = "LoadProjectCommand";

    [Inject]
    public var logger:ILogger;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var preferenceService:IPreferenceService;

    [Inject]
    public var fileService:IFileService;

    private var _file:File;

    public function LoadProjectCommand(file:File)
    {
        _file = file;
    }

    override public function commit():*
    {
        logger.log(TAG, "commit()");

        if (_file.exists)
        {
            logger.log(TAG, "### Loading Project: " + _file.nativePath);
            var project:Project = fileService.deserialize(_file);
            projectModel.project = project;
        }
        else
        {
            logger.log(TAG, "### Using default Project: " + _file.nativePath);
        }

        return project;
    }

    override public function execute():*
    {
        logger.log(TAG, "execute()");
        var project:Project = commit();
        if (project != null)
        {
            complete(project);
        }
        else
        {
            dispatchErrorEvent(new Error("File does not exist"));
        }

        return null;
    }
}

class LoadLastProjectCommand extends StepCommand implements IAsyncCommand
{
    private static const TAG:String = "LoadLastProjectCommand";

    [Inject]
    public var logger:ILogger;

    [Inject]
    public var preferenceService:IPreferenceService;

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectService:IProjectService;

    public function LoadLastProjectCommand()
    {
    }

    override public function execute():*
    {
        logger.startup(TAG, "execute()");
        var project:Project = ProjectService(projectService).sdk_internal::createProject("UntitledProject", "");

        var path:String = preferenceService.appLastProjectPath;

        var file:File = project.workingFile;
        if (file.exists)
        {
            logger.startup(TAG, "### Loading Project: " + file.nativePath);
            project = fileService.deserialize(file);
        }
        else
        {
            logger.startup(TAG, "### Using default Project: " + file.nativePath);
        }

        complete(project);

        return null;
    }
}

class SaveProjectCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var logger:ILogger;

    [Inject]
    public var eventDispatcher:EventDispatcher;

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var projectService:IProjectService;

    public function SaveProjectCommand()
    {
    }

    override protected function checkComplete():Boolean
    {
        return projectModel.projectFile.exists;
    }

    override protected function cleanupComplete():void
    {
        super.cleanupComplete();
        eventDispatcher.dispatchEventWith(ProjectModelEventType.PROJECT_SAVE_COMPLETE, false, projectModel.project);
        logger.log("SaveProjectCommand", "Save project " + projectModel.projectFile.nativePath);
    }

    override public function execute():*
    {
        ProjectService(projectService).sdk_internal::save();
        monitorForComplete(projectModel.project, 300, 10);
        return null;
    }
}