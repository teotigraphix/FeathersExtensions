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
package com.teotigraphix.ui.component
{

import feathers.controls.StackScreenNavigatorItem;

import starling.display.DisplayObject;

public interface IScreenNavigator
{
    function get activeScreenID():String;

    function get activeScreen():DisplayObject;

    function get rootScreenID():String;

    function set rootScreenID(value:String):void;

    function getScreenIDs(result:Vector.<String> = null):Vector.<String>;

    function addScreen(id:String, item:StackScreenNavigatorItem):void;

    function removeScreen(id:String):StackScreenNavigatorItem;

    function removeAllScreens():void;

    function getScreen(id:String):StackScreenNavigatorItem;

    function pushScreen(id:String,
                        savedPreviousScreenProperties:Object = null,
                        transition:Function = null):DisplayObject;

    function popScreen(transition:Function = null):DisplayObject;

    function popToRootScreen(transition:Function = null):DisplayObject;
}
}
