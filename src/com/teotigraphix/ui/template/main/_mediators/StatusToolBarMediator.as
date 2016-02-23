package com.teotigraphix.ui.template.main._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.event.ScreenLauncherEventType;
import com.teotigraphix.ui.template.main.StatusToolBar;

import feathers.data.ListCollection;

import starling.events.Event;

public class StatusToolBarMediator extends AbstractMediator
{
    [Inject]
    public var view:StatusToolBar;

    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
        redraw(screenLauncher.contentScreenID);
    }
    
    override protected function setupViewListeners():void
    {
    }
    
    override protected function setupContextListeners():void
    {
        addContextListener(ScreenLauncherEventType.SELECTED_CONTENT_INDEX_CHANGED, 
            context_selectedContentIndexChangedHandler);
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
    private function context_selectedContentIndexChangedHandler(event:Event, screenID:String):void
    {
        redraw(screenID);
    }
    
    private function redraw(screenID:String):void
    {
        view.removeChildren();
        
        var collection:ListCollection = uiState.createStatusToolsDataProvider(screenID);
        
        for (var i:int = 0; i < collection.length; i++) 
        {
            var item:Object = collection.getItemAt(i);
            view.addChild(item.control);
        }
    }
}
}