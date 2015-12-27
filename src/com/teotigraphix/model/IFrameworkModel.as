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

import com.teotigraphix.app.config.ApplicationDescriptor;
import com.teotigraphix.controller.IActionManager;
import com.teotigraphix.ui.IUIController;

public interface IFrameworkModel extends IProjectModel, IDeviceModel
{
    function get descriptor():ApplicationDescriptor;

    function get actions():IActionManager;

    /**
     * The current data object
     */
    function get screenData():*;

    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------

    function saveQuick():void;

    //function saveProjectAsync():IStepSequence;

    function getApplicationSettings():IApplicationSettings;

    function getUI():IUIController;

    /**
     * Retrieves a stateless application runtime property.
     *
     * @param name The property key.
     */
    function getProperty(name:String):*;

    /**
     * Retrieves a stateless application runtime property and removes it.
     *
     * @param name The property key.
     */
    function clearProperty(name:String):*;

    /**
     * Sets a stateless application runtime property.
     *
     * @param name The property key.
     * @param value The property value.
     */
    function setProperty(name:String, value:*):void;

    // function back():void;
    // function backTo(screenID:String):void;
}
}
