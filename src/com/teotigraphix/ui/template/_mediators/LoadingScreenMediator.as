
package com.teotigraphix.ui.template._mediators
{

import com.teotigraphix.app.event.ApplicationEventType;
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.LoadingScreen;

import starling.events.Event;

public class LoadingScreenMediator extends AbstractMediator
{
    [Inject]
    public var view:LoadingScreen;

    public function LoadingScreenMediator()
    {
    }

    override protected function initializeView():void
    {
        view.imageLoader.source = "images/loading-800.png";
        view.loadingLabel.text = "Loading...";
    }
    
    override protected function setupContextListeners():void
    {
        addContextListener(ApplicationEventType.LOG_STARTUP_MESSAGE, context_logStartupMessageHandler);
    }
    
    private function context_logStartupMessageHandler(event:Event, message:String):void
    {
        view.loadingLabel.text = message;
    }
    
    override protected function setupViewListeners():void
    {

    }

    override public function onRemove():void
    {
        super.onRemove();
    }
}
}
