package com.teotigraphix.model
{
import com.teotigraphix.app.configuration.ApplicationDescriptor;
import com.teotigraphix.app.configuration.IApplicationPermissions;

public interface ICoreModel
{
    function get descriptor():ApplicationDescriptor;
    
    function get permissions():IApplicationPermissions;
    
    function get projectModel():IProjectModel;
    
    function get saveStrategy():ISaveStrategy;
    
    //--------------------------------------------------------------------------
    // Methods
    //--------------------------------------------------------------------------
    

}
}