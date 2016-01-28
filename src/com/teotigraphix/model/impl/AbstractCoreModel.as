package com.teotigraphix.model.impl
{
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.frameworks.project.IProjectPreferences;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.model.ICoreModel;
import com.teotigraphix.model.IProjectModel;
import com.teotigraphix.ui.IUIController;
import com.teotigraphix.ui.screen.IScreenLauncher;

public class AbstractCoreModel extends AbstractModel implements ICoreModel
{
    [Inject]
    public var _descriptor:ApplicationDescriptor;
    
    [Inject]
    public var _applicationSettings:IApplicationSettings;
    
    [Inject]
    public var _screens:IScreenLauncher;
    
    [Inject]
    public var _commands:ICommandLauncher;
    
    [Inject]
    public var _ui:IUIController;
    
    [Inject]
    public var _projectModel:IProjectModel;
    
    protected var _preferences:IProjectPreferences;
    
    //--------------------------------------------------------------------------
    // API :: Properties
    //--------------------------------------------------------------------------
    
    //----------------------------------
    // descriptor
    //----------------------------------
    
    /**
     * @inheritDoc
     */
    public function get descriptor():ApplicationDescriptor
    {
        return _descriptor;
    }
    
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
    // ProjectPreferences
    //----------------------------------
    
    public function setPreferences(value:IProjectPreferences):void
    {
        _preferences = value;
    }
    
    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    
    public function AbstractCoreModel()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    // OVERIDDE IN SUBCLASS
    //--------------------------------------------------------------------------
    
//    /**
//     * @inheritDoc
//     */
//    public function get applicationSettings():ApplicationSettings
//    {
//        return _applicationSettings as ApplicationSettings;
//    }
//    
//    /**
//     * @inheritDoc
//     */
//    public function get screens():ScreenLauncher
//    {
//        return _screens as ScreenLauncher;
//    }
//    
//    /**
//     * @inheritDoc
//     */
//    public function get commands():CommandLauncher
//    {
//        return _commands as CommandLauncher;
//    }
//    
//    /**
//     * @inheritDoc
//     */
//    public function get ui():UIController
//    {
//        return _ui as UIController;
//    }

}
}