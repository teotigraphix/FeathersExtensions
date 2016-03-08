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
package com.teotigraphix.ui
{
import feathers.controls.StackScreenNavigator;

public interface IScreenLauncher
{
    function get applicationScreenID():String;
    
    function get contentScreenID():String;
        
    function get contentNavigator():StackScreenNavigator;
    function set contentNavigator(value:StackScreenNavigator):void;
    
    function setContentScreenIndex(contentIndex:int):void;
    
    /**
     * @see com.teotigraphix.ui.screen.core.ScreenRedrawData
     */
    function redraw():void;
    
    function backTo(screenID:String):void;

    function back():void
        
    function goToSettings():void;
    
    function goToLoad():void;
    
    function goToMain():void;
}
}
