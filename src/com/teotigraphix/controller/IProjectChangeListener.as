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

package com.teotigraphix.controller
{

import com.teotigraphix.frameworks.project.Project;

/**
 * @see com.teotigraphix.controller.support.AbstractApplicationController
 */
public interface IProjectChangeListener
{
    /**
     * Called when a Project changes in the IProjectModel.
     *
     * @param project The new Project with IProjectState.
     * @param old The old Project.
     * @see com.teotigraphix.app.event.ApplicationEventType.PROJECT_CHANGED
     */
    function projectChanged(project:Project, old:Project):void;

    /**
     * Safe for models to access full application state, #projectChanged() has been called on
     * all listeners.
     *
     * @param project the current project.
     */
    function projectChangeComplete(project:Project):void;
}
}
