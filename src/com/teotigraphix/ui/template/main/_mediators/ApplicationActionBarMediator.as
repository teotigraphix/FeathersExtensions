
package com.teotigraphix.ui.template.main._mediators
{

import com.teotigraphix.ui.core.AbstractMediator;
import com.teotigraphix.ui.template.main.ApplicationActionBar;

public class ApplicationActionBarMediator extends AbstractMediator
{
    [Inject]
    public var view:ApplicationActionBar;

    override public function onRegister():void
    {
        super.onRegister();
    }

    override protected function initializeView():void
    {
    }

    override protected function setupViewListeners():void
    {
    }

    override protected function setupContextListeners():void
    {
    }
}
}
