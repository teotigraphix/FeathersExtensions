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
