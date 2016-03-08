package com.teotigraphix.ui.template.main.controls._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.main.controls.ApplicationLogoControl;

import starling.events.Event;

public class ApplicationLogoControlMediator extends AbstractMediator
{
    [Inject]
    public var view:ApplicationLogoControl;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
    }
    
    override protected function setupViewListeners():void
    {
        addViewListener(ApplicationLogoControl.EVENT_LOGO_TRIGGER, view_logoTriggeredHandler);
    }
    
    override protected function setupContextListeners():void
    {
    }
    
    //--------------------------------------------------------------------------
    // View
    //--------------------------------------------------------------------------
    
    private function view_logoTriggeredHandler(event:Event):void
    {
        screenLauncher.goToSettings();
    }
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------

}
}
