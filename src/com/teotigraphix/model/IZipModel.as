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

package com.teotigraphix.model
{

import deng.fzip.FZipFile;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

public interface IZipModel
{
    /**
     * The target copy directory once a zip file is loaded into memory.
     */
    function get targetDirectory():File;

    function get fileCount():int;

    /**
     * Returns a list of nativePath Files based on the targetDirectory.
     */
    function get directories():Vector.<File>;

    function get files():Vector.<File>;

    /**
     * Loads a zip archive into the model where directories and files get populated.
     *
     * @param file The archive file.
     * @param targetDirectory The target directory to unpack when writeFiles() is called.
     */
    function loadFile(file:File, targetDirectory:File):void;

    function getFileAt(index:int):FZipFile;

    function getFileByName(name:String):FZipFile;

    /**
     * Writes all files to disk in the targetDirectory async.
     */
    function writeFiles():IAsyncCommand;

    /**
     * Clears all files, directories and targetDirectory references.
     */
    function clear():void;
}
}
