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

package com.teotigraphix.frameworks.project
{

import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.service.async.IStepCommand;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepSequence;
import com.teotigraphix.util.ISerialize;

import org.robotlegs.starling.core.IInjector;

use namespace sdk_internal;

public class AbstractProjectState implements IProjectState, ISerialize
{
    //--------------------------------------------------------------------------
    // Public Inject :: Variables
    //--------------------------------------------------------------------------

    [Transient]
    [Inject]
    public var injector:IInjector;

    //--------------------------------------------------------------------------
    // Serialized API
    //--------------------------------------------------------------------------

    private var _project:Project;

    //--------------------------------------------------------------------------
    // Public :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // project
    //----------------------------------

    public function get project():Project
    {
        return _project;
    }

    public function set project(value:Project):void
    {
        _project = value;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function AbstractProjectState()
    {
    }

    //--------------------------------------------------------------------------
    // Public ISerialize :: Methods
    //--------------------------------------------------------------------------

    public function create():void
    {
    }

    public function wakeup():void
    {
    }

    public function sleep(preSleep:Boolean = false):void
    {
    }

    //--------------------------------------------------------------------------
    // Public :: Methods
    //--------------------------------------------------------------------------

    /**
     * Saves the state async, to call this command subclasses must impl createSaveStep().
     *
     * Note: The IProjectModel actually saves the Project, the Project calls this method.
     *
     * @return A presave and save sequence.
     * @see #createPreSaveStep()
     * @see #createSaveStep()
     * @see IProjectService
     */
    public function saveAsync():IStepSequence
    {
        var sequence:StepSequence = new StepSequence();
        var step1:IStepCommand = createPreSaveStep();
        if (step1 != null)
            sequence.addCommand(step1);
        var step2:IStepCommand = createSaveStep();
        sequence.addCommand(step2);
        return sequence;
    }

    /**
     * Optional, to save data before the save command runs.
     *
     * @see #saveAsync()
     */
    protected function createPreSaveStep():IStepCommand
    {
        return null;
    }

    /**
     * Required, the command that saves any data into the sate.
     *
     * @see #saveAsync()
     */
    protected function createSaveStep():IStepCommand
    {
        return null;
    }

    sdk_internal function setProject(value:Project):void
    {
        _project = value;
    }
}
}
