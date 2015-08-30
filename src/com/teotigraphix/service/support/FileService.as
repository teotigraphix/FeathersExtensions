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

package com.teotigraphix.service.support
{

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.util.Files;

import flash.filesystem.File;

public class FileService extends AbstractService implements IFileService
{
    private static const TAG:String = "FileManager";

    [Inject]
    public var descriptor:ApplicationDescriptor;

    public function get storageDirectory():File
    {
        return descriptor.storageDirectory;
    }

    public function get applicationDirectory():File
    {
        return descriptor.applicationDirectory;
    }

    public function get libraryDirectory():File
    {
        return descriptor.libraryDirectory
    }

    public function get packagesDirectory():File
    {
        return descriptor.packagesDirectory
    }

    public function get projectDirectory():File
    {
        return descriptor.projectDirectory;
    }

    public function get preferenceBinFile():File
    {
        return descriptor.preferenceBinFile;
    }

    public function FileService()
    {
        super();
    }

    public function startup():void
    {
        logger.startup(TAG, "checkAndCreatePublicApplicationDirectory()");

        checkAndCreatePublicApplicationDirectory();

        logger.startup(TAG, " applicationDirectory: " + applicationDirectory.nativePath);
    }

    public function readString(file:File):String
    {
        return Files.readUTF8File(file);
    }

    public function writeString(file:File, data:String):void
    {
        writeStringToFile(file, data);
    }

    public function serialize(data:Object, file:File):void
    {
        Files.serialize(data, file);
    }

    public function deserialize(file:File):*
    {
        return Files.deserialize(file);
    }

    public function listFiles(directory:File,
                              filter:Array = null,
                              recursive:Boolean = false,
                              directoriesOnTop:Boolean = true):Vector.<File>
    {
        return Files.listFiles(directory, filter, recursive, directoriesOnTop);
    }

    private function writeStringToFile(file:File, data:String):void
    {
        Files.writeUTF8File(file, data);
    }

    private function checkAndCreatePublicApplicationDirectory():void
    {
        if (!applicationDirectory.exists)
        {
            applicationDirectory.createDirectory();
            if (!applicationDirectory.exists)
                logger.err(TAG, applicationDirectory.nativePath + " was not created");
            logger.startup(TAG, "!!! Created application directory.");
        }
        else
        {
            logger.startup(TAG, "!!! Application directory exists.");
        }
    }

    private function foo():void
    {

        // C:\Users\Teoti\Adobe Flash Builder 4.6\CausticPlayer\bin-debug
        // ""
        if (File.applicationDirectory != null)
            logger.log(TAG, File.applicationDirectory.nativePath);

        // C:\Users\Teoti\AppData\Roaming\com.teotigraphix.tones.debug\Local Store
        // /data/data/air.com.teotigraphix.tones.debug/com.teotigraphix.tones.debug/Local Store
        if (File.applicationStorageDirectory != null)
            logger.log(TAG, File.applicationStorageDirectory.nativePath);

        // null
        //
        if (File.cacheDirectory != null)
            logger.log(TAG, File.cacheDirectory.nativePath);

        // C:\Users\Teoti\Desktop
        // /storage/sdcard0
        if (File.desktopDirectory != null)
            logger.log(TAG, File.desktopDirectory.nativePath);

        // C:\Users\Teoti\Documents
        // /storage/sdcard0
        if (File.documentsDirectory != null)
            logger.log(TAG, File.documentsDirectory.nativePath);

        // C:\Users\Teoti
        // /storage/sdcard0
        if (File.userDirectory != null)
            logger.log(TAG, File.userDirectory.nativePath);
    }

}
}