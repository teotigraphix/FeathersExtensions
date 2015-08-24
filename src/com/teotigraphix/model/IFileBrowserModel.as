/**
 * Created by Teoti on 7/17/2015.
 */
package com.teotigraphix.model
{

import com.teotigraphix.model.data.FileBrowserModelData;

import flash.filesystem.File;

public interface IFileBrowserModel
{
    /**
     *
     * @param format
     * @param file
     * @see com.teotigraphix.model.data.FileBrowserModelData
     */
    function putFormatValue(format:String, file:File):void;

    /**
     * @param format
     * @param clear
     */
    function getFormatValue(format:String, clear:Boolean = false):FileBrowserModelData;

    /**
     * @param format
     */
    function clearFormatValue(format:String):FileBrowserModelData;
}
}
