/**
 * Created by Teoti on 5/2/2015.
 */
package com.teotigraphix.model
{

import deng.fzip.FZipFile;

import flash.filesystem.File;

import org.as3commons.async.command.IAsyncCommand;

public interface IZipModel
{

    function get targetDirectory():File;

    function get fileCount():int;

    /**
     * Returns a list of nativePath Files based on the targetDirectory.
     */
    function get directories():Vector.<File>;

    function get files():Vector.<File>;

    function loadFile(file:File, targetDirectory:File):void;

    function getFileAt(index:int):FZipFile;

    function getFileByName(name:String):FZipFile;

    function writeFiles():IAsyncCommand;

    function clear():void;
}
}
