package com.teotigraphix.ui.core
{
import com.teotigraphix.core.sdk_internal;
import com.teotigraphix.frameworks.project.Project;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.ui.IUIState;
import com.teotigraphix.ui.template.main._mediators.data.ContentScreenItem;

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
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function AbstractUIState()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    
    override public function onStartup():void
    {
        super.onStartup();
        
        configureApplicationToolBarDataProvider(_applicationToolBarDataProvider);
    }
    
    //--------------------------------------------------------------------------
    // MainScreen Data
    //--------------------------------------------------------------------------
    
    public function contentScreenIndexToID(contentScreenIndex:int):String
    {
        for (var i:int = 0; i < _applicationToolBarDataProvider.length; i++) 
        {
            var item:ContentScreenItem = _applicationToolBarDataProvider.data[i] as ContentScreenItem;
            if (i == contentScreenIndex)
                return item.id;
        }
        return null;
    }
    
    public function createActionDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createContentToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createScreenToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createStatusLeftToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createStatusCenterToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    public function createStatusRightToolsDataProvider(screenID:String):ListCollection
    {
        return new ListCollection([]);
    }
    
    //--------------------------------------------------------------------------
    // Internal :: Methods
    //--------------------------------------------------------------------------
    
    /**
     * Subclasses override to create the application's left tool bar data provider.
     */
    protected function configureApplicationToolBarDataProvider(collection:ListCollection):void
    {
    }
    
    /**
     * Called by the ProjectConfigurator, new/load project.
     */
    sdk_internal function configure(project:Project, isNew:Boolean):void
    {
    }
}
}