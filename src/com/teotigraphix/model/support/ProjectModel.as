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

package com.teotigraphix.model.support
{

import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.*;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IPreferenceService;

import flash.filesystem.File;

public class ProjectModel extends AbstractModel implements IProjectModel
{
    private const TAG:String = "ProjectModel";

    //--------------------------------------------------------------------------
    // Inject :: Variables
    //--------------------------------------------------------------------------

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var preferenceService:IPreferenceService;

    private var _project:Project;

    //--------------------------------------------------------------------------
    // IProjectModel API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // project
    //----------------------------------

    public function get project():Project
    {
        return _project;
    }

    public function set project(value:Project):void
    {
        var oldProject:Project = _project;
        if (oldProject != null)
        {
            oldProject.close();
        }
        setProject(value);

        projectLoadCompleteHandler();
    }

    //----------------------------------
    // projectFile
    //----------------------------------

    public function get projectFile():File
    {
        return _project.workingFile;
    }

    //----------------------------------
    // projectDirectory
    //----------------------------------

    public function get projectDirectory():File
    {
        return _project.workingDirectory;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function ProjectModel()
    {
        super();
    }

    //--------------------------------------------------------------------------
    // Private :: Methods
    //--------------------------------------------------------------------------

    protected function setProject(project:Project):void
    {
        if (project == null)
        {
            _project = null;
            logger.log(TAG, "!!!! Set Project: NULL, no current project.");
        }
        else
        {
            logger.log(TAG, "!!!! Set Project: " + project.name);
            _project = project;
            injector.injectInto(_project);
        }
    }

    private function projectLoadCompleteHandler():void
    {
        if (_project != null)
        {
            preferenceService.appLastProjectPath = _project.getNativePath();
            logger.log(TAG, "Dispatching PROJECT_CHANGED event: " + _project.toString());
            dispatchWith(ApplicationEventType.PROJECT_CHANGED, false, _project);
        }
        else
        {
            logger.log(TAG, "projectNullHandler() - No Event");
        }
    }
}
}