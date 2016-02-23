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

import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.IProjectState;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IProjectService;
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
        
        if (fileService.applicationDirectory.exists)
        {
            if (!fileService.projectDirectory.exists)
                fileService.projectDirectory.createDirectory();
            if (!fileService.projectMetadataDirectory.exists)
                fileService.projectMetadataDirectory.createDirectory();
            
            //if (!fileService.libraryDirectory.exists)
            //    fileService.libraryDirectory.createDirectory();
        }
    }

    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------

    /**
     * @inheritDoc 
     */
    public function loadLastProjectAsync():IStepSequence
    {
        var result:ProjectServiceResult = new ProjectServiceResult(null);
        var main:IStepSequence = StepSequence.sequence(injector, result);
        main.addStep(LoadLastProjectCommand);
        return main;
    }

    /**
     * @inheritDoc 
     */
    public function loadProjectAsync(file:File):IStepSequence
    {
        var result:ProjectServiceResult = new ProjectServiceResult(file);
        var main:IStepSequence = StepSequence.sequence(injector, result);
        main.addStep(LoadProjectCommand);
        return main;
    }

    /**
     * @inheritDoc 
     */
    public function createProjectAsync(file:File):IStepSequence
    {
        var result:ProjectServiceResult = new ProjectServiceResult(file);
        var main:IStepSequence = StepSequence.sequence(injector, result);
        main.addStep(CreateProjectCommand);
        return main;
    }

    /**
     * @inheritDoc 
     */
    public function saveAsync(project:Project):IStepSequence
    {
        var result:ProjectServiceResult = new ProjectServiceResult(null);
        result.project = project;
        
        var main:IStepSequence = StepSequence.sequence(injector, result);
        // saves internal state before the Project is written to disk
        main.addCommand(project.saveAsync());
        // save the Project to disk
        main.addStep(SaveProjectCommand);
        return main;
    }

    //--------------------------------------------------------------------------
    // internal :: Methods
    //--------------------------------------------------------------------------

    public function save(project:Project):Boolean
    {
        project.metadataDirectory.createDirectory();
        project.tempDirectory.createDirectory();

        fileService.serialize(project.nativeFile, project);
        
        return project.nativeFile.exists;
    }

    public function createProject(file:File):Project
    {
        var project:Project = injector.instantiate(Project);
        var state:IProjectState = injector.getInstance(IProjectState);
        
        state.setFirstRun();
        
        project.initialize(state,
                           IDUtils.createUID(),
                           file,
                           descriptor.version);

        logger.log(TAG, "### Project.create()");
        project.create();

        return project;
    }
}
}

import com.teotigraphix.frameworks.errors.ProjectError;
import com.teotigraphix.frameworks.project.IProjectConfigurator;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.impl.ProjectServiceImpl;
import com.teotigraphix.service.impl.ProjectServiceResult;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;
import org.as3commons.async.operation.event.OperationEvent;

final class CreateProjectCommand extends StepCommand
{
    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var projectService:IProjectService;
    
    [Inject]
    public var configurator:IProjectConfigurator;    
    
    override public function execute():*
    {
        var service:ProjectServiceImpl = projectService as ProjectServiceImpl;
        var o:ProjectServiceResult = data as ProjectServiceResult;
        
        // previous UI interaction will have already asked to save the old project
        // unload last project
        o.project = service.createProject(o.file);

        configurator.setupNewProject(o.project);
        
        var command:IStepSequence = projectService.saveAsync(o.project);
        command.addCompleteListener(this_completeHandler);
        command.addErrorListener(this_errorHandler);
        command.execute();

        return null;
    }

    private function this_completeHandler(event:OperationEvent):void
    {
        var o:ProjectServiceResult = data as ProjectServiceResult;
        projectModel.project = o.project;
        finished();
    }

    private function this_errorHandler(event:OperationEvent):void
    {
        var o:ProjectServiceResult = data as ProjectServiceResult;
        dispatchErrorEvent(ProjectError.createFileDoesNotExistError(o.file));
    }
}

//----------------------------------
// LoadProjectCommand
//----------------------------------

final class LoadProjectCommand extends StepCommand
{
    private static const TAG:String = "LoadProjectCommand";

    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var fileService:IFileService;
    
    [Inject]
    public var configurator:IProjectConfigurator;    
    
    public function LoadProjectCommand()
    {
    }
    
    override public function execute():*
    {
        logger.log(TAG, "execute()");
        
        var o:ProjectServiceResult = data as ProjectServiceResult;
        var project:Project;
        
        if (o.file.exists)
        {
            logger.log(TAG, "### Wakeup Project: " + o.file.nativePath);
            project = fileService.deserialize(o.file);
            configurator.configureExistingProject(project);
            o.project = project;
            projectModel.project = o.project;
            complete();
        }
        else
        {
            logger.err(TAG, "Project file not found [{0}]" + o.file.nativePath);
            dispatchErrorEvent(ProjectError.createFileDoesNotExistError(o.file));
        }

        return null;
    }
}

//----------------------------------
// LoadLastProjectCommand
//----------------------------------

final class LoadLastProjectCommand extends StepCommand
{
    private static const TAG:String = "LoadLastProjectCommand";

    [Inject]
    public var applicationSettings:IApplicationSettings;

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var projectService:IProjectService;
    
    [Inject]
    public var configurator:IProjectConfigurator;    
    
    public function LoadLastProjectCommand()
    {
    }

    override public function execute():*
    {
        logger.startup(TAG, "execute()");
        var service:ProjectServiceImpl = projectService as ProjectServiceImpl;
        var project:Project = null;

        var file:File = applicationSettings.appLastProjectFile;
        if (file != null && file.exists)
        {
            logger.startup(TAG, "### Loading Project: " + file.nativePath);
            // Project is injected before Project.wakeup() is called.
            project = fileService.deserialize(file);
            configurator.configureExistingProject(project);
            logger.log(TAG, "### Project.onWakeup()");
        }
        else
        {
            logger.startup(TAG, "### Using default Project: ");
            
            file = fileService.getNextUntitledProjectFile();
            
            project = service.createProject(file);
            configurator.setupNewProject(project);
        }

        ProjectServiceResult(data).project = project;
        
        finished();

        return null;
    }
}

//----------------------------------
// SaveProjectCommand
//----------------------------------

final class SaveProjectCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var projectModel:IProjectModel;

    [Inject]
    public var projectService:IProjectService;

    public function SaveProjectCommand()
    {
    }

    override public function execute():*
    {
        var service:ProjectServiceImpl = projectService as ProjectServiceImpl;
        var project:Project = ProjectServiceResult(data).project;
        
        logger.log("SaveProjectCommand", "Save project " + project.nativePath);
        var success:Boolean = service.save(project);
        if (!success)
        {
            dispatchErrorEvent(ProjectError.createProjectNotSavedError(project));
            return null;
        }
        
        complete();
        return null;
    }
}