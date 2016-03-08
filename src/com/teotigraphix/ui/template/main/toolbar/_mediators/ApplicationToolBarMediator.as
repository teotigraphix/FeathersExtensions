package com.teotigraphix.ui.template.main.toolbar._mediators
{
import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.main.toolbar.ApplicationToolBar;

public class ApplicationToolBarMediator extends AbstractMediator
{
    [Inject]
    public var view:ApplicationToolBar;

    public function ApplicationToolBarMediator()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override protected function initializeView():void
    {
    }
    
    override protected function refreshView():void
    {
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
    
    //--------------------------------------------------------------------------
    // Context
    //--------------------------------------------------------------------------

}
}