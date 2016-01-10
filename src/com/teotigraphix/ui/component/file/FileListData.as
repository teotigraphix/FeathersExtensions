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

package com.teotigraphix.ui.component.file
{

import flash.filesystem.File;

public class FileListData
{
    public var format:String;
    public var resultFile:File;

    public var styleName:String;

    public var title:String;
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
        if (iconFunction != null)
            list.iconFunction = iconFunction;
        if (enabledFunction != null)
            list.enabledFunction = enabledFunction;
    }

    public function hasExtension(extension:String):Boolean
    {
        return extensions != null && extensions.indexOf(extension) != -1;
    }
}
}
