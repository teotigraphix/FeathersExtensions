package com.teotigraphix.app.command
{
import com.teotigraphix.service.async.IStepCommand;

import org.as3commons.async.command.ICommand;

public interface IStartupFactory
{
    function createResult():StartupResult;
    
    function createDebugSetupCommand():IStepCommand;
    
    function createPauseForUICreationCompleteCommand():ICommand;
    
    function createPrintAppVersionCommand():IStepCommand;
    
    function createStartCoreServicesCommand():IStepCommand;
    
    function createControllerStarupCommand():IStepCommand;
}
}