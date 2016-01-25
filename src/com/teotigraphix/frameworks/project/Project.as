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

package com.teotigraphix.frameworks.project
{

import com.teotigraphix.app.configuration.Version;
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.util.ISerialize;

import flash.errors.IOError;
import flash.filesystem.File;

import mx.utils.UIDUtil;

import org.as3commons.lang.Assert;
import org.as3commons.lang.StringUtils;
import org.robotlegs.starling.core.IInjector;

use namespace sdk_internal;

public final class Project implements ISerialize
{
    private static const TEMP_DIR:String = ".temp";

    //--------------------------------------------------------------------------
    // Public Inject :: Variables
    //--------------------------------------------------------------------------

    [Inject]
    [Transient]
    public var injector:IInjector;

    [Inject]
    [Transient]
    public var fileService:IFileService;

    //--------------------------------------------------------------------------
    // Serialized API
    //--------------------------------------------------------------------------

    private var _uid:String;
    private var _path:String = "";
    private var _name:String = "UntitledProject";
    private var _extension:String;
    private var _version:Version;
    private var _state:IProjectState;

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // uid
    //----------------------------------

    public function get uid():String
    {
        return _uid;
    }

    public function set uid(value:String):void
    {
        _uid = value;
    }

    //----------------------------------
    // path
    //----------------------------------

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

    //----------------------------------
    // name
    //----------------------------------

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

    //----------------------------------
    // extension
    //----------------------------------

    public function get extension():String
    {
        return _extension;
    }

    public function set extension(value:String):void
    {
        _extension = value;
    }

    //----------------------------------
    // version
    //----------------------------------

    public function get version():Version
    {
        return _version;
    }

    public function set version(value:Version):void
    {
        _version = value;
    }

    //----------------------------------
    // state
    //----------------------------------

    public function get state():IProjectState
    {
        return _state;
    }

    public function set state(value:IProjectState):void
    {
        _state = value;
    }

    //----------------------------------
    // workingFile
    //----------------------------------

    /**
     * Returns the project's serialized file.
     *
     * Projects\UntitledProject
     */
    public function get workingFile():File
    {
        return workingDirectory.resolvePath(_name + "." + _extension);
    }

    //----------------------------------
    // workingDirectory
    //----------------------------------

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

    //----------------------------------
    // workingTempDirectory
    //----------------------------------

    /**
     * Returns the project's working .temp directory.
     *
     * Projects\UntitledProject\.temp
     */
    public function get workingTempDirectory():File
    {
        return workingDirectory.resolvePath(TEMP_DIR);
    }

    //----------------------------------
    // workingTempDirectory
    //----------------------------------

    /**
     * Whether the Project's working file exists on disk.
     */
    public function get exists():Boolean
    {
        return workingFile.exists;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function Project()
    {
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

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
     * Returns a file from within the project's root directory.
     *
     * @param relativePath The resource path.
     */
    public function getResource(relativePath:String):File
    {
        var resource:File = findResource(relativePath);
        return resource;
    }

    /**
     * Returns a directory from within the project's root directory.
     * <p>
     * Create the directory if not exists.
     *
     * @param relativePath The resource path.
     */
    public function getDirectoryResource(relativePath:String):File
    {
        var resource:File = findResource(relativePath);
        if (!resource.exists)
            resource.createDirectory();
        return resource;
    }

    /**
     * Returns the .temp project directory and creates it if needed.
     */
    public function getTempDirectory():File
    {
        var directory:File = workingTempDirectory;
        if (!directory.exists)
        {
            directory.createDirectory();
        }
        return directory;
    }

    /**
     * Returns a new project temp file located at AppRoot/ProjectName/.temp/tempName.tmp.
     *
     * @param name The name of the temp file with extension, if null a random name is created
     * and .tmp is the extension.
     * @param length If name is null and a random name created, this is the length of the file name.
     * @throws IOError Temp file exists
     */
    public function getTempFile(name:String = null, length:int = -1):File
    {
        var directory:File = workingTempDirectory;
        if (!directory.exists)
        {
            directory.createDirectory();
        }
        if (name == null)
        {
            name = UIDUtil.createUID().substr(0, length);
            if (length != -1)
            {
                name = name.substr(0, length)
            }
            name = name + ".tmp";
        }

        var file:File = directory.resolvePath(name);
        if (!file.isDirectory && file.exists)
            throw new IOError("Temp file exists; " + file.nativePath);

        return file;
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

    /**
     * Any save operations that need to be done on the internal state before serialization.
     *
     * @see AbstractProjectState#saveAsync()
     */
    public function saveAsync():IStepSequence
    {
        return AbstractProjectState(_state).saveAsync();
    }

    //--------------------------------------------------------------------------
    // Public ISerialize :: Methods
    //--------------------------------------------------------------------------

    public function create():void
    {
        if (_state is ISerialize)
        {
            ISerialize(_state).create();
        }
    }

    public function wakeup():void
    {
        if (_state is ISerialize)
        {
            injector.injectInto(_state);
            ISerialize(_state).wakeup();
        }
    }

    public function sleep(preSleep:Boolean = false):void
    {
        if (_state is ISerialize)
        {
            ISerialize(_state).sleep(preSleep);
        }
    }

    public function toString():String
    {
        return "Project{_uid=" + String(_uid) + ",_name=" + String(_name) + "}";
    }

    //--------------------------------------------------------------------------
    // sdk_internal :: Methods
    //--------------------------------------------------------------------------

    sdk_internal function initialize(state:IProjectState = null,
                                     uid:String = null,
                                     path:String = null,
                                     name:String = null,
                                     extension:String = null,
                                     version:Version = null):void
    {
        Assert.notNull(state, "IProjectState must not be null");

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
