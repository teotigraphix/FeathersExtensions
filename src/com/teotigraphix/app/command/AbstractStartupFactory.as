package com.teotigraphix.app.command
{
import com.teotigraphix.service.async.IStepCommand;

import org.as3commons.async.command.ICommand;
import org.robotlegs.starling.core.IInjector;

public class AbstractStartupFactory implements IStartupFactory
{
    [Inject]
    public var injector:IInjector;

    public function AbstractStartupFactory()
    {
    }
    
    /**
     * Can override to add properties to the startup result.
     */
    public function createResult():StartupResult
    {
        return new StartupResult();
    }
    
    public function createDebugSetupCommand():IStepCommand
    {
        return injector.instantiate(SetupDebugCommand);
    }

    public function createPauseForUICreationCompleteCommand():ICommand
    {
        return injector.instantiate(PauseForUICreationCompleteCommand);
    }
    
    public function createPrintAppVersionCommand():IStepCommand
    {
        return injector.instantiate(PrintAppVersionStep);
    }
    
    public function createStartCoreServicesCommand():IStepCommand
    {
        return injector.instantiate(StartupCoreServicesCommand);
    }
    
    public function createControllerStarupCommand():IStepCommand
    {
        return injector.instantiate(ControllerStarupCommand);
    }
}
}
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.impl.AbstractApplicationSettings;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.service.impl.FileServiceImpl;

import starling.core.Starling;

class PauseForUICreationCompleteCommand extends StepCommand
{
    override public function execute():*
    {
        logger.startup("PauseForUICreationCompleteCommand", "Pausing for creationComplete");
        complete();
        return null;
    }
}

class PrintAppVersionStep extends StepCommand
{
    [Inject]
    public var descriptor:ApplicationDescriptor;
    
    public function PrintAppVersionStep()
    {
    }
    
    override public function execute():*
    {
        logger.startup("App VERSION", "V {0}", descriptor.version.toString());
        complete();
        return null;
    }
}

final class SetupDebugCommand extends StepCommand
{
    [Inject]
    public var descriptor:ApplicationDescriptor;
    
    override public function execute():*
    {
        if (descriptor.isDebug)
        {
            logger.startup("SetupDebugCommand", "Debug mode on");
            Starling.current.showStatsAt();
        }
        else
        {
            logger.startup("SetupDebugCommand", "Debug mode off");
        }
        
        complete();
        return super.execute();
    }
}

class StartupCoreServicesCommand extends StepCommand
{
    [Inject]
    public var fileService:IFileService;
    
    [Inject]
    public var applicationSettings:IApplicationSettings;

    public function StartupCoreServicesCommand()
    {
    }
    
    override public function execute():*
    {
        logger.startup("StartupCoreServicesCommand", "execute()");
        
        // Creates the Documents/Application directory
        FileServiceImpl(fileService).startup();
        
        // Loads/creates binary application preferences map from fileService.preferenceBinFile
        AbstractApplicationSettings(applicationSettings).startup();

        complete();
        
        return null;
    }
}

final class ControllerStarupCommand extends StepCommand
{
    override public function execute():*
    {
        logger.startup("CreateControllerStarupCommand", "excute");
        eventDispatcher.dispatchEventWith(ApplicationEventType.CONTROLLER_STARTUP);
        complete();
        return super.execute();
    }
}
