/**
 * Created by Teoti on 5/2/2015.
 */
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
    private var _zip:FZip;

    private var _targetDirectory:File;
    private var _directories:Vector.<File>;
    private var _files:Vector.<File>;

    public function get targetDirectory():File
    {
        return _targetDirectory;
    }

    public function get fileCount():int
    {
        return _zip.getFileCount();
    }

    public function get directories():Vector.<File>
    {
        return _directories;
    }

    public function get files():Vector.<File>
    {
        return _files;
    }

    public function ZipModel()
    {
    }

    override protected function onRegister():void
    {
        super.onRegister();
    }

    public function loadFile(file:File, targetDirectory:File):void
    {
        if (!targetDirectory.exists)
            targetDirectory.createDirectory();

        _targetDirectory = targetDirectory;

        var bytes:ByteArray = Files.readBinaryFile(file);

        _zip = new FZip();
        _zip.loadBytes(bytes);

        updateModel();
    }

    public function getFileAt(index:int):FZipFile
    {
        return _zip.getFileAt(index);
    }

    public function getFileByName(name:String):FZipFile
    {
        return _zip.getFileByName(name);
    }

    public function writeFiles():IAsyncCommand
    {
        return injector.instantiate(WriteZipFilesToDisk);
    }

    public function clear():void
    {
        _directories = null;
        _targetDirectory = null;
        _zip = null;
    }

    private function updateModel():void
    {
        _directories = new <File>[];
        _files = new <File>[];

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
        for (var i:int = 0; i < len; i++)
        {
            var file:FZipFile = zipModel.getFileAt(i);
            var filename:String = file.filename;

            if (ZipModel.isDirectory(file))
            {
                zipModel.targetDirectory.resolvePath(filename).createDirectory();
            }
            else
            {
                Files.writeBinaryFile(zipModel.targetDirectory.resolvePath(file.filename), file.content);
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