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

package com.teotigraphix.model.impl
{

import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.service.IFileService;

import flash.filesystem.File;

import starling.core.Starling;

public class AbstractApplicationSettings extends AbstractModel implements IApplicationSettings
{
    private const TAG:String = "AbstractApplicationSettings";

    private static const TAG_LAST_PROJECT:String = "Application/lastProject";
    private static const TAG_PROJECT_BROWSE:String = "Application/projectBrowse";
    private static const TAG_FPS:String = "Application/fps";
    
    //--------------------------------------------------------------------------
    // Public Inject :: Variables
    //--------------------------------------------------------------------------

    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var descriptor:ApplicationDescriptor;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _map:Object;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // appLastProjectFile
    //----------------------------------

    public function get appLastProjectFile():File
    {
        var path:String = getString(TAG_LAST_PROJECT, null);
        if (path == null)
            return null;
        return new File(path);
    }

    public function set appLastProjectFile(value:File):void
    {
        put(TAG_LAST_PROJECT, value.nativePath);
    }
    
    //----------------------------------
    // projectBrowseDirectory
    //----------------------------------
    
    public function get projectBrowseDirectory():File
    {
        var path:String = getString(TAG_PROJECT_BROWSE, null);
        if (path == null)
            return File.documentsDirectory;
        return new File(path);
    }
    
    public function set projectBrowseDirectory(value:File):void
    {
        put(TAG_PROJECT_BROWSE, value.nativePath);
    }
    
    //----------------------------------
    // fps
    //----------------------------------

    public function get fps():int
    {
        return getInt(TAG_FPS, descriptor.fps);
    }

    public function set fps(value:int):void
    {
        put(TAG_FPS, value);
        Starling.current.nativeStage.frameRate = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function AbstractApplicationSettings()
    {
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    public function startup():void
    {
        logger.startup(TAG, "startup()");

        if (descriptor.flushState)
        {
            if (fileService.preferenceBinFile.exists)
            {
                fileService.preferenceBinFile.deleteFile();
            }
        }

        _map = {};

        var binFile:File = fileService.preferenceBinFile;
        if (binFile.exists)
        {
            logger.startup(TAG, "    Loaded binary application preferences " + binFile.nativePath);
            _map = fileService.deserialize(binFile);
        }
        else
        {
            logger.startup(TAG, "    Created binary application preferences " + binFile.nativePath);
            flush();
        }

        if (Starling.current != null)
        {
            logger.startup(TAG, "Setting FPS to {0}", fps);
            Starling.current.nativeStage.frameRate = fps;
        }
    }

    //--------------------------------------------------------------------------
    // Public IPreferenceService :: Methods
    //--------------------------------------------------------------------------

    public function put(key:String, value:Object):void
    {
        _map[key] = value;
        flush();
    }

    public function getString(key:String, defaultValue:String = null):String
    {
        if (_map[key] == null)
            return defaultValue;
        return _map[key] as String;
    }

    public function getInt(key:String, defaultValue:int = NaN):int
    {
        if (_map[key] == null)
            return defaultValue;
        return _map[key] as int;
    }

    public function getFloat(key:String, defaultValue:int = NaN):Number
    {
        if (_map[key] == null)
            return defaultValue;
        return _map[key] as Number;
    }

    public function getBoolean(key:String, defaultValue:Boolean = false):Boolean
    {
        if (_map[key] == null)
            return defaultValue;
        return _map[key] as Boolean;
    }
    
    public function getObject(key:String, defaultValue:Object = null):*
    {
        if (_map[key] == null)
            return defaultValue;
        return _map[key];
    }
    
    public function flush():void
    {
        logger.debug(TAG, "flush()");
        fileService.serialize(fileService.preferenceBinFile, _map);
    }
}
}