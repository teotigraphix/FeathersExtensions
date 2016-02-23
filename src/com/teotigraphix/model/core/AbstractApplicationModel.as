package com.teotigraphix.model.core
{
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.app.configuration.IApplicationPermissions;
import com.teotigraphix.controller.ICommandLauncher;
import com.teotigraphix.model.AbstractModel;
import com.teotigraphix.model.IApplicationSettings;
import com.teotigraphix.ui.IScreenLauncher;
import com.teotigraphix.ui.IUIController;

public class AbstractApplicationModel extends AbstractModel
{
    [Inject]
    public var _descriptor:ApplicationDescriptor;
    
    [Inject]
    public var _permissions:IApplicationPermissions;
    
    [Inject]
    public var _applicationSettings:IApplicationSettings;
    
    [Inject]
    public var _screens:IScreenLauncher;
    
    [Inject]
    public var _commands:ICommandLauncher;
    
    [Inject]
    public var _ui:IUIController;
    
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
    // permissions
    //----------------------------------
    
    /**
     * @inheritDoc
     */
    public function get permissions():IApplicationPermissions
    {
        return _permissions;
    }
    
    public function AbstractApplicationModel()
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