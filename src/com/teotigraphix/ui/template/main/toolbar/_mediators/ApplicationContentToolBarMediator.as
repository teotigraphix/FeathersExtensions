package com.teotigraphix.ui.template.main.toolbar._mediators
{
import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;
import com.teotigraphix.ui.template.main.toolbar.ApplicationContentToolBar;

import feathers.data.ListCollection;


public class ApplicationContentToolBarMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:ApplicationContentToolBar;
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createContentToolsDataProvider(screenID);
    }
}
}


