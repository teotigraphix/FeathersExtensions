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

package com.teotigraphix.service
{

import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.service.async.IStepSequence;

import flash.filesystem.File;

public interface IProjectService
{
    /**
     * @param file The nativePath without exteniosn of the new project.
     */
    function createProjectAsync(file:File):IStepSequence;
    
    /**
     * The 'complete' result is a ProjectServiceResult with the newly created or loaded Project
     * from disk. The 'error' result is a ProjectError.
     * 
     * @see OperationEvent.COMPLETE
     * @see com.teotigraphix.frameworks.errors.ProjectError.FILE_DOES_NOT_EXIST
     */
    function loadLastProjectAsync():IStepSequence;

    /**
     * Loads a Project file using the serialize file.
     * @param file The serialized file that resiseds within the same named directory.
     */
    function loadProjectAsync(file:File):IStepSequence;
    
    /**
     * Saves the Project and ProjectState to disk.
     * 
     * @param project The Project to save.
     * @see OperationEvent.COMPLETE
     * @see com.teotigraphix.frameworks.errors.ProjectError.PROJECT_NOT_SAVED 
     */
    function saveAsync(project:Project):IStepSequence;
}
}
