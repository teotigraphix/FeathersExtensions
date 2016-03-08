package com.teotigraphix.ui.template.main.toolbar._mediators
{

import com.teotigraphix.ui.template.main._mediators.AbstractTemplateControlMediator;
import com.teotigraphix.ui.template.main.toolbar.StatusLeftToolBar;

import feathers.data.ListCollection;

public class StatusLeftToolBarMediator extends AbstractTemplateControlMediator
{
    [Inject]
    public var view:StatusLeftToolBar;
    
    override protected function createDataProvider(screenID:String):ListCollection
    {
        return uiState.createStatusLeftToolsDataProvider(screenID);
    }
}
}