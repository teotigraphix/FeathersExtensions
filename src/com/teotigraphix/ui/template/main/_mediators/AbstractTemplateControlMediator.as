package com.teotigraphix.ui.template.main._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.event.ScreenLauncherEventType;

import feathers.data.ListCollection;

import starling.display.DisplayObjectContainer;
import starling.events.Event;

public class AbstractTemplateControlMediator extends AbstractMediator
{
    public function AbstractTemplateControlMediator()
    {
        super();
    }
    
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
        addContextListener(ScreenLauncherEventType.CONTENT_SCREEN_ID_CHANGED, 
            context_contentScreenIDChangedHandler);
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------
    
    private function context_contentScreenIDChangedHandler(event:Event, contentScreenID:String):void
    {
        //var screenID:String = uiState.contentScreenIndexToID(contentScreenIndex);
        redraw(contentScreenID);
    }
    
    protected function redraw(screenID:String):void
    {
        var parent:DisplayObjectContainer = getViewComponent() as DisplayObjectContainer;
        parent.removeChildren();
        
        var collection:ListCollection = createDataProvider(screenID);
        
        for (var i:int = 0; i < collection.length; i++) 
        {
            var item:Object = collection.getItemAt(i);
            parent.addChild(item.control);
        }
    }
    
    protected function createDataProvider(screenID:String):ListCollection
    {
        return null;
    }
}
}