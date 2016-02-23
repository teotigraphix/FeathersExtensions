package com.teotigraphix.controller.command.core
{

[ExcludeClass]
public class $_LoadProjectCommand extends AbstractCommand
{
    public static const ID:String = "$_LoadProjectCommand";
    
    override public function execute():void
    {
        sequence(new Result(event.data)).
            add(BrowseForProjectFileStep).
            add(LoadProjectStep).
            execute();
    }
}
}
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.controller.command.file.LocationResult;
import com.teotigraphix.controller.command.file.__BrowseWithFileDialogStep;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.component.file.FileListData;

import flash.filesystem.File;

import org.as3commons.async.operation.event.OperationEvent;

import starling.events.Event;

final class Result extends LocationResult
{
    public function Result(data:Object)
    {
        super(File(data.file));
    }
}

//--------------------------------------------------------------------------
// Commands
//--------------------------------------------------------------------------

//----------------------------------
// BrowseForProjectFileStep
//----------------------------------

final class BrowseForProjectFileStep extends __BrowseWithFileDialogStep
{
    [Inject]
    public var applicationDescriptor:ApplicationDescriptor;
    
    [Inject]
    public var applicationSettings:IApplicationSettings;
    
    override protected function createData():FileListData
    {
        var data:FileListData = new FileListData();
        data.title = "Select ." + applicationDescriptor.extension + " file";
        data.directoryDoubleTapEnabled = false;
        data.homeDirectory = File.documentsDirectory;
        data.rootDirectory = applicationSettings.projectBrowseDirectory;
        data.extensions = [applicationDescriptor.extension];
        return data;
    }
    
    override protected function stateChanged(file:File, directory:File):void
    {
        isYesEnabled = false;
        isNoEnabled = true;
        if (file != null && !file.isDirectory)
        {
            currentFile = file;
            isYesEnabled = true;
        }
    }
    
    override protected function view_yesHandler(event:Event, file:File):void
    {
        applicationSettings.projectBrowseDirectory = currentFile.parent;
        super.view_yesHandler(event, file);
    }
    
    override protected function view_noHandler(event:Event, file:File):void
    {
        if (currentFile != null)
        {
            applicationSettings.projectBrowseDirectory = currentFile.parent;
        }
        super.view_noHandler(event, file);
    }
}

//----------------------------------
// LoadProjectStep
//----------------------------------

final class LoadProjectStep extends StepCommand
{
    [Inject]
    public var projectService:IProjectService;
    
    override public function execute():*
    {
        var o:Result = data as Result;
        var sequence:IStepSequence = projectService.loadProjectAsync(o.file);
        sequence.addCompleteListener(this_completeHandler);
        sequence.execute();
        return super.execute();
    }
    
    private function this_completeHandler(event:OperationEvent):void
    {
        complete();
    }
}
