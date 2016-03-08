package com.teotigraphix.ui.template.main.toolbar._mediators
{
import com.teotigraphix.ui.template.main.toolbar.StatusRightToolBar;

import feathers.data.ListCollection;
import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;

public class StatusRightToolBarMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:StatusRightToolBar;
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createStatusRightToolsDataProvider(screenID);
    }
}
}