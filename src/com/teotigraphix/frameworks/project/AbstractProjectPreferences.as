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

import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.util.Files;

import flash.filesystem.File;

public class AbstractProjectPreferences implements IProjectPreferences
{
    [Transient]
    [Inject]
    public var projectModel:IProjectModel;
    
    public function AbstractProjectPreferences()
    {
    }

    //--------------------------------------------------------------------------
    // Private :: Methods
    //--------------------------------------------------------------------------

    public function onPropertyChange():void
    {
        var resource:File = projectModel.project.getResource(".preferences");
        Files.serialize(this, resource);
    }
    
    public function getFileOrDefault(path:String, defaultLocation:File):File
    {
        if (path != null)
        {
            var test:File = new File(path);
            if (test.exists)
            {
                defaultLocation = test;
            }
        }
        return defaultLocation;
    }
}
}
