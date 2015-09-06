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

package com.teotigraphix.service
{

import flash.filesystem.File;

public interface IFileService
{
    function get storageDirectory():File;

    /**
     * Returns something like /storage/sdcard0/MyApp.
     */
    function get applicationDirectory():File;

    /**
     * Returns something like /storage/sdcard0/MyApp/Library.
     */
    function get libraryDirectory():File;

    /**
     * Returns something like /storage/sdcard0/MyApp/Library/Packages.
     */
    function get packagesDirectory():File;

    /**
     * Returns something like /storage/sdcard0/MyApp/Projects.
     */
    function get projectDirectory():File;

    function get preferenceBinFile():File;

    function listFiles(directory:File,
                       filter:Array = null,
                       recursive:Boolean = false,
                       directoriesOnTop:Boolean = true):Vector.<File>;

    function wakeup(file:File):*;

    function sleep(file:File, data:Object):void;

    function serialize(file:File, data:Object):void;

    function deserialize(file:File):*;

    function readString(file:File):String;

    function writeString(file:File, data:String):void;
}
}
