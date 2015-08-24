/**
 * Created by Teoti on 3/19/2015.
 */
package com.teotigraphix.model
{

import com.teotigraphix.frameworks.project.Project;

import flash.filesystem.File;

public interface IProjectModel
{
    function get project():Project;

    function set project(value:Project):void;

    function get projectFile():File;

    function get projectDirectory():File;

    /**
     * The Project that is loading, will only be pushed to #project, when all operations
     * have completed successfully.
     */
    function get pendingProject():Project;

    function set pendingProject(value:Project):void;
}
}
