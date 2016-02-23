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

import com.teotigraphix.service.async.IStepCommand;

import flash.filesystem.File;

public interface IFileService
{
    /**
     * The private read-only File.applicationStorageDirectory.
     */
    function get storageDirectory():File;
    
    /**
     * Place to save junk files and copy operations, will be cleaned at app startup,
     * this directory would have no file permission conflicts as it's public.
     */
    function get applicationCacheDirectory():File;

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
     * Returns ApplicationDirectory/Projects/.metadata.
     */
    function get projectMetadataDirectory():File;
    
    /**
     * Returns something like /storage/sdcard0/MyApp/Projects.
     */
    function get projectDirectory():File;

    function get preferenceBinFile():File;

    /**
     * Returns a file located in the App/Projects directory with option reletive path.
     * 
     * @param nameWithoutExtension The new project name without extension.
     * @param reletivePath The option path in the Projects directory.
     */
    function getProjectFile(nameWithoutExtension:String, reletivePath:String = null):File
    
    /**
    * Returns a File located in the App/Projects directory with a name like UntitledProject1.
    * 
    * <p>The service will scan that directory to make sure there are no conflicts before assigning
    * the new untitled name.</p>
     */
    function getNextUntitledProjectFile():File;
    
    /**
     * Creates a file in the app's .cache directory, the path can resolve to a file.extension
     * if useID is false, if useID is true, the path needs to be a directory and a generated UID
     * will be used as the file name with no extension.
     * 
     * @param path The reletive path, a directory or directory/file.extension.
     * @param useID Whether to use an auto generated UID for the file name, using path as a directory.
     * @param extension If useID true, optional extension for ID generated file name.
     * @return A pointer to the new file, does not exist yet on disk.
     */
    function getCacheFile(path:String, useID:Boolean = false, extension:String = null):File;
    
    function listFiles(directory:File,
                       filter:Array = null,
                       recursive:Boolean = false,
                       directoriesOnTop:Boolean = true,
                       excludeDirectories:Boolean = false):Vector.<File>;
    
    function copy(data:Object):*;
    
    /**
     * Instantiates an ISerialize instance, calls it's create() method and then saves it
     * to disk at the file location.
     * 
     * @param file The serialized file location.
     * @param clazz The class to instantiate that implements ISerialize.
     * @return The instantiated and saved ISerialize instance.
     */
    function instantiate(file:File, clazz:Class):*;

    /**
     * Puts an ISerialize instance to sleep on disk by calling sleep(pre|post) before
     * and after the serialization.
     * 
     * @param file The serialized file location.
     * @param data The ISerialize instance.
     */
    function serialize(file:File, data:Object):void;
    
    /**
     * Wakes up an ISerialize instance from disk and calls wakeup() on it.
     * 
     * @param file The serialized file location.
     * @return The instantiated and woken up ISerialize instance.
     */
    function deserialize(file:File):*;

    function readString(file:File):String;

    function writeString(file:File, data:String):void;

    /**
     * Downloads a file from the url and saves the URLStream to the targetFile location.
     *
     * @param url The http:// or file:// url to download.
     * @param targetFile The target location the url bytes are saved to.
     * @return A StepCommand that dispatches complete, progress and error OperationEvent,
     * the result is the targetFile.
     *
     * @see org.as3commons.async.operation.event.OperationEvent#COMPLETE
     * @see org.as3commons.async.operation.event.OperationEvent#PROGRESS
     * @see org.as3commons.async.operation.event.OperationEvent#ERROR
     */
    function downloadFileAsync(url:String, targetFile:File):IStepCommand

}
}
