/**
 * Created by Teoti on 3/6/2015.
 */
package com.teotigraphix.model.support
{

import com.teotigraphix.model.*;

import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IPreferenceService;

import flash.filesystem.File;

public class ProjectModel extends AbstractModel implements IProjectModel
{
    private const TAG:String = "ProjectModel";

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var preferenceService:IPreferenceService;

    private var _project:Project;
    private var _pendingProject:Project;

    public function get project():Project
    {
        return _project;
    }

    public function set project(value:Project):void
    {
        _pendingProject = null;
        var oldProject:Project = _project;
        if (oldProject != null)
        {
            oldProject.close();
        }
        setProject(value);

        projectLoadCompleteHandler();
    }

    public function get projectFile():File
    {
        return _project.workingFile;
    }

    public function get projectDirectory():File
    {
        return _project.workingDirectory;
    }

    public function get pendingProject():Project
    {
        return _pendingProject;
    }

    public function set pendingProject(value:Project):void
    {
        _pendingProject = value;
    }

    public function ProjectModel()
    {
        super();
    }

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