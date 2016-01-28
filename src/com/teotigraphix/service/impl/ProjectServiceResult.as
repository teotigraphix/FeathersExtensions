package com.teotigraphix.service.impl
{
import com.teotigraphix.frameworks.project.Project;

import flash.filesystem.File;

public class ProjectServiceResult
{
    public var name:String;
    public var path:String;
    public var file:File;
    
    public var project:Project;
    
    public function ProjectServiceResult()
    {
    }
}
}