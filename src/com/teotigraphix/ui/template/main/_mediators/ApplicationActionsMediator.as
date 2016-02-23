package com.teotigraphix.ui.template.main._mediators
{
import com.teotigraphix.ui.IUIState;
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.main.ApplicationActions;
import com.teotigraphix.ui.template.main.controls.EditActionsList;

import feathers.controls.Callout;

import starling.events.Event;

public class ApplicationActionsMediator extends AbstractMediator
{
    [Inject]
    public var view:ApplicationActions;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
        addViewListener(ApplicationActions.EVENT_ACTION_TRIGGER, view_actionTriggeredHandler);

    }
    
    override protected function setupViewListeners():void
    {
    }
    
    override protected function setupContextListeners():void
    {
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    private var _callout:Callout;
    
    private function view_actionTriggeredHandler(event:Event):void
    {
        var content:EditActionsList = new EditActionsList();
        content.dataProvider = uiState.createActionDataProvider();
        content.addEventListener(EditActionsList.EVENT_SELECT, list_selectHandler);
        
        _callout = Callout.show(content, view.actionsButton);
        _callout.addEventListener(Event.CLOSE, callout_closeHandler);
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

    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
}
}
