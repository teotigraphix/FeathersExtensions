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

package com.teotigraphix.service.impl
{

import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.util.Files;
import com.teotigraphix.util.IDUtils;
import com.teotigraphix.util.ISerialize;

import flash.filesystem.File;
import flash.utils.ByteArray;

public class FileServiceImpl extends AbstractService implements IFileService
{
    private static const TAG:String = "FileServiceImpl";

    [Inject]
    public var descriptor:ApplicationDescriptor;

    /**
     * @inheritDoc
     */
    public function get storageDirectory():File
    {
        return descriptor.storageDirectory;
    }
    
    /**
     * @inheritDoc
     */
    public function get applicationCacheDirectory():File
    {
        return descriptor.applicationDirectory.resolvePath(".cache");
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
    
    public function get projectMetadataDirectory():File
    {
        return projectDirectory.resolvePath(".metadata");
    }
    
    public function get preferenceBinFile():File
    {
        return descriptor.preferenceBinFile;
    }

    public function FileServiceImpl()
    {
        super();
    }

    public function startup():void
    {
        logger.startup(TAG, "checkAndCreatePublicApplicationDirectory()");

        checkAndCreatePublicApplicationDirectory();

        logger.startup(TAG, " applicationDirectory: " + applicationDirectory.nativePath);
    }
    
    public function getProjectFile(nameWithoutExtension:String, reletivePath:String = null):File
    {
        var file:File = projectDirectory;
        if (reletivePath != null)
        {
            file = file.resolvePath(reletivePath);
        }
        
        file = file.resolvePath(nameWithoutExtension + "." + descriptor.extension);
        
        return file;
    }
    
    public function getNextUntitledProjectFile():File
    {
        var file:File = getProjectFile(getNextUntitledProjectName());
        return file;
    }
    
    /**
     * @inheritDoc
     */
    public function getCacheFile(path:String, useID:Boolean = false, extension:String = null):File
    {
        const file:File = applicationCacheDirectory.resolvePath(path);
        if (file.extension == null)
        {
            if (!file.exists)
                file.createDirectory();
            
            const uid:String = IDUtils.createUID();
            const fileName:String = (extension != null) ? uid + "." + extension : uid; 
            return useID ? file.resolvePath(fileName) : file;
        }
        return file;
    }
    
    /**
     * @inheritDoc
     */
    public function readString(file:File):String
    {
        return Files.readUTF8File(file);
    }
    
    /**
     * @inheritDoc
     */
    public function writeString(file:File, data:String):void
    {
        writeStringToFile(file, data);
    }

    public function instantiate(file:File, clazz:Class):*
    {
        var instance:ISerialize = injector.instantiate(clazz);
        if (instance is ISerialize)
        {
            ISerialize(instance).create();
        }
        serialize(file, instance);
        return instance;
    }
    
    public function serialize(file:File, data:Object):void
    {
        if (data is ISerialize)
        {
            ISerialize(data).deserialize(true);
        }
        
        const bytes:ByteArray = new ByteArray();
        
        bytes.writeObject(data);
        Files.writeBinaryFile(file, bytes);
        
        if (data is ISerialize)
        {
            ISerialize(data).deserialize();
        }
    }

    public function deserialize(file:File):*
    {
        const data:ByteArray = Files.readBinaryFile(file);
        
        var instance:* = data.readObject();
        injector.injectInto(instance);
        
        if (instance is ISerialize)
        {
            ISerialize(instance).serialize();
        }

        return instance;
    }
    
    public function copy(data:Object):*
    {
        var instance:* = Files.copy(data);
        return instance;
    }

    public function listFiles(directory:File,
                              filter:Array = null,
                              recursive:Boolean = false,
                              directoriesOnTop:Boolean = true,
                              excludeDirectories:Boolean = false):Vector.<File>
    {
        return Files.listFiles(directory, filter, recursive, directoriesOnTop, excludeDirectories);
    }

    public function downloadFileAsync(url:String, targetFile:File):IStepCommand
    {
        var step:DownloadFileStep = injector.instantiate(DownloadFileStep);
        step.url = url;
        step.targetFile = targetFile;
        return step;
    }

    private function writeStringToFile(file:File, data:String):void
    {
        Files.writeUTF8File(file, data);
    }

    private function checkAndCreatePublicApplicationDirectory():void
    {
        if (descriptor.flushState)
        {
            if (applicationDirectory.exists)
            {
                applicationDirectory.deleteDirectory(true);
            }
        }

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
    
    private function getNextUntitledProjectName():String
    {
        // gets the last number found
        var index:int = 0;
        var files:Array = projectDirectory.getDirectoryListing();
        for each (var file:File in files) 
        {
            if (file.isDirectory)
                continue;
            
            var name:String = Files.getBaseName(file);
            var parts:Array = name.split(" ");
            if (parts[0] != "UntitledProject")
                continue;
            
            index = Math.max(parseInt(parts[1]), index);
        }
        return "UntitledProject " + (index + 1);
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

import com.teotigraphix.service.async.StepCommand;

import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLRequest;
import flash.net.URLStream;
import flash.utils.ByteArray;

class DownloadFileStep extends StepCommand
{
    public var targetFile:File;
    public var url:String; // url or nativePath

    private var _urlStream:URLStream;

    override public function execute():*
    {
        if (url.indexOf("file://") == 0)
        {
            const file:File = new File(url);
            if (file.exists)
            {
                file.addEventListener(Event.COMPLETE, localFile_copyCompleteHandler);
                //
                file.addEventListener(IOErrorEvent.IO_ERROR, localFile_copyIOErrorHandler);
                file.copyToAsync(targetFile);
                return;
            }
        }

        _urlStream = new URLStream();
        _urlStream.addEventListener(Event.COMPLETE, request_completeHandler);
        _urlStream.addEventListener(ProgressEvent.PROGRESS, request_progressHandler);

        _urlStream.addEventListener(HTTPStatusEvent.HTTP_STATUS, request_errorHandler);
        _urlStream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, request_errorHandler);
        _urlStream.addEventListener(IOErrorEvent.IO_ERROR, request_errorHandler);
        //_urlStream.addEventListener(Event.OPEN, request_errorHandler);
        _urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, request_errorHandler);

        _urlStream.load(new URLRequest(url));

        return null;
    }

    private function localFile_copyCompleteHandler(event:Event):void
    {
        dispatchCompleteEvent(targetFile);
    }

    private function localFile_copyIOErrorHandler(event:IOErrorEvent):void
    {
        dispatchErrorEvent(event);
    }

    private function request_completeHandler(event:Event):void
    {
        trace("DownloadFileStep.complete");
        var fileData:ByteArray = new ByteArray();
        _urlStream.readBytes(fileData, 0, _urlStream.bytesAvailable);

        var fileStream:FileStream = new FileStream();
        fileStream.open(targetFile, FileMode.WRITE);
        fileStream.writeBytes(fileData, 0);
        fileStream.close();

        _urlStream.close();
        _urlStream = null;

        trace("DownloadFileStep.complete(_localFile)");
        monitorForComplete(targetFile);
    }

    override protected function checkComplete():Boolean
    {
        return targetFile.exists;
    }

    private function request_progressHandler(event:ProgressEvent):void
    {
        progress = event.bytesLoaded;
        total = event.bytesTotal;

        trace("DownloadFileStep.progress: " + progress + "/" + total);
        dispatchProgressEvent();
    }

    private function request_errorHandler(event:Event):void
    {
        if (event.type == HTTPStatusEvent.HTTP_STATUS && HTTPStatusEvent(event).status == 0)
            return; // local file

        if (event.type == HTTPStatusEvent.HTTP_RESPONSE_STATUS && HTTPStatusEvent(event).status == 200)
            return;
        if (event.type == HTTPStatusEvent.HTTP_STATUS && HTTPStatusEvent(event).status == 200)
            return;

        trace("DownloadFileStep.error " + event.toString());
        dispatchErrorEvent(event);
    }
}