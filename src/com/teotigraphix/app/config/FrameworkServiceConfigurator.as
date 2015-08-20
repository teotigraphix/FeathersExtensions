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

package com.teotigraphix.app.config
{

import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.support.FileService;
import com.teotigraphix.service.support.Logger;

import starling.animation.Juggler;

import starling.core.Starling;

public class FrameworkServiceConfigurator implements IConfigure
{
    public function configure(context:FrameworkContext):void
    {
        context.getInjector().mapValue(Juggler, Starling.juggler);
        context.getInjector().mapSingletonOf(ILogger, Logger);
        context.getInjector().mapSingletonOf(IFileService, FileService);
//        context.getInjector().mapSingletonOf(IPreferenceService, PreferenceService);
        //context.getInjector().mapSingletonOf(IProjectService, ProjectService);
        //context.getInjector().mapSingletonOf(IApplicationService, ApplicationService);

        //context.getMediatorMap().mapView(FileBrowser, FileBrowserMediator);
    }
}
}
