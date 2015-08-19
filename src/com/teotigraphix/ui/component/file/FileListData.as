/**
 * Created by Teoti on 5/12/2015.
 */
package com.teotigraphix.ui.component.file
{

import flash.filesystem.File;

public class FileListData
{
    public var format:String;
    public var resultFile:File;

    public var styleName:String;

    public var showFiles:Boolean = true;
    public var directoryDoubleTapEnabled:Boolean;
    public var extensions:Array = [];
    public var homeDirectory:File = File.documentsDirectory;
    public var rootDirectory:File;
    public var actionText:String;
    public var iconFunction:Function;
    public var enabledFunction:Function;

    public function FileListData()
    {
    }

    public function copyTo(list:FileList):void
    {
        list.styleNameList.add(styleName);
        list.showFiles = showFiles;
        list.directoryDoubleTapEnabled = directoryDoubleTapEnabled;
        list.extensions = extensions;
        list.homeDirectory = homeDirectory;
        list.rootDirectory = rootDirectory;
        list.actionText = actionText;
        list.iconFunction = iconFunction;
        list.enabledFunction = enabledFunction;
    }
}
}
