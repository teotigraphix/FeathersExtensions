package com.teotigraphix.ui.template.main.controls._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.event.ScreenLauncherEventType;
import com.teotigraphix.ui.template.main.controls.ToolBarTaBar;

import starling.events.Event;

public class ToolBarTaBarMediator extends AbstractMediator
{
    [Inject]
    public var view:ToolBarTaBar;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
        refreshView();
    }
    
    override protected function refreshView():void
    {
        view.dataProvider = uiState.applicationToolBarDataProvider;
        view.selectedIndex = projectPreferencesProvider.provided.template.selectedContentIndex;
        view.validate();
    }
    
    override protected function setupViewListeners():void
    {
        addViewListener(Event.CHANGE, view_changeHandler);
    }
    
    override protected function setupContextListeners():void
    {
        addContextListener(ScreenLauncherEventType.SELECTED_CONTENT_INDEX_CHANGED, 
            context_selectedContentIndexChangedHandler);
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    private function view_changeHandler(event:Event, selectedIndex:int):void
    {
        projectPreferencesProvider.provided.template.selectedContentIndex = selectedIndex;
    }
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
    private function context_selectedContentIndexChangedHandler(event:Event, index:int):void
    {
        view.selectedIndex = index;
    }
}
}