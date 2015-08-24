/**
 * Created by Teoti on 4/2/2015.
 */
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
import com.teotigraphix.service.ILogger;
import com.teotigraphix.service.IPreferenceService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.support.FileService;
import com.teotigraphix.service.support.PreferenceService;
import com.teotigraphix.service.support.ProjectService;

import org.as3commons.async.command.IAsyncCommand;

class StartupCoreServicesCommand extends StepCommand implements IAsyncCommand
{
    [Inject]
    public var logger:ILogger;

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
        FileService(fileService).startup();

        // load binary application preferences map
        PreferenceService(preferenceService).startup();

        // Nothing yet
        ProjectService(projectService).startup();

        complete(null);

        return null;
    }
}
