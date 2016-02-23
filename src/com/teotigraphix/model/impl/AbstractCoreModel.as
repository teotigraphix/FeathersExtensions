package com.teotigraphix.model.impl
{
import com.teotigraphix.frameworks.project.IProjectPreferencesProvider;
import com.teotigraphix.frameworks.project.IProjectStateProvider;
import com.teotigraphix.model.ICoreModel;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.model.ISaveStrategy;
import com.teotigraphix.model.core.AbstractApplicationModel;

public class AbstractCoreModel extends AbstractApplicationModel implements ICoreModel
{
    [Inject]
    public var _projectModel:IProjectModel;
    
    [Inject]
    public var _saveStrategy:ISaveStrategy;
    
    [Inject]
    public var _projectPreferencesProvider:IProjectPreferencesProvider;
    
    [Inject]
    public var _projectStateProvider:IProjectStateProvider;
    
    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------

    //----------------------------------
    // projectModel
    //----------------------------------
    
    /**
     * @inheritDoc
     */
    public function get projectModel():IProjectModel
    {
        return _projectModel;
    }
    
    //----------------------------------
    // saveStrategy
    //----------------------------------
    
    /**
     * @inheritDoc
     */
    public function get saveStrategy():ISaveStrategy
    {
        return _saveStrategy;
    }

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function AbstractCoreModel()
    {
        super();
    }
}
}