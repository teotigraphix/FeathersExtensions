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

use namespace sdk_internal;

public class AbstractProjectState implements IProjectState
{
    //--------------------------------------------------------------------------
    // Serialized API
    //--------------------------------------------------------------------------

    private var _project:Project;

    //--------------------------------------------------------------------------
    // Private :: Variables
    //--------------------------------------------------------------------------

    public function get project():Project
    {
        return _project;
    }

    public function set project(value:Project):void
    {
        _project = value;
    }

    public function AbstractProjectState()
    {
    }

    /**
     * Called when a new project has been created and state needs initialization.
     */
    public function initialize():void
    {
    }

    /**
     * called after a project has been deserialized and rack bytes are loaded.
     */
    public function wakeup():void
    {
    }

    protected function onProjectCreate():void
    {
    }

    sdk_internal function setProject(value:Project):void
    {
        _project = value;
        onProjectCreate();
    }
}
}
