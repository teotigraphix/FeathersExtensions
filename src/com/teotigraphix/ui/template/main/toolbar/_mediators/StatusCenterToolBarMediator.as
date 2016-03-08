package com.teotigraphix.ui.template.main.toolbar._mediators
{

import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;
import com.teotigraphix.ui.template.main.toolbar.StatusCenterToolBar;

import feathers.data.ListCollection;

public class StatusCenterToolBarMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:StatusCenterToolBar;
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createStatusCenterToolsDataProvider(screenID);
    }
}
}