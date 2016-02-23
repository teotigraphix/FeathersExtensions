package com.teotigraphix.ui.template.main._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.event.ScreenLauncherEventType;
import com.teotigraphix.ui.template.main.ApplicationToolBar;

import starling.events.Event;

public class ApplicationToolBarMediator extends AbstractMediator
{
    [Inject]
    public var view:ApplicationToolBar;

    public function ApplicationToolBarMediator()
    {
        super();
    }
    
    override protected function initializeView():void
    {
        view.tabBar.dataProvider = uiState.applicationToolBarDataProvider;
        view.tabBar.selectedIndex = projectPreferencesProvider.provided.template.selectedContentIndex;
        view.tabBar.validate();
    }
    
    override protected function setupViewListeners():void
    {
        addViewListener(ApplicationToolBar.EVENT_TAB_CHANGE, view_tabChangedHandler);
    }
    
    override protected function setupContextListeners():void
    {
        addContextListener(ScreenLauncherEventType.SELECTED_CONTENT_INDEX_CHANGED, 
            context_selectedContentIndexChangedHandler);
    }
    
    private function context_selectedContentIndexChangedHandler(event:Event, index:int):void
    {
        view.tabBar.selectedIndex = index;
    }
    
    private function view_tabChangedHandler(event:Event, selectedIndex:int):void
    {
        projectPreferencesProvider.provided.template.selectedContentIndex = selectedIndex;
    }
}
}