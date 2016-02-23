package com.teotigraphix.service.impl
{
import com.teotigraphix.frameworks.project.Project;

import flash.filesystem.File;

public class ProjectServiceResult
{
    public var file:File;
    
    public var project:Project;
    
    public function ProjectServiceResult(file:File)
    {
        this.file = file;
    }
}
}