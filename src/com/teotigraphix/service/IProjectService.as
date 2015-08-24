/**
 * Created by Teoti on 3/21/2015.
 */
package com.teotigraphix.service
{

import com.teotigraphix.service.async.IStepCommand;

import flash.filesystem.File;

public interface IProjectService
{
    /**
     * The 'complete' result is a newly created Project or Project loaded from disk.
     */
    function loadLastProject():IStepCommand;

    /**
     * Loads a Project file using the serialize file.
     * @param file The serialized file that resiseds within the same named directory.
     */
    function loadProjectAsync(file:File):IStepCommand;

    function createProjectAsync(name:String, path:String):IStepCommand;

    function saveAsync():IStepCommand;

}
}
