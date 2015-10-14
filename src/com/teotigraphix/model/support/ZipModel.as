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

package com.teotigraphix.model.support
{

import com.teotigraphix.model.*;
import com.teotigraphix.util.Files;

import deng.fzip.FZip;
import deng.fzip.FZipFile;

import flash.filesystem.File;
import flash.utils.ByteArray;

import org.as3commons.async.command.IAsyncCommand;

public class ZipModel extends AbstractModel implements IZipModel
{
    public static const TAG:String = "ZipModel";

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    private var _zip:FZip;
    private var _targetDirectory:File;
    private var _directories:Vector.<File>;
    private var _files:Vector.<File>;

    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    /**
     * @inheritDoc
     */
    public function get targetDirectory():File
    {
        return _targetDirectory;
    }

    /**
     * @inheritDoc
     */
    public function get fileCount():int
    {
        return _zip.getFileCount();
    }

    /**
     * @inheritDoc
     */
    public function get directories():Vector.<File>
    {
        return _directories;
    }

    /**
     * @inheritDoc
     */
    public function get files():Vector.<File>
    {
        return _files;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function ZipModel()
    {
    }

    //--------------------------------------------------------------------------
    // API :: Methods
    //--------------------------------------------------------------------------

    /**
     * @inheritDoc
     */
    public function loadFile(file:File, targetDirectory:File):void
    {
        logger.log(TAG, "Loading archive; " + file.nativePath);

        if (!targetDirectory.exists)
            targetDirectory.createDirectory();

        _targetDirectory = targetDirectory;

        var bytes:ByteArray = Files.readBinaryFile(file);

        loadBytes(bytes);
    }

    public function loadBytes(bytes:ByteArray):void
    {
        logger.log(TAG, "Loading archive from ByteArray");

        _zip = new FZip();
        _zip.loadBytes(bytes);

        updateModel();
    }

    /**
     * @inheritDoc
     */
    public function getFileAt(index:int):FZipFile
    {
        return _zip.getFileAt(index);
    }

    /**
     * @inheritDoc
     */
    public function getFileByName(name:String):FZipFile
    {
        return _zip.getFileByName(name);
    }

    /**
     * @inheritDoc
     */
    public function writeFiles():IAsyncCommand
    {
        return injector.instantiate(WriteZipFilesToDisk);
    }

    /**
     * @inheritDoc
     */
    public function clear():void
    {
        _directories = null;
        _targetDirectory = null;
        _zip = null;
        logger.log(TAG, "Cleared state.");
    }

    private function updateModel():void
    {
        _directories = new <File>[];
        _files = new <File>[];

        // will be null with loadBytes() if the directory is not defined because we are
        // not copying anything, just reading bytes and strings our of the data
        if (_targetDirectory != null)
        {
            if (!_targetDirectory.exists)
                _targetDirectory.createDirectory();

            var len:int = fileCount;
            for (var i:int = 0; i < len; i++)
            {
                var file:FZipFile = _zip.getFileAt(i);
                if (isDirectory(file))
                {
                    _directories[_directories.length] = _targetDirectory.resolvePath(file.filename);
                }
                else
                {
                    _files[_files.length] = _targetDirectory.resolvePath(file.filename);
                }
            }
        }
    }

    public static function isDirectory(file:FZipFile):Boolean
    {
        return file.filename.lastIndexOf("/") == file.filename.length - 1;
    }
}
}

import com.teotigraphix.model.IZipModel;
import com.teotigraphix.model.support.ZipModel;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.util.Files;

import deng.fzip.FZipFile;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

class WriteZipFilesToDisk extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var zipModel:IZipModel;

    public function WriteZipFilesToDisk()
    {
    }

    override public function commit():*
    {
        var len:int = zipModel.fileCount;
        logger.log(ZipModel.TAG, "Extracting " + len + " files...");
        for (var i:int = 0; i < len; i++)
        {
            var target:File;
            var file:FZipFile = zipModel.getFileAt(i);
            var filename:String = file.filename;

            if (ZipModel.isDirectory(file))
            {
                target = zipModel.targetDirectory.resolvePath(filename);
                target.createDirectory();
                logger.log(ZipModel.TAG, "Created directory; " + target.nativePath);
            }
            else
            {
                target = zipModel.targetDirectory.resolvePath(file.filename);
                Files.writeBinaryFile(target, file.content);
                logger.log(ZipModel.TAG, "Write file to disk; " + target.nativePath);
            }
        }
        return zipModel.files;
    }

    override public function execute():*
    {
        commit();

        monitorForComplete(zipModel, 1000);

        return null;
    }

    override protected function checkComplete():Boolean
    {
        for each(var file:File in zipModel.files)
        {
            if (!file.exists)
                return false;
        }
        return true;
    }
}