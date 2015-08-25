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

import starling.events.Event;

public class FileListEvent extends Event
{
    // Home, Up, Back, Create, Refresh
    public static const HOME:int = 0;

    public static const UP:int = 1;

    public static const BACK:int = 2;

    public static const NEXT:int = 3;

    public static const CREATE:int = 4;

    public static const REFRESH:int = 5;

    /**
     * Event dispatched when root directory is set, data the File instance.
     */
    public static const ROOT_DIRECTORY_CHANGE:String = "rootDirectoryChange";

    /**
     * Event dispatched when directory is selected, data the File instance.
     */
    public static const DIRECTORY_SELECT:String = "directorySelect";

    /**
     * Event dispatched when file is selected, data the File instance.
     */
    public static const FILE_SELECT:String = "fileSelect";

    /**
     * Event dispatched when directory is double tapped, data the File instance.
     */
    public static const DIRECTORY_DOUBLE_TAP:String = "directoryDoubleTap";

    /**
     * Event dispatched when file is double tapped, data the File instance.
     */
    public static const FILE_DOUBLE_TAP:String = "fileDoubleTap";

    public function FileListEvent(type:String)
    {
        super(type, true, null);
    }
}
}
