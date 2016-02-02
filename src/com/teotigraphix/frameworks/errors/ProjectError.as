package com.teotigraphix.frameworks.errors
{

import flash.filesystem.File;
import com.teotigraphix.frameworks.project.Project;

public class ProjectError extends Error
{
    public static const FILE_DOES_NOT_EXIST:int = 0;
    public static const PROJECT_NOT_SAVED:int = 1;
        
    public var file:File;
    public var project:Project;
    
    public function ProjectError(message:*="", id:*=0)
    {
        super(message, id);
    }
    
    public static function createFileDoesNotExistError(file:File):ProjectError
    {
        var error:ProjectError = new ProjectError("File does not exist", FILE_DOES_NOT_EXIST);
        error.file = file;
        return error;
    }
    
    public static function createProjectNotSavedError(project:Project):ProjectError
    {
        var error:ProjectError = new ProjectError("Project not saved", PROJECT_NOT_SAVED);
        error.project = project;
        return error;
    }
} 
}