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

package com.teotigraphix.service.impl
{

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.IProjectState;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.service.*;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepSequence;
import com.teotigraphix.util.IDUtils;

import flash.filesystem.File;

use namespace sdk_internal;

public class ProjectServiceImpl extends AbstractService implements IProjectService
{
    private static const TAG:String = "ProjectService";

    //--------------------------------------------------------------------------
    // Public Inject :: Variables
    //--------------------------------------------------------------------------

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var descriptor:ApplicationDescriptor;

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function ProjectServiceImpl()
    {
    }

    public function startup():void
    {
        logger.startup(TAG, "startup()");
    }

    //--------------------------------------------------------------------------
    // Public IProjectService :: Methods
    //--------------------------------------------------------------------------

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

    public function saveAsync():IStepSequence
    {
        var sequence:IStepSequence = new StepSequence();
        // saves internal state before the Project is written to disk
        var step1:IStepSequence = projectModel.project.saveAsync();
        // save the Project to disk
        var step2:IStepCommand = injector.instantiate(SaveProjectCommand);
        sequence.addCommand(step1);
        sequence.addCommand(step2);
        return sequence;
    }

    //--------------------------------------------------------------------------
    // sdk_internal :: Methods
    //--------------------------------------------------------------------------

    sdk_internal function save():void
    {
        var project:Project = projectModel.project;
        project.workingDirectory.createDirectory();
        project.workingTempDirectory.createDirectory();

        fileService.serialize(project.workingFile, project);
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

        logger.log(TAG, "### Project.create()");
        project.create();

        return project;
    }
}
}

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.event.ProjectModelEventType;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IPreferenceService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.impl.ProjectServiceImpl;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;
import org.as3commons.async.operation.event.OperationEvent;

class CreateProjectCommand extends StepCommand implements IAsyncCommand
{
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
        projectModel.project = ProjectServiceImpl(projectService).sdk_internal::createProject(_name, _path);

        var command:IStepSequence = projectService.saveAsync();
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
            var project:Project = fileService.wakeup(_file);
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
        var project:Project = null;

        var path:String = preferenceService.appLastProjectPath;

        var file:File = path != null ? new File(path) : null;
        if (file != null && file.exists)
        {
            logger.startup(TAG, "### Loading Project: " + file.nativePath);
            // Project is injected before Project.wakeup() is called.
            project = fileService.wakeup(file);
            logger.log(TAG, "### Project.onWakeup()");
        }
        else
        {
            logger.startup(TAG, "### Using default Project: ");
            project = ProjectServiceImpl(projectService).sdk_internal::createProject("UntitledProject", "");
        }

        complete(project);

        return null;
    }
}

class SaveProjectCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var projectService:IProjectService;

    public function SaveProjectCommand()
    {
    }

    override public function execute():*
    {
        logger.log("SaveProjectCommand", "Save project " + projectModel.projectFile.nativePath);
        ProjectServiceImpl(projectService).sdk_internal::save();
        eventDispatcher.dispatchEventWith(ProjectModelEventType.PROJECT_SAVE_COMPLETE, false, projectModel.project);
        complete(null, 200);
        return null;
    }
}