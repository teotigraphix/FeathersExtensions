package com.teotigraphix.service.support
{

import com.teotigraphix.service.*;

import flash.filesystem.File;

public class PreferenceService extends AbstractService implements IPreferenceService
{
    private const TAG:String = "PreferenceService";

    private static const GLOBAL_LAST_PROJECT:String = "Application/lastProject";

    [Inject]
    public var fileService:IFileService;

    private var _map:Object;

    public function get appLastProjectPath():String
    {
        return getString(GLOBAL_LAST_PROJECT, null);
    }

    public function set appLastProjectPath(value:String):void
    {
        put(GLOBAL_LAST_PROJECT, value);
    }

    public function PreferenceService()
    {
    }

    public function startup():void
    {
        logger.startup(TAG, "startup()");

        //root = XMLMemento.createWriteRoot("preferences");
        //
        //var preferenceFile:File = fileService.preferenceFile;
        //if (preferenceFile.exists)
        //{
        //    var data:String = fileService.readString(preferenceFile);
        //    if (data != null && data != "")
        //        root = XMLMemento.createReadRoot(data);
        //}

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

        //       logger.startup(TAG, "Dispatch ApplicationModelEvent.PREFERENCES_LOADED");
        //       ApplicationModelEvent.dispatchPreferenceEvent(
        //               dispatcher, ApplicationModelEvent.PREFERENCES_LOADED, root);
    }

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
        fileService.serialize(_map, fileService.preferenceBinFile);
    }

    public function save():void
    {
        logger.log(TAG, "save()");
        //
        //// refresh so all clients can add onto the root node
        //root = XMLMemento.createWriteRoot("preferences");
        //
        //ApplicationModelEvent.dispatchPreferenceEvent(
        //        dispatcher, ApplicationModelEvent.PREFERENCES_SAVE, root);
        //
        //fileManager.writeString(fileManager.preferenceFile, root.toXMLString());
    }

}
}