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

package com.teotigraphix.service.support
{

import com.teotigraphix.service.*;
import com.teotigraphix.service.async.IStepCommand;

public class ApplicationService extends AbstractService implements IApplicationService
{
    public function ApplicationService()
    {
        super();
    }

    public function startupCoreServices():IStepCommand
    {
        var command:StartupCoreServicesCommand = new StartupCoreServicesCommand();
        injector.injectInto(command);
        return command;
    }
}
}

import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IPreferenceService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.support.FileServiceImpl;
import com.teotigraphix.service.support.PreferenceService;
import com.teotigraphix.service.support.ProjectService;

import org.as3commons.async.command.IAsyncCommand;

class StartupCoreServicesCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var fileService:IFileService;

    [Inject]
    public var preferenceService:IPreferenceService;

    [Inject]
    public var projectService:IProjectService;

    public function StartupCoreServicesCommand()
    {
    }

    override public function execute():*
    {
        logger.startup("StartupCoreServicesCommand", "execute()");

        //
        FileServiceImpl(fileService).startup();

        // load binary application preferences map
        PreferenceService(preferenceService).startup();

        // Nothing yet
        ProjectService(projectService).startup();

        complete(null);

        return null;
    }
}

