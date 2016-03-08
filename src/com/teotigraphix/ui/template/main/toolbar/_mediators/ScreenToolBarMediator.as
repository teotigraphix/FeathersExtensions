package com.teotigraphix.ui.template.main.toolbar._mediators
{
import com.teotigraphix.ui.template.main.toolbar.ScreenToolBar;

import feathers.data.ListCollection;
import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;

public class ScreenToolBarMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:ScreenToolBar;
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createScreenToolsDataProvider(screenID);
    }
}
}