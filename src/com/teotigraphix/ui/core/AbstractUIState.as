package com.teotigraphix.ui.core
{
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.ui.IUIState;

import feathers.data.ListCollection;

public class AbstractUIState extends AbstractModel implements IUIState
{
    private var _applicationToolBarDataProvider:ListCollection = new ListCollection();
    
    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // applicationToolBarDataProvider
    //----------------------------------
    
    public function get applicationToolBarDataProvider():ListCollection
    {
        return _applicationToolBarDataProvider;
    }
    
    public function AbstractUIState()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    // MainScreen Data
    //--------------------------------------------------------------------------
    
    public function createActionDataProvider():ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createScreenToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createTransportToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createStatusToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    override public function onStartup():void
    {
        super.onStartup();
        
        configureApplicationToolBarDataProvider(_applicationToolBarDataProvider);
    }
    
    protected function configureApplicationToolBarDataProvider(collection:ListCollection):void
    {
    }
    
    sdk_internal function configure(project:Project, isNew:Boolean):void
    {
    }
}
}