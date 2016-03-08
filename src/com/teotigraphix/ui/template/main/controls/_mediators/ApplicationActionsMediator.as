package com.teotigraphix.ui.template.main.controls._mediators
{
import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;
import com.teotigraphix.ui.template.main.controls.ApplicationActions;
import com.teotigraphix.ui.template.main.controls.EditActionsList;

import feathers.controls.Callout;
import feathers.data.ListCollection;

import starling.events.Event;

public class ApplicationActionsMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:ApplicationActions;
    
    private var _callout:Callout;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
        super.initializeView();
    }
    
    override protected function setupViewListeners():void
    {
        super.setupViewListeners();
        addViewListener(ApplicationActions.EVENT_ACTION_TRIGGER, view_actionTriggeredHandler);
    }
    
    override protected function setupContextListeners():void
    {
        super.setupContextListeners();
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    private function view_actionTriggeredHandler(event:Event):void
    {
        var content:EditActionsList = new EditActionsList();
        content.dataProvider = createDataProvider(screenLauncher.contentScreenID);
        content.addEventListener(EditActionsList.EVENT_SELECT, list_selectHandler);
        
        _callout = Callout.show(content, view.actionsButton);
        _callout.addEventListener(Event.CLOSE, callout_closeHandler);
    }
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    // Internal
    //--------------------------------------------------------------------------
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createActionDataProvider(screenLauncher.contentScreenID)
    }
    
    override protected function redraw(screenID:String):void
    {
    }

    private function list_selectHandler(event:Event, item:Object):void
    {
        item.command();
        
        _callout.close(true);
    }
    
    private function callout_closeHandler(event:Event):void
    {
        event.target.removeEventListener(Event.CLOSE, callout_closeHandler);
        view.actionsButton.isSelected = false;
    }
}
}
