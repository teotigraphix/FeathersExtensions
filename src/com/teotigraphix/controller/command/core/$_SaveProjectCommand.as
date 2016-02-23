package com.teotigraphix.controller.command.core
{

[ExcludeClass]
public class $_SaveProjectCommand extends AbstractCommand
{
    public static const ID:String = "$_SaveProjectCommand";
    
    override public function execute():void
    {
        sequence({}).
            addStep(SaveProjectStep).
            execute();
    }
}
}
import com.teotigraphix.model.ISaveStrategy;
import com.teotigraphix.service.IProjectService;
import com.teotigraphix.service.async.IStepSequence;
import com.teotigraphix.service.async.StepCommand;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.dialog.ProgressDialog;

import org.as3commons.async.operation.event.OperationEvent;

class SaveProjectStep extends StepCommand
{
    private var _progressDialog:ProgressDialog;
    
    [Inject]
    public var projectService:IProjectService;
    
    [Inject]
    public var ui:IUIController;
    
    [Inject]
    public var saveStrategy:ISaveStrategy;
    
    override public function execute():*
    {
        logger.log("SaveProjectStep", "execute()");
        //model.sound.isPlaying = false;
        
        _progressDialog = ui.progress("Saving project...");
        
        var sequence:IStepSequence = saveStrategy.saveAsync();
        sequence.addCompleteListener(this_completeHandler);
        sequence.execute();
        
        return super.execute();
    }
    
    private function this_completeHandler(event:OperationEvent):void
    {
        logger.log("SaveProjectStep", "Complete");
        
        _progressDialog.hide();
        _progressDialog = null;
        
        finished();
    }
}