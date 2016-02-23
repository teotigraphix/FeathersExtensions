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
import flash.filesystem.File;

public interface IApplicationSettings
{
    // Global preferences shared by all applications

    function get appLastProjectFile():File;
    function set appLastProjectFile(value:File):void

    function get projectBrowseDirectory():File;
    function set projectBrowseDirectory(value:File):void;
        
    function get fps():int;
    function set fps(value:int):void;
        
    // API

    function put(key:String, value:Object):void;

    function getString(key:String, defaultValue:String = null):String;

    function getInt(key:String, defaultValue:int = NaN):int;

    function getFloat(key:String, defaultValue:int = NaN):Number;

    function getBoolean(key:String, defaultValue:Boolean = false):Boolean;

    function flush():void;
}
}
