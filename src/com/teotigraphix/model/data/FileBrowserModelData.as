/**
 * Created by Teoti on 7/19/2015.
 */
package com.teotigraphix.model.data
{

import flash.filesystem.File;

public class FileBrowserModelData
{
    public var format:String;
    public var file:File;

    public function FileBrowserModelData(format:String, file:File)
    {
        this.format = format;
        this.file = file;
    }
}
}
