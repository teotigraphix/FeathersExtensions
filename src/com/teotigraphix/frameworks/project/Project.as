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
import com.teotigraphix.util.Files;
import com.teotigraphix.util.IDUtils;
import com.teotigraphix.util.ISerialize;

import flash.errors.IOError;
import flash.filesystem.File;

import org.as3commons.lang.Assert;
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
    private var _nativePath:String;
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
    // nativePath
    //----------------------------------

    /**
     * The native path where the actual serialized file exists from the last save.
     */
    public function get nativePath():String
    {
        return _nativePath;
    }

    public function set nativePath(value:String):void
    {
        _nativePath = value;
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
    
    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // isFirstRun
    //----------------------------------

    public function get isFirstRun():Boolean
    {
        return _state.isFirstRun;
    }
    
    //----------------------------------
    // nativeFile
    //----------------------------------

    public function get nativeFile():File
    {
        return new File(_nativePath);
    }
    
    //----------------------------------
    // name
    //----------------------------------
    
    public function get name():String
    {
        return Files.getBaseName(nativeFile);
    }
    
    //----------------------------------
    // extension
    //----------------------------------
    
    public function get extension():String
    {
        return nativeFile.extension;
    }
    
    //----------------------------------
    // exists
    //----------------------------------
    
    public function get exists():Boolean
    {
        return nativeFile.exists;
    }
    
    //----------------------------------
    // metadataDirectory
    //----------------------------------

    /**
     * Returns the project's working directory.
     *
     * ApplicationDirectory/Projects/.metadata/[Project.uid]/
     */
    public function get metadataDirectory():File
    {
        return fileService.projectMetadataDirectory.resolvePath(_uid);
    }

    //----------------------------------
    // workingTempDirectory
    //----------------------------------

    /**
     * Returns the project's working .temp directory.
     *
     * ApplicationDirectory/Projects/.metadata/[Project.uid]/.temp
     */
    public function get tempDirectory():File
    {
        var directory:File = metadataDirectory.resolvePath(TEMP_DIR);
        if (!directory.exists)
            directory.createDirectory();
        return directory;
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
     * Returns a directory or file from within the project's metadata directory.
     * 
     * <p>Does not create a directory.</p>
     *
     * @param relativePath The resource path.
     */
    public function findResource(relativePath:String):File
    {
        return metadataDirectory.resolvePath(relativePath);
    }

    /**
     * Returns a file from within the project's metadata directory.
     *
     * @param relativePath The resource path.
     * @param shouldCreate Creates a directory if it doesn't exist.
     */
    public function getResource(relativePath:String, shouldCreate:Boolean = false):File
    {
        var resource:File = findResource(relativePath);
        if (shouldCreate && !resource.exists)
        {
            resource.createDirectory();
        }
        return resource;
    }

    /**
     * Returns a new project temp file located at 
     * ApplicationDirectory/Projects/.metadata/[Project.uid]/.temp/name.tmp.
     * 
     * <p>Does not create a directory.</p>
     *
     * @param name The name of the temp file with extension, if null a random name is created
     * and .tmp is the extension.
     * @param length If name is null and a random name created, this is the length of the file name.
     * @throws IOError Temp file exists
     */
    public function getTempFile(name:String = null, length:int = -1):File
    {
        var directory:File = tempDirectory;

        if (name == null)
        {
            name = IDUtils.createUID().substr(0, length);
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
     * Closes the project and disposes resources and references.
     */
    public function close():void
    {
        injector = null;
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

    public function serialize():void
    {
        if (_state is ISerialize)
        {
            injector.injectInto(_state);
            ISerialize(_state).serialize();
        }
    }

    public function deserialize(preSleep:Boolean = false):void
    {
        if (_state is ISerialize)
        {
            ISerialize(_state).deserialize(preSleep);
        }
    }

    public function toString():String
    {
        return "Project{_uid=" + String(_uid) + ",_name=" + String(_nativePath) + "}";
    }

    //--------------------------------------------------------------------------
    // sdk_internal :: Methods
    //--------------------------------------------------------------------------

    sdk_internal function initialize(state:IProjectState = null,
                                     uid:String = null,
                                     file:File = null,
                                     version:Version = null):void
    {
        Assert.notNull(state, "IProjectState must not be null");

        _state = state;

        AbstractProjectState(_state).setProject(this);

        _uid = uid;
        _nativePath = file.nativePath;
        _version = version;
    }

}
}
