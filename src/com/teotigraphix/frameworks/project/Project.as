/**
 * Created by Teoti on 3/6/2015.
 */
package com.teotigraphix.frameworks.project
{

import com.teotigraphix.app.config.Version;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.IFileService;

import flash.filesystem.File;

import org.as3commons.lang.StringUtils;

use namespace sdk_internal;

public final class Project
{
    private static const TEMP_DIR:String = ".temp";

    [Inject]
    [Transient]
    public var fileService:IFileService;

    private var _uid:String;

    private var _path:String = "";

    private var _name:String = "UntitledProject";

    private var _extension:String;

    private var _version:Version;

    private var _state:IProjectState;

    public function get uid():String
    {
        return _uid;
    }

    public function set uid(value:String):void
    {
        _uid = value;
    }

    /**
     * The relative path from the Application's project directory.
     */
    public function get path():String
    {
        return _path;
    }

    public function set path(value:String):void
    {
        _path = value;
    }

    /**
     * Returns the name of the project, the path and name are used to assemble the
     * native location within the application.
     */
    public function get name():String
    {
        return _name;
    }

    // /root/documents/MyApp/Projects/[MyPath/possible sub dir]/[MyName].[myextension]

    public function set name(value:String):void
    {
        _name = value;
    }

    public function get extension():String
    {
        return _extension;
    }

    public function set extension(value:String):void
    {
        _extension = value;
    }

    public function get version():Version
    {
        return _version;
    }

    public function set version(value:Version):void
    {
        _version = value;
    }

    public function get state():IProjectState
    {
        return _state;
    }

    public function set state(value:IProjectState):void
    {
        _state = value;
    }

    /**
     * Returns the project's serialized file.
     *
     * Projects\UntitledProject
     */
    public function get workingFile():File
    {
        return workingDirectory.resolvePath(_name + "." + _extension);
    }

    /**
     * Returns the project's working directory.
     *
     * Projects\UntitledProject\UntitledProject.test
     */
    public function get workingDirectory():File
    {
        var path:String = _name;
        if (StringUtils.trimToNull(_path) != null)
            path = _path + File.separator + path; // foo/bar/ProjectName
        return fileService.projectDirectory.resolvePath(path);
    }

    /**
     * Returns the project's working .temp directory.
     *
     * Projects\UntitledProject\.temp
     */
    public function get workingTempDirectory():File
    {
        return workingDirectory.resolvePath(TEMP_DIR);
    }

    public function Project()
    {
    }

    public function exists():Boolean
    {
        return workingFile.exists;
    }

    /**
     * Returns a directory or file from within the project's root directory.
     * <p>
     * Does not create a directory.
     *
     * @param relativePath The resource path.
     */
    public function findResource(relativePath:String):File
    {
        return workingDirectory.resolvePath(relativePath);
    }

    /**
     * Returns a directory or file from within the project's root directory.
     * <p>
     * Create the file or directory if not exists.
     *
     * @param relativePath The resource path.
     */
    public function getResource(relativePath:String):File
    {
        var resource:File = findResource(relativePath);
        if (!resource.exists)
            resource.createDirectory();
        return resource;
    }

    public function toString():String
    {
        return "Project{_uid=" + String(_uid) + ",_name=" + String(_name) + "}";
    }

    /**
     * Returns the project's native path based on the application's Project
     * directory and this project's path, name and type(file type extension).
     */
    public function getNativePath():String
    {
        return workingFile.nativePath;
    }

    /**
     * Closes the project and disposes resources and references.
     */
    public function close():void
    {
        fileService = null;
    }

    sdk_internal function initialize(state:IProjectState = null,
                                     uid:String = null,
                                     path:String = null,
                                     name:String = null,
                                     extension:String = null,
                                     version:Version = null):void
    {
        _state = state;

        AbstractProjectState(_state).setProject(this);

        _uid = uid;
        _path = path;
        _name = name;
        _extension = extension;
        _version = version;
    }
}
}
