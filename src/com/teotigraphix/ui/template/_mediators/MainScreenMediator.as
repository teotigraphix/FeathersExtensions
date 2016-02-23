
package com.teotigraphix.ui.template._mediators
{

import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.MainScreen;

import starling.events.Event;

public class MainScreenMediator extends AbstractMediator
{
    [Inject]
    public var view:MainScreen;
    
    [Inject]
    public var sreens:IScreenLauncher;    
    
    public function MainScreenMediator()
    {
    }

    override protected function initializeView():void
    {
    }
    
    override protected function setupContextListeners():void
    {

    }
    
    private function context_logStartupMessageHandler(event:Event, message:String):void
    {

    }
    
    override protected function setupViewListeners():void
    {

    }
    
    override public function onRegister():void
    {
        screenLauncher.contentNavigator = view.contentNavigator;
        
        super.onRegister();
        // TODO
//        switch(preferences.ui.selectedContentIndex)
//        {
//            case 0:
//                model.screens.goToContentClip();
//                break;
//            
//            case 1:
//                model.screens.gotToContentScene();
//                break;
//            
//            case 1:
//                model.screens.gotToContentRecordTake();
//                break;
//        }
    }
    
    override public function onRemove():void
    {
        screenLauncher.contentNavigator = null;
        
        super.onRemove();
    }
}
}
