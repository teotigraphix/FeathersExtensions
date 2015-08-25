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

import com.teotigraphix.frameworks.project.Project;

import flash.filesystem.File;

public interface IProjectModel
{
    function get project():Project;

    function set project(value:Project):void;

    function get projectFile():File;

    function get projectDirectory():File;

    /**
     * The Project that is loading, will only be pushed to #project, when all operations
     * have completed successfully.
     */
    function get pendingProject():Project;

    function set pendingProject(value:Project):void;
}
}
