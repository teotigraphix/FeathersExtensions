package com.teotigraphix.ui.template.main.controls._mediators
{
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.ISaveStrategy;
import com.teotigraphix.model.event.CoreModelEventType;
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.main.controls.ProjectNameControl;

import starling.events.Event;

public class ProjectNameControlMediator extends AbstractMediator
{
    [Inject]
    public var view:ProjectNameControl;
    
    [Inject]
    public var projectModel:IProjectModel;
    
    [Inject]
    public var saveStrategy:ISaveStrategy;
    
    [Inject]
    public var commands:ICommandLauncher;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
        refreshView();
    }
    
    override protected function refreshView():void
    {
        view.nameLabel.text = projectModel.project.name;
        view.saveButton.isEnabled = saveStrategy.isDirty;
    }
    
    override protected function setupViewListeners():void
    {
        addViewListener(ProjectNameControl.EVENT_SAVE, view_saveHandler);
    }
    
    override protected function setupContextListeners():void
    {
        addContextListener(CoreModelEventType.IS_DIRTY_CHANGE, context_isDirtyChangeHandler);
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    private function view_saveHandler(event:Event):void
    {
        commands.saveProject();
    }
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
    private function context_isDirtyChangeHandler(event:Event, dirty:Boolean):void
    {
        view.saveButton.isEnabled = dirty;
    }
}
}
