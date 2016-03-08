
package com.teotigraphix.ui.template._mediators
{

import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.MainScreen;
import com.teotigraphix.ui.template.main.controls.ToolBarTaBar;
import com.teotigraphix.ui.template.main.controls._mediators.ToolBarTaBarMediator;

import org.robotlegs.starling.core.IMediatorMap;

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
        
        var contentIndex:int = projectPreferencesProvider.provided.template.selectedContentIndex;
        screenLauncher.setContentScreenIndex(contentIndex);
    }

    override public function onRemove():void
    {
        screenLauncher.contentNavigator = null;
        
        super.onRemove();
    }
    
    public static function mapDependencies(mediatorMap:IMediatorMap):void 
    {
        mediatorMap.mapView(ToolBarTaBar, ToolBarTaBarMediator);        
    }
}
}
