package com.teotigraphix.controller.command.core
{

public class $_NewProjectCommand extends AbstractCommand
{
    public static const ID:String = "$_NewProjectCommand";
    
    override public function execute():void
    {
        sequence(new Result(event.data)).
            add(GetNameStep).
            add(NewProjectStep).
            execute();
    }
}
}
import com.teotigraphix.controller.command.file.LocationResult;
import com.teotigraphix.service.IFileService;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.dialog.GetStringDialog;
import com.teotigraphix.util.Files;

import flash.filesystem.File;

import org.as3commons.async.operation.event.OperationEvent;

final class Result extends LocationResult
{
    public var name:String;
    public var promptForName:Boolean;
    public var stringDialog:GetStringDialog;
    
    public function Result(data:Object)
    {
        super(File(data.file));
        this.name = data.name;
    }
}

//--------------------------------------------------------------------------
// Commands
//--------------------------------------------------------------------------

//----------------------------------
// NewProjectStep
//----------------------------------

final class GetNameStep extends StepCommand
{
    [Inject]
    public var ui:IUIController;
    
    [Inject]
    public var fileService:IFileService;
    
    override public function execute():*
    {
        const o:Result = data as Result;
        if (o.name != null)
        {
            complete();
            return null;
        }
        
        var nextName:String = Files.getBaseName(fileService.getNextUntitledProjectFile());
        o.stringDialog = ui.getString("Project name", nextName, this_yesHandler, this_noHandler);
        o.stringDialog.allowPromptAsText = true;
        
        return super.execute();
    }
    
    private function this_noHandler():void
    {
        (data as Result).stringDialog.hide();
        cancel();
    }
    
    private function this_yesHandler():void
    {
        const o:Result = data as Result;
        o.name = o.stringDialog.text;
        o.stringDialog.hide();
        complete();
    }
}

//----------------------------------
// NewProjectStep
//----------------------------------

final class NewProjectStep extends StepCommand
{
    [Inject]
    public var fileService:IFileService;
    
    [Inject]
    public var projectService:IProjectService;
    
    override public function execute():*
    {
        const o:Result = data as Result;
        var file:File = fileService.getProjectFile(o.name);
        var sequence:IStepSequence = projectService.createProjectAsync(file);
        sequence.addCompleteListener(this_completeHandler);
        sequence.execute();
        return super.execute();
    }
    
    private function this_completeHandler(event:OperationEvent):void
    {
        complete();
    }
}
