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

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.service.*;

import flash.filesystem.File;

import starling.core.Starling;

public class AbstractApplicationSettings extends AbstractModel implements IApplicationSettings
{
    private const TAG:String = "AbstractApplicationSettings";

    private static const GLOBAL_LAST_PROJECT:String = "Application/lastProject";

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
    // Public IPreferenceService :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // appLastProjectPath
    //----------------------------------

    public function get appLastProjectPath():String
    {
        return getString(GLOBAL_LAST_PROJECT, null);
    }

    public function set appLastProjectPath(value:String):void
    {
        put(GLOBAL_LAST_PROJECT, value);
    }

    //----------------------------------
    // fps
    //----------------------------------

    public function get fps():int
    {
        return getInt("fps", descriptor.fps);
    }

    public function set fps(value:int):void
    {
        put("fps", value);
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

        logger.startup(TAG, "Setting FPS to {0}", fps);
        Starling.current.nativeStage.frameRate = fps;
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

    public function flush():void
    {
        logger.debug(TAG, "flush()");
        fileService.serialize(fileService.preferenceBinFile, _map);
    }
}
}