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

package com.teotigraphix.app.config
{

import flash.filesystem.File;

public class ApplicationDescriptor
{
    //--------------------------------------------------------------------------
    // Custom Initialize locations
    //--------------------------------------------------------------------------

    /**
     * Set to custom path or use File.documentsDirectory.
     */
    public var DOCUMENTS_DIRECTORY:File = File.documentsDirectory;

    public var APPLICATION_PREFERENCES:String = "application_preferences.xml";

    public var APPLICATION_STATE:String = "application_preferences.bin";

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    public var STORAGE_DIRECTORY:File = File.applicationStorageDirectory;

    private var _appID:String;
    private var _name:String;
    private var _extension:String;
    private var _version:Version;
    private var _flushState:Boolean;
    private var _fps:int;
    private var _isDebug:Boolean;

    //----------------------------------
    // appID
    //----------------------------------

    public function get appID():String
    {
        return _appID;
    }

    public function set appID(value:String):void
    {
        _appID = value;
    }

    //----------------------------------
    // name
    //----------------------------------

    public function get name():String
    {
        return _name;
    }

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
    // flushState
    //----------------------------------

    /**
     * Whether to flush application state each startup.
     */
    public function get flushState():Boolean
    {
        return _flushState;
    }

    public function set flushState(value:Boolean):void
    {
        _flushState = value;
    }

    //----------------------------------
    // fps
    //----------------------------------

    public function get fps():int
    {
        return _fps;
    }

    public function set fps(value:int):void
    {
        _fps = value;
    }

    //----------------------------------
    // isDebug
    //----------------------------------

    public function get isDebug():Boolean
    {
        return _isDebug;
    }

    public function set isDebug(value:Boolean):void
    {
        _isDebug = value;
    }

    //----------------------------------
    // documentsDirectory
    //----------------------------------

    // /storage/sdcard0
    public function get documentsDirectory():File
    {
        return DOCUMENTS_DIRECTORY;
    }

    public function get storageDirectory():File
    {
        return File.applicationStorageDirectory;
    }

    // /storage/sdcard0/CausticPlayer
    public function get applicationDirectory():File
    {
        return DOCUMENTS_DIRECTORY.resolvePath(_name);
    }

    // /storage/sdcard0/App/Library
    public function get libraryDirectory():File
    {
        return applicationDirectory.resolvePath("Library");
    }

    // /storage/sdcard0/App/Library/Packages
    public function get packagesDirectory():File
    {
        return libraryDirectory.resolvePath("Packages");
    }

    // /storage/sdcard0/App/Projects
    public function get projectDirectory():File
    {
        return applicationDirectory.resolvePath("Projects");
    }

    public function get preferenceBinFile():File
    {
        return STORAGE_DIRECTORY.resolvePath(APPLICATION_STATE);
    }

    public function ApplicationDescriptor()
    {
    }
}
}